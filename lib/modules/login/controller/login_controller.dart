import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/modules/home/homescreen.dart';
import 'package:eired_sample/modules/login/provider/login_service.dart';
import 'package:eired_sample/reusable/custom_snackbar.dart';
import 'package:flutter/material.dart';

enum LogInState { LOADING, UNKNOWN, OTPVERIFYING, OTPERROR, SUCCESS }

class LoginController with ChangeNotifier {
  LogInState logInState = LogInState.UNKNOWN;
  ILoginService? provider;
  LoginController(ILoginService apiService) {
    provider = apiService;
  }

  Future<void> googleSignIn(BuildContext context) async {
    logInState = LogInState.LOADING;
    notifyListeners();
    print('coming to google sign--');
    var res = await provider?.signInWithGoogle();
    if (res == true) {
      logInState = LogInState.SUCCESS;
      notifyListeners();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      logInState = LogInState.UNKNOWN;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          ErrorMessageConstants.someErrorOcurredMessage, context);
    }
  }

  Future<void> sendOTP(String mobileNumer, BuildContext context) async {
    logInState = LogInState.LOADING;
    notifyListeners();
    var res = await provider?.sendOtp(mobileNumer, context);
    //logInState = LogInState.SUCCESS;
    //notifyListeners();
    // print('the res id was----' + res.toString());
    // if (res != '') {
    //   print('the verification id was----' + res.toString());
    //   logInState = LogInState.SUCCESS;
    //   notifyListeners();
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: ((context) => OtpScreen(
    //                 mobileNumberText: mobileNumer,
    //                 verficationId: res,
    //               ))));
    // } else {
    //   logInState = LogInState.SUCCESS;
    //   notifyListeners();
    //   CustomSnackBar.showSnackBar(
    //       ErrorMessageConstants.someErrorOcurredMessage, context);
    // }
  }

  Future<void> confirmOTP(String code, String verificationId,
      BuildContext contex, String mobile) async {
    logInState = LogInState.OTPVERIFYING;
    notifyListeners();
    var res = await provider!.verifyOtp(code, verificationId, mobile);
    print('the res data was------' + res.toString());
    if (res == ErrorMessageConstants.otpVerificationWrongOtpCode) {
      logInState = LogInState.OTPERROR;
      notifyListeners();
    } else {
      logInState = LogInState.SUCCESS;
      notifyListeners();
      onVerificationCompleted(contex);
    }
  }

  Future<void> onVerificationCompleted(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
