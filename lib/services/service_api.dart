import '../my_services.dart';

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
    logger.i(savePath);
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
      logger.i(headers);
    }

    return Options(
      method: method,
      headers: headers,
      contentType: 'application/json',
    );
  }

  String getCacheKey(String url, {Map<String, dynamic>? formData, Map<String, dynamic>? headers}) {
    String cacheKey = //
        (url) + //
            (formData?.toString() ?? 'noData') + //
            (headers?.toString() ?? 'noData') + //
            // (state.user?.id.toString() ?? "guest") + //
            (MyServices.providers.readLocale?.languageCode ?? "noLang") + //
            (MyServices.providers.readAppBuild ?? "1");

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

  Future<void> deleteCache(String url, {dynamic formData, Map<String, dynamic> headers = const {}}) {
    String cacheKey = getCacheKey(url, formData: formData, headers: headers);
    return MyServices.storage.delete(cacheKey);
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
    //
  }) async {
    if (_enableEndpointLog) {
      logger.i('POST: $_domain$url');
    }

    if (cancelPrevious) {
      cancelTokens[url]?.cancel();
    }
    cancelTokens[url] = CancelToken();

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

    if (_enableFormDataLog) {
      logger.d(formData);
    }

    //cache
    Map<String, dynamic>? data;
    if (withCache) {
      // data = null;
      data = await getCache(url, formData: formData, headers: headers);

      //fake wait if cache exist
      if (data != null) {
        logger.i("FromCache");
        await MyServices.helpers.waitForSeconds(1);
      }
      //
    } else {
      deleteCache(url, formData: formData, headers: headers);
    }

    if (data != null) {
      return data;
    }

    final Response<Map<String, dynamic>> res = await dio.postUri<Map<String, dynamic>>(
      Uri.parse('$_domain$url'),
      data: formData,
      cancelToken: cancelTokens[url],
      options: _dioOptions(formData, extraHeaders: headers),
    );

    if (_enableResponseLog) {
      logger.i(res.data);
    }

    //cache if withCache = true and data not null
    if (res.data != null && withCache == true) {
      await setCache(res.data!, url, formData: formData, headers: headers);
    }

    return res.data;
  }

  Future<Response<T>> getRequest<T>(
    String url, {
    dynamic formData,
    Map<String, dynamic> extraHeaders = const {},
    bool cancelPrevious = true,
  }) async {
    if (_enableEndpointLog) {
      logger.i('GET: $_domain$url');
    }

    if (cancelPrevious) {
      cancelTokens[url]?.cancel();
    }
    cancelTokens[url] = CancelToken();

    final Response<T> data = await dio.getUri<T>(
      Uri.parse('$_domain$url'),
      cancelToken: cancelTokens[url],
      options: _dioOptions(formData, method: 'GET', extraHeaders: extraHeaders),
    );

    if (_enableResponseLog) {
      logger.i(data);
    }

    return data;
  }
}
