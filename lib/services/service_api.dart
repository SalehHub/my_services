import '../my_services.dart';

class ServiceApi {
  // static const ServiceApi _s = ServiceApi._();
  // factory ServiceApi() => _s;
  // const ServiceApi._();
  //
  const ServiceApi();

  //
  static Dio dio = Dio();
  static String domain = '';

  Future<String> download(String url) async {
    String ext = extension(url);
    String fileName = MyServices.helpers.getMd5(url);
    String savePath = "${await MyServices.helpers.getApplicationDocumentsPath() ?? ""}/$fileName.$ext";
    logger.i(savePath);
    await dio.download(url, savePath);
    return savePath;
  }

  Options _dioOptions(String? accessToken, String? lang, {String method = 'POST', Map<String, dynamic> extraHeaders = const {}}) {
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

    logger.i(headers);
    logger.i(method);

    return Options(
      method: method,
      headers: headers,
      contentType: 'application/json',
    );
  }

  Future<Response<Map<String, dynamic>>> postRequest(String url, {dynamic formData, Map<String, dynamic> extraHeaders = const {}, CancelToken? cancelToken}) async {
    final String? accessToken;
    final String? lang;
    if (formData is FormData) {
      accessToken = formData.fields.firstWhere((element) => element.key == 'accessToken').value;
      lang = formData.fields.firstWhere((element) => element.key == 'appLang').value;
      logger.d(formData.fields);
    } else {
      accessToken = formData['accessToken'] as String?;
      lang = formData['appLang'] as String?;
      logger.d(formData);
    }

    logger.i('$domain$url');
    final Response<Map<String, dynamic>> data = await dio.postUri<Map<String, dynamic>>(
      Uri.parse('$domain$url'),
      data: formData,
      cancelToken: cancelToken,
      options: _dioOptions(accessToken, lang, extraHeaders: extraHeaders),
    );
    return data;
  }

  Future<Response<T>> getRequest<T>(String url, {dynamic formData, Map<String, dynamic> extraHeaders = const {}, CancelToken? cancelToken}) async {
    final String? accessToken;
    final String? lang;
    if (formData is FormData) {
      accessToken = formData.fields.firstWhere((element) => element.key == 'accessToken').value;
      lang = formData.fields.firstWhere((element) => element.key == 'appLang').value;
      logger.d(formData.fields);
    } else {
      accessToken = formData['accessToken'] as String?;
      lang = formData['appLang'] as String?;
      logger.d(formData);
    }

    logger.i('$domain$url');
    final Response<T> data = await dio.getUri<T>(
      Uri.parse('$domain$url'),
      cancelToken: cancelToken,
      options: _dioOptions(accessToken, lang, method: 'GET', extraHeaders: extraHeaders),
    );
    return data;
  }
}
