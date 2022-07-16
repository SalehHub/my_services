//firebaseAuth
import '../my_services.dart';

class ServiceFirebaseAuth {
  //----------------------------------------------//
  factory ServiceFirebaseAuth() => instance;
  ServiceFirebaseAuth._();
  static ServiceFirebaseAuth instance = ServiceFirebaseAuth._();
  //----------------------------------------------//

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Function(User)? _onSuccessLogin;
  Function(FirebaseAuthException)? _onVerificationFailed;

  User? get user => _auth.currentUser;

  String? _verificationId;
  int? _resendToken;

  Future verfiySmsCode({required String smsCode}) async {
    try {
      if (_verificationId != null) {
        User? user = (await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode))).user;

        if (user != null && _onSuccessLogin != null) {
          await _onSuccessLogin!(user);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (_onVerificationFailed != null) {
        _onVerificationFailed!(e);
      }
    }
  }

  Future verifyPhoneNumber({
    required String phoneWithCountryCode,
    required Function onSmsCodeSent,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(User) onSuccessLogin,
    String? languageCode,
  }) async {
    //
    if (languageCode != null) {
      await _auth.setLanguageCode(languageCode);
    }
    //
    _onSuccessLogin = onSuccessLogin;
    _onVerificationFailed = onVerificationFailed;
    //
    await _auth.verifyPhoneNumber(
      //
      phoneNumber: phoneWithCountryCode,
      //
      timeout: const Duration(seconds: 60),
      //
      verificationCompleted: (PhoneAuthCredential credential) async {
        // print("verificationCompleted");
        // ANDROID ONLY!
        if (Platform.isAndroid) {
          User? user = (await _auth.signInWithCredential(credential)).user;

          if (user != null && _onSuccessLogin != null) {
            await _onSuccessLogin!(user);
          }
        }
      },
      //
      verificationFailed: onVerificationFailed,
      //
      codeSent: (String verificationId, int? resendToken) {
        // print("codeSent");
        _verificationId = verificationId;
        _resendToken = resendToken;
        onSmsCodeSent();
      },
      //
      codeAutoRetrievalTimeout: (String verificationId) {
        // print("codeAutoRetrievalTimeout");
        // ANDROID ONLY!
        if (Platform.isAndroid) {
          _verificationId = verificationId;
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
