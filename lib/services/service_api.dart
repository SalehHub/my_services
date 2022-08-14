import '../my_services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ServiceApi {
  // static const ServiceApi _s = ServiceApi._();
  // factory ServiceApi() => _s;
  // const ServiceApi._();
  //
  const ServiceApi();

  static final Map<String, CancelToken> cancelTokens = {};

  //
  static final Dio dio = Dio();
  static String _domain = '';

  static bool _enableEndpointLog = true;
  static bool _enableResponseLog = true;
  static bool _enableHeadersLog = true;
  static bool _enableFormDataLog = true;
  void disableEndpointLog() => _enableEndpointLog = false;
  void disableResponseLog() => _enableResponseLog = false;
  void disableHeadersLog() => _enableHeadersLog = false;
  void disableFormDataLog() => _enableFormDataLog = false;

  String get domain => _domain;
  void setDoamin(String domain) => _domain = domain;

  Future<String> download(String url) async {
    String ext = extension(url);
    String fileName = MyServices.helpers.getMd5(url);
    String savePath = "${await MyServices.helpers.getApplicationDocumentsPath() ?? ""}/$fileName.$ext";
    logger.d(savePath);
    await dio.download(url, savePath);
    return savePath;
  }

  Options _dioOptions(dynamic formData, {String method = 'POST', Map<String, dynamic> extraHeaders = const {}}) {
    //get access token and language to create authorization headers
    String? accessToken;
    String? lang;
    if (formData is FormData) {
      accessToken = formData.fields.firstWhere((element) => element.key == 'accessToken').value;
      lang = formData.fields.firstWhere((element) => element.key == 'appLang').value;
    } else {
      accessToken = formData['accessToken'] as String?;
      lang = formData['appLang'] as String?;
    }

    Map<String, dynamic> headers = <String, dynamic>{
      if (accessToken != null) ...{
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      },
      if (lang != null) ...{
        'X-Localization': lang,
      },
      ...extraHeaders
    };

    if (_enableHeadersLog) {
      logger.d(headers);
    }

    return Options(
      method: method,
      headers: headers,
      contentType: 'application/json',
    );
  }

  String getCacheKey(String url, {dynamic formData, Map<String, dynamic>? headers}) {
    String cacheKey = (url) + (formData?.toString() ?? 'noData') + (headers?.toString() ?? 'noData');

    return MyServices.helpers.getMd5(cacheKey);
  }

  Future<Map<String, dynamic>?> getCache(String url, {int cacheMinutes = 5, dynamic formData, Map<String, dynamic> headers = const {}}) async {
    String cacheKey = getCacheKey(url, formData: formData, headers: headers);
    return await MyServices.storage.get(cacheKey, cacheMinutes);
  }

  Future<bool> setCache(Map<String, dynamic> data, String url, {int cacheMinutes = 5, dynamic formData, Map<String, dynamic> headers = const {}}) async {
    String cacheKey = getCacheKey(url, formData: formData, headers: headers);
    return await MyServices.storage.set(cacheKey, data);
  }

  Future<bool> deleteCache(String url, {dynamic formData, Map<String, dynamic> headers = const {}}) {
    String cacheKey = getCacheKey(url, formData: formData, headers: headers);
    return MyServices.storage.delete(cacheKey);
  }

  dynamic getFormData(dynamic formData) {
    //check if form data has file
    bool isFile = false;
    for (Object? value in formData.values) {
      if (value.runtimeType == MultipartFile) {
        isFile = true;
      }
    }

    //if form data has file convert form data to map
    if (isFile == true) {
      formData = FormData.fromMap(<String, dynamic>{
        ...formData,
      });
    }

    return formData;
  }

  Future<Map<String, dynamic>?> postRequest(
    String url, {
    //
    dynamic formData,
    Map<String, dynamic> headers = const {},
    //
    bool cancelPrevious = true,
    //cache
    bool withCache = false,
    int cacheMinutes = 5,
    //tries
    int currentTry = 1,
    int tries = 6,
    //
  }) async {
    return request(
      url,
      "POST",
      formData: formData,
      headers: headers,
      cancelPrevious: cancelPrevious,
      withCache: withCache,
      cacheMinutes: cacheMinutes,
      currentTry: currentTry,
      tries: tries,
    );
  }

  Future<Map<String, dynamic>?> getRequest(
    String url, {
    //
    dynamic formData,
    Map<String, dynamic> headers = const {},
    //
    bool cancelPrevious = true,
    //cache
    bool withCache = false,
    int cacheMinutes = 5,
    //tries
    int currentTry = 1,
    int tries = 6,
    //
  }) async {
    return request(
      url,
      "GET",
      formData: formData,
      headers: headers,
      cancelPrevious: cancelPrevious,
      withCache: withCache,
      cacheMinutes: cacheMinutes,
      currentTry: currentTry,
      tries: tries,
    );
  }

  Future<Map<String, dynamic>?> request(
    String url,
    String requestType, {
    //
    dynamic formData,
    Map<String, dynamic> headers = const {},
    //
    bool cancelPrevious = true,
    //cache
    bool withCache = false,
    int cacheMinutes = 5,
    //tries
    int currentTry = 1,
    int tries = 6,
    //
  }) async {
    if (_enableEndpointLog) {
      logger.d('$requestType: $_domain$url');
    }

    if (cancelPrevious) {
      cancelTokens[url]?.cancel();
    }
    cancelTokens[url] = CancelToken();

    formData = getFormData(formData);

    if (_enableFormDataLog) {
      logger.d(formData);
    }

    //cache
    Map<String, dynamic>? data;
    if (withCache) {
      // data = null;
      data = await getCache(url, cacheMinutes: cacheMinutes, formData: formData, headers: headers);

      //fake wait if cache exist
      if (data != null) {
        logger.d("FromCache");
        await MyServices.helpers.waitForSeconds(1);
      }
      //
    } else {
      deleteCache(url, formData: formData, headers: headers);
    }

    if (data != null) {
      return data;
    }

    try {
      Response<Map<String, dynamic>> res = await dio.requestUri<Map<String, dynamic>>(
        Uri.parse('$_domain$url'),
        data: formData,
        cancelToken: cancelTokens[url],
        options: _dioOptions(formData, extraHeaders: headers, method: requestType),
      );

      if (_enableResponseLog) {
        logger.d(res.data);
      }

      //cache if withCache = true and data not null
      if (res.data != null && withCache == true) {
        await setCache(res.data!, url, formData: formData, headers: headers);
      }

      return res.data;
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.cancel) {
        logger.d("Dio request canceled");
      } else {
        logger.e(e, e, s);

        if (currentTry == 1) {
          await _handleNoInternet(e);
        }

        if (currentTry != tries) {
          await MyServices.helpers.waitForSeconds(5 + currentTry);
          return await request(
            url,
            requestType,
            formData: formData,
            headers: headers,
            cancelPrevious: cancelPrevious,
            withCache: withCache,
            cacheMinutes: cacheMinutes,
            currentTry: currentTry + 1,
            tries: tries,
          );
        }
      }
    }

    return null;
  }

  Future<bool> _handleNoInternet(DioError e) async {
    if (e.message.contains("SocketException")) {
      http.Response? response;
      try {
        response = await http.get(Uri.parse('https://google.com'));
      } on SocketException catch (_) {
        //
      }

      if (response?.statusCode == 200) {
        MyServices.services.snackBar.showText(
          // ignore: use_build_context_synchronously
          text: getMyServicesLabels(MyServices.context).weAreSorryOurServersAreNotRespondingAtThisTimePleaseTryAgainLater,
          success: false,
        );
      } else {
        MyServices.services.snackBar.showText(
          // ignore: use_build_context_synchronously
          text: getMyServicesLabels(MyServices.context).noInternetConnection,
          success: false,
        );
        return true;
      }
    }

    return false;
  }
}
