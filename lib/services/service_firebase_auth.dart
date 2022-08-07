//firebaseAuth
import '../my_services.dart';

class ServiceFirebaseAuth {
  //----------------------------------------------//
  // factory ServiceFirebaseAuth() => instance;
  // ServiceFirebaseAuth._();
  // static ServiceFirebaseAuth instance = ServiceFirebaseAuth._();
  //----------------------------------------------//

  const ServiceFirebaseAuth();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Function(User)? _onSuccessLogin;
  static Function()? _onResendRequired;

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

          if (_onResendRequired != null) {
            _onResendRequired!();
          }
        }

        if (msg.trim() != "") MyServices.services.snackBar.showText(text: msg, success: false);
      };

  User? get user => _auth.currentUser;

  static String? _verificationId;
  static int? _resendToken;

  Future verfiySmsCode({required String smsCode}) async {
    try {
      if (_verificationId != null) {
        User? user = (await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode))).user;

        if (user != null) {
          //reset timer
          _resetTimer();

          if (_onSuccessLogin != null) {
            await _onSuccessLogin!(user);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      _onVerificationFailed(e);
    }
  }

  Future verifyPhoneNumber({
    required String phoneWithCountryCode,
    required Function onSmsCodeSent,
    required Function(User) onSuccessLogin,
    void Function()? onResendRequired,
    String? languageCode,
  }) async {
    //
    if (languageCode != null) {
      await _auth.setLanguageCode(languageCode);
    }
    //
    _onSuccessLogin = onSuccessLogin;
    _onResendRequired = onResendRequired;
    //
    await _auth.verifyPhoneNumber(
      //
      phoneNumber: phoneWithCountryCode,
      //
      timeout: const Duration(seconds: 60),
      //
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        if (Platform.isAndroid) {
          User? user = (await _auth.signInWithCredential(credential)).user;

          if (user != null) {
            //reset timer
            _resetTimer();

            if (_onSuccessLogin != null) {
              await _onSuccessLogin!(user);
            }
          }
        }
      },
      //
      verificationFailed: _onVerificationFailed,
      //
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
        _setTimer();
        onSmsCodeSent();
      },
      //
      codeAutoRetrievalTimeout: (String verificationId) {
        // ANDROID ONLY!
        if (Platform.isAndroid) {
          _verificationId = verificationId;
          _setTimer();

          onSmsCodeSent();
        }
      },
      //
      forceResendingToken: _resendToken,
      // autoRetrievedSmsCodeForTesting: "123456",
    );
  }

  Future<void> signOut() async => _auth.signOut();
}
