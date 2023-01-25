import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/constants/utils.dart';
import 'package:eired_sample/modules/login/controller/login_controller.dart';
import 'package:eired_sample/modules/otp/widget/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class ILoginService {
  Future<bool> signInWithGoogle();
  Future<void> sendOtp(String mobilenumber, BuildContext context);
  Future<int> verifyOtp(String code, String verificationId, String mobile);
}

class LoginService extends ILoginService {
  @override
  Future<void> sendOtp(String mobilenumber, BuildContext context) async {
    try {
      print('the mobile number was' + mobilenumber);
      String? verificationId1;
      var res = await firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobilenumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('the exception inside was number was' + e.code);

          if (e.code == 'invalid-phone-number') {}
        },
        codeSent: (String verificationId, int? resendToken) {
          print('the code was sent---');
          print('the verification id was-----' + verificationId);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => OtpScreen(
                        mobileNumberText: mobilenumber,
                        verficationId: verificationId,
                      ))));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      print('the verification id was-----' + verificationId1.toString());
      // TODO: implement sendOtp
    } catch (err) {
      print('coming to catch---' + err.toString());
    }
    //return false;
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      await googleSignIntest.signOut();
      await googleSignIntest.signIn();

      String useremail = googleSignIntest.currentUser!.email;
      // log("user mail  :  " + _googleSignIn.currentUser!.email);
      //   log("user displayname  :  ${_googleSignIn.currentUser!.displayName}");
      String usergivenname =
          googleSignIntest.currentUser!.displayName.toString();
      // log(_googleSignIn.currentUser?.id);
      String photoUrl = googleSignIntest.currentUser!.photoUrl.toString();
      print(
          'the google login email was----------------' + useremail.toString());

      print(
          'the given user name was----------------' + usergivenname.toString());
      print('the google photo url was----------------' + photoUrl.toString());

      if (googleSignIntest.currentUser?.id != null) {
        SharedPrefrenceLocal.saveLogindata(
            '', useremail, googleSignIntest.currentUser!.id,
            isLogged: true);

        // _con.vendorlogin(useremail!, usergivenname!, context, false, "google",
        //     "", googleSignIntest, photoUrl!);
        return true;
      }
    } catch (error) {
      return false;
    }
    return false;
  }

  @override
  Future<int> verifyOtp(
      String code, String verificationId, String mobile) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    var res;
    try {
      res = await firebaseAuth.signInWithCredential(credential);
      SharedPrefrenceLocal.saveLogindata(mobile, '', res.user!.uid,
          isLogged: true, isMobileLogin: true);
      return ErrorMessageConstants.otpVerficationSucessCode;
    } catch (err) {
      ErrorMessageConstants.otpVerificationWrongOtpCode;
    }

    return ErrorMessageConstants.otpVerificationWrongOtpCode;
  }
}
