//firebaseAuth
import '../my_services.dart';

StateProvider<bool> _showSmsCodeInputStateProvider = StateProvider<bool>((r) => false);
StateProvider<bool> _showResendSmsCodeButtonStateProvider = StateProvider<bool>((r) => false);
StateProvider<bool> _isProccessingStateProvider = StateProvider<bool>((r) => false);

class ServiceFirebaseAuth {
  //----------------------------------------------//
  // factory ServiceFirebaseAuth() => instance;
  // ServiceFirebaseAuth._();
  // static ServiceFirebaseAuth instance = ServiceFirebaseAuth._();
  //----------------------------------------------//

  const ServiceFirebaseAuth();

  static final TextEditingController _pinCodeFieldTextEditingController = TextEditingController();
  TextEditingController get pinCodeFieldTextEditingController => _pinCodeFieldTextEditingController;

  _setShowSmsCodeInputStateProvider(bool value) {
    readProviderNotifier(_showSmsCodeInputStateProvider).state = value;
  }

  bool watchIsProccessing(WidgetRef ref) {
    return ref.watch(_isProccessingStateProvider);
  }

  _proccessingOn() {
    readProviderNotifier(_isProccessingStateProvider).state = true;
  }

  _proccessingOff() {
    readProviderNotifier(_isProccessingStateProvider).state = false;
  }

  bool watchShowSmsCodeInput(WidgetRef ref) {
    return ref.watch(_showSmsCodeInputStateProvider);
  }

  _setShowResendSmsCodeButtonStateProvider(bool value) {
    readProviderNotifier(_showResendSmsCodeButtonStateProvider).state = value;
  }

  bool watchShowResendSmsCodeButton(WidgetRef ref) {
    return ref.watch(_showResendSmsCodeButtonStateProvider);
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Function(User)? _onSuccessLogin;
  // static Function()? _onResendRequired;

  static const int _allowedMinutes = 5;
  static final Map<String, DateTime?> _timers = {};

  DateTime? get timer => _timers[_verificationId];
  DateTime? get remainingTimer => timer?.add(const Duration(minutes: _allowedMinutes));

  void _resetTimer() {
    if (_verificationId != null) {
      _timers[_verificationId!] = null;
    }
  }

  void _setTimer() {
    if (_verificationId != null) {
      _timers[_verificationId!] = DateTime.now();
    }
  }

  void _endTimer() {
    if (_verificationId != null) {
      _timers[_verificationId!] = DateTime.now().subtract(const Duration(minutes: _allowedMinutes));
    }
  }

  Function(FirebaseAuthException) get _onVerificationFailed => (e) {
        _proccessingOff();

        String msg = e.message ?? "";

        MyServicesLocalizationsData l = getMyServicesLabels(MyServices.context);

        //for phone number
        if ((e.message ?? "").contains("TOO_SHORT")) {
          msg = l.phoneNumberIsTooShort;
        } else if ((e.message ?? "").contains("TOO_LONG")) {
          msg = l.phoneNumberIsTooLong;
        } else if (e.code.contains("invalid-phone-number")) {
          msg = l.phoneNumberIsInvalid;
        }
        //for sms code
        else if (e.code.contains("invalid-verification-code")) {
          msg = l.theCodeIsInccorectPleaseTryAgain;
        } else if (e.code.contains("session-expired")) {
          msg = l.theCodeHasExpiredPleaseResendTheVerificationCodeToTryAgain;

          _endTimer();

          // if (_onResendRequired != null) {
          //   _onResendRequired!();
          // }
        }

        if (msg.trim() != "") MyServices.services.snackBar.showText(text: msg, success: false);
      };

  User? get user => _auth.currentUser;

  static String? _verificationId;
  static int? _resendToken;

  Future verfiySmsCode({required String smsCode}) async {
    try {
      _proccessingOn();

      if (_verificationId != null) {
        //convert indian number to arabic numbers
        smsCode = MyServices.helpers.indianToArabicNumbers(smsCode);

        await MyServices.helpers.waitForSeconds(5);

        //clear sms code input
        pinCodeFieldTextEditingController.clear();

        //verifiy sms code
        bool result = await _onVerificationComplete(PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode));
        if (result == true) {
          _setShowSmsCodeInputStateProvider(false);
        }
      }
    } on FirebaseAuthException catch (e) {
      _onVerificationFailed(e);
    } catch (e) {
      MyServices.services.snackBar.showText(text: e.toString(), success: false);
    } finally {
      _proccessingOff();
    }
  }

  Future verifyPhoneNumber({
    required String phoneWithCountryCode,
    // required Function onSmsCodeSent,
    required Function(User) onSuccessLogin,
    // void Function()? onResendRequired,
    String? languageCode,
  }) async {
    _proccessingOn();
    //
    _onSuccessLogin = onSuccessLogin;

    //hide resend sms code button
    _setShowResendSmsCodeButtonStateProvider(false);

    //clear sms code input
    pinCodeFieldTextEditingController.clear();

    //set sms message language
    if (languageCode != null) {
      await _auth.setLanguageCode(languageCode);
    }

    await _auth.verifyPhoneNumber(
      //
      phoneNumber: phoneWithCountryCode,

      //
      timeout: const Duration(seconds: 60),

      // ANDROID ONLY!
      verificationCompleted: _onVerificationComplete,

      //
      verificationFailed: _onVerificationFailed,

      //
      codeSent: (String verificationId, int? resendToken) {
        _resendToken = resendToken;
        _showSmsInput(verificationId);
      },

      // ANDROID ONLY!
      codeAutoRetrievalTimeout: _showSmsInput,

      //
      forceResendingToken: _resendToken,
      // autoRetrievedSmsCodeForTesting: "123456",
    );
  }

  void _showSmsInput(String verificationId) {
    _proccessingOff();

    _verificationId = verificationId;

    _setTimer();

    _setShowSmsCodeInputStateProvider(true);

    // onSmsCodeSent();
  }

  Future<bool> _onVerificationComplete(PhoneAuthCredential credential) async {
    User? user = (await _auth.signInWithCredential(credential)).user;

    if (user != null) {
      //reset timer
      _resetTimer();

      if (_onSuccessLogin != null) {
        await _onSuccessLogin!(user);
      }
    }

    _proccessingOff();

    if (user != null) {
      return true;
    }

    return false;
  }

  Future<void> signOut() async => _auth.signOut();
}
