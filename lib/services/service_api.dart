import '../my_services.dart';

class ServiceApi {
  static final Dio dio = Dio();
  static String domain = '';

  static Future<String> download(String url) async {
    String ext = extension(url);
    String fileName = Helpers.getMd5(url);
    String savePath = (await Helpers.getApplicationDocumentsPath() ?? "") + "/" + fileName + ".$ext";
    logger.i(savePath);
    await dio.download(url, savePath);
    return savePath;
  }

  static Options _dioOptions(String? accessToken, String? lang) {
    Map<String, dynamic> headers = <String, dynamic>{
      if (accessToken != null) ...{
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      },
      if (lang != null) ...{
        'X-Localization': lang,
      },
    };

    return Options(
      method: 'POST',
      headers: headers,
      contentType: 'application/json',
    );
  }

  static Future<Response<Map<String, dynamic>>> postRequest(String url, dynamic formData, CancelToken? cancelToken) async {
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
      options: _dioOptions(accessToken, lang),
    );
    return data;
  }

  static Future<Response<T>> getRequest<T>(String url, dynamic formData, CancelToken? cancelToken) async {
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
      options: _dioOptions(accessToken, lang),
    );
    return data;
  }
}
