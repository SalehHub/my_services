//dio

import '../../my_services.dart' hide url;
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ServiceApi {
  ServiceApi() {
    //to slove certificate problem when using localhost urls
    if (kDebugMode) {
      HttpOverrides.global = _MyHttpOverrides();
    }
  }

  Map<String, dynamic>? responseData;

  static final Map<String, CancelToken> cancelTokens = {};

  bool _enableEndpointLog = true;
  bool _enableResponseLog = true;
  bool _enableHeadersLog = true;
  bool _enableFormDataLog = true;
  void disableEndpointLog() => _enableEndpointLog = false;
  void disableResponseLog() => _enableResponseLog = false;
  void disableHeadersLog() => _enableHeadersLog = false;
  void disableFormDataLog() => _enableFormDataLog = false;

  bool _cancelPrevious = true;
  void setCancelPrevious(bool cancelPrevious) => _cancelPrevious = cancelPrevious;

  bool _withCache = false;
  void setWithCache(bool withCache) => _withCache = withCache;

  bool _withRetry = true;
  void setWithRetry(bool withRetry) => _withRetry = withRetry;

  bool _showMsgSnackbar = true;
  bool _hideShownSnackbars = true;
  int _msgSnackbarSeconds = 3;
  void setShowMsgSnackbar(bool showMsgSnackbar, {bool hideShownSnackbar = true, int msgSnackbarSeconds = 3}) {
    _showMsgSnackbar = showMsgSnackbar;
    _hideShownSnackbars = hideShownSnackbar;
    _msgSnackbarSeconds = msgSnackbarSeconds;
  }

  int _cacheMinutes = 5;
  void setCacheMinutes(int cacheMinutes) => _cacheMinutes = cacheMinutes;

  int _refreshCacheAfterMinutes = 5;
  void setRefreshCacheAfterMinutes(int refreshCacheAfterMinutes) => _refreshCacheAfterMinutes = refreshCacheAfterMinutes;

  Function(dynamic data)? _afterResponse;
  void setAfterResponse(Function(dynamic data)? afterResponse) => _afterResponse = afterResponse;
  void afterResponse() {
    if (_afterResponse != null) {
      _afterResponse!(responseData);
    }
  }

  String _domain = '';
  void setDoamin(String domain) => _domain = domain;

  String _url = '';
  void setUrl(String url) => _url = url;

  Map<String, dynamic> _formData = {}; //can be FormData or Map<String, dynamic>
  void setFormData(Map<String, dynamic> formData) => _formData = {
        ...formData,
      };
  Map<String, dynamic> get formData => {
        ...MyServices.providers.asMap(),
        ..._formData,
      };

  Map<String, dynamic> _headers = {};
  void setHeaders(Map<String, dynamic> headers) => _headers = headers;

  //-------------------------------------Cache-------------------------------------//
  String getCacheKey() {
    String? accessToken = formData['accessToken'] as String?;
    String? lang = formData['appLang'] as String?;
    String? appBuild = formData['appBuild'] as String?;

    String key = _url + _formData.toString() + _headers.toString() + accessToken.toString() + lang.toString() + appBuild.toString();
    // print(key);
    return MyServices.helpers.getMd5(key);
  }

  Future<bool> isCacheExpired() async => (await MyServices.storage.get(getCacheKey(), _refreshCacheAfterMinutes)) == null;

  Future<Map<String, dynamic>?> getCache() async => await MyServices.storage.get(getCacheKey(), _cacheMinutes);

  Future<bool> setCache() async => (responseData != null && _withCache == true) ? await MyServices.storage.set(getCacheKey(), responseData) : false;

  Future<bool> deleteCache() async => await MyServices.storage.delete(getCacheKey());
  //--------------------------------------------------------------------------//
  void logResponseData() {
    if (_enableResponseLog) logger.d(responseData);
  }

  void logFormData() {
    if (_enableFormDataLog) logger.d(formData);
  }

  void logUrl(String requestType, String source) {
    if (_enableEndpointLog) logger.d('$requestType: $_domain$_url  -  $source');
  }

  void logHeaders(Map<String, dynamic> allHeaders) {
    if (_enableHeadersLog) logger.d(allHeaders);
  }
  //--------------------------------------------------------------------------//

  Future<String> download(String url) async {
    String ext = extension(url);
    String fileName = MyServices.helpers.getMd5(url);
    String savePath = "${await MyServices.helpers.getApplicationDocumentsPath() ?? ""}/$fileName.$ext";
    logger.d(savePath);
    await Dio().download(url, savePath);
    return savePath;
  }

  Options _dioOptions(String method) {
    //get access token and language to create authorization headers
    String? accessToken;
    String? lang;

    accessToken = formData['accessToken'] as String?;
    lang = formData['appLang'] as String?;

    Map<String, dynamic> allHeaders = <String, dynamic>{
      if (accessToken != null) ...{
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      },
      if (lang != null) ...{
        'X-Localization': lang,
      },
      ..._headers
    };

    logHeaders(allHeaders);

    return Options(method: method, headers: allHeaders, contentType: 'application/json');
  }

  Future<dynamic> getFormData(Map<String, dynamic> formData) async {
    //check if form data has file
    bool isFile = formData.values.where((e) => (e is File) ? true : false).isNotEmpty;

    //if form data has file convert form data to map
    if (isFile == true) {
      Map<String, dynamic> newFormData = {};
      for (MapEntry entry in formData.entries) {
        String key = entry.key;
        dynamic value = entry.value;
        if (value is File) {
          newFormData[key] = await MultipartFile.fromFile(value.path);
        } else {
          newFormData[key] = value;
        }
      }

      return FormData.fromMap(newFormData);
    }

    //can be FormData or Map<String, dynamic>
    return formData;
  }

  Future<Map<String, dynamic>?> postRequest({int currentTry = 1, int tries = 6}) => request("POST", currentTry: currentTry, tries: tries);

  Future<Map<String, dynamic>?> getRequest({int currentTry = 1, int tries = 6}) => request("GET", currentTry: currentTry, tries: tries);

  Future<Map<String, dynamic>?> tryGetFromCache() async {
    if (_withCache) {
      Map<String, dynamic>? data = await getCache();
      //fake wait if cache exist in debug mode
      if (data != null && kDebugMode) {
        await MyServices.helpers.waitForMilliseconds(200);
      }

      return data;
    } else {
      deleteCache();
    }

    return null;
  }

  void showMsgSnackBar() {
    if (_showMsgSnackbar) {
      showTextSnackBar(responseData, hideShownSnackBars: _hideShownSnackbars, seconds: _msgSnackbarSeconds);
    }
  }

  void tryCancelPrevious() {
    if (_cancelPrevious) {
      cancelTokens[_url]?.cancel();
    }
    cancelTokens[_url] = CancelToken();
  }

  Future<Map<String, dynamic>?> request(String requestType, {int currentTry = 1, int tries = 6}) async {
    tryCancelPrevious();

    //cache
    responseData = await tryGetFromCache();

    if (responseData != null) {
      logUrl(requestType, 'From Cache');
      logFormData();
      logResponseData();

      afterResponse();

      if (!(await isCacheExpired())) {
        return responseData;
      }
    }

    try {
      Response<Map<String, dynamic>> res = await Dio().requestUri<Map<String, dynamic>>(
        Uri.parse('$_domain$_url'),
        data: await getFormData(formData),
        cancelToken: cancelTokens[_url],
        options: _dioOptions(requestType),
      );

      responseData = res.data;

      logUrl(requestType, 'From Web');
      logFormData();
      logResponseData();

      afterResponse();

      showMsgSnackBar();

      //cache if withCache = true and responseData not null
      await setCache();

      return responseData;
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.cancel) {
        logger.d("Dio request canceled");
      } else {
        logger.d(e.error);
        logger.d(e.message);
        logger.d(e.response);
        logger.d(e.response?.data);
        logger.d(e.response?.statusCode);
        logger.d(e.response?.statusMessage);

        logger.e(e, error: e, stackTrace: s);

        if (currentTry == 1) await _handleNoInternet(e);

        if (currentTry != tries && _withRetry) {
          await MyServices.helpers.waitForSeconds(5 + currentTry);
          return await request(requestType, currentTry: currentTry + 1, tries: tries);
        }
      }
    }

    return null;
  }

  Future<bool> _handleNoInternet(DioException e) async {
    if (e.message?.contains("SocketException") ?? false) {
      logger.d("SocketException");
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

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => super.createHttpClient(context)..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
}
