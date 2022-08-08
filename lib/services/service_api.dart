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

  Future<Response<Map<String, dynamic>>> postRequest(
    String url, {
    dynamic formData,
    Map<String, dynamic> extraHeaders = const {},
    bool cancelPrevious = true,
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

    final Response<Map<String, dynamic>> data = await dio.postUri<Map<String, dynamic>>(
      Uri.parse('$_domain$url'),
      data: formData,
      cancelToken: cancelTokens[url],
      options: _dioOptions(formData, extraHeaders: extraHeaders),
    );

    if (_enableResponseLog) {
      logger.i(data);
    }

    return data;
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
