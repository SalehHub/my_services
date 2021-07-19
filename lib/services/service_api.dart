import '../my_services.dart';

class ServiceApi {
  static final Dio dio = Dio();
  static String domain = '';

  static Options _dioOptions(String? accessToken) {
    Map<String, dynamic> headers = <String, dynamic>{};
    if (accessToken != null) {
      headers = <String, dynamic>{
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      };
    }
    return Options(
      method: 'POST',
      headers: headers,
      contentType: 'application/json',
    );
  }

  static Future<Response<Map<String, dynamic>>> postRequest(String url, Map<String, dynamic> formData, CancelToken? cancelToken) async {
    logger.d(formData);
    final String? accessToken = formData['access_token'] as String?;
    logger.i('$domain$url');
    final Response<Map<String, dynamic>> data = await dio.postUri<Map<String, dynamic>>(
      Uri.parse('$domain$url'),
      data: formData,
      cancelToken: cancelToken,
      options: _dioOptions(accessToken),
    );
    return data;
  }
}
