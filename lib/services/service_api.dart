import '../my_services.dart';

class ServiceApi {
  static final Dio dio = Dio();
  static String domain = '';

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
      accessToken = formData.fields.firstWhere((element) => element.key == 'access_token').value;
      lang = formData.fields.firstWhere((element) => element.key == 'lang').value;
      logger.d(formData.fields);
    } else {
      accessToken = formData['access_token'] as String?;
      lang = formData['lang'] as String?;
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

  static Future<Response<Map<String, dynamic>>> getRequest(String url, dynamic formData, CancelToken? cancelToken) async {
    final String? accessToken;
    final String? lang;
    if (formData is FormData) {
      accessToken = formData.fields.firstWhere((element) => element.key == 'access_token').value;
      lang = formData.fields.firstWhere((element) => element.key == 'lang').value;
      logger.d(formData.fields);
    } else {
      accessToken = formData['access_token'] as String?;
      lang = formData['lang'] as String?;
      logger.d(formData);
    }

    logger.i('$domain$url');
    final Response<Map<String, dynamic>> data = await dio.getUri<Map<String, dynamic>>(
      Uri.parse('$domain$url'),
      cancelToken: cancelToken,
      options: _dioOptions(accessToken, lang),
    );
    return data;
  }
}
