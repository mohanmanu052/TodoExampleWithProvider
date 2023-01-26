import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/modules/login/controller/login_controller.dart';
import 'package:eired_sample/reusable/custom_snackbar.dart';
import 'package:eired_sample/reusable/reusable_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonenumberText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, controller, _) {
      print('the login state was-------' + controller.logInState.toString());
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // color: Colors.red,
                        ),
                        child: TextFormField(
                          controller: phonenumberText,
                          validator: ((value) {
                            if (value!.isEmpty || value.length < 9) {
                              return ErrorMessageConstants.mobilenumbererror;
                            } else {}
                          }),
                          maxLength: 10,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text('+91 ')),
                              labelText: 'Mobile Number',
                              counterText: '',
                              // prefixText: '+91',
                              // prefixStyle: TextStyle(wordSpacing: 10),
                              hintText: 'Please enter the mobile number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ReusableButton(
                        onPressed: () {
                          if (phonenumberText.value.text.isNotEmpty &&
                              phonenumberText.value.text.length > 9) {
                            controller.sendOTP(
                                '+91' + phonenumberText.value.text, context);
                          } else {
                            CustomSnackBar.showSnackBar(
                                ErrorMessageConstants.mobilenumbererror,
                                context);
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => OtpScreen(
                          //               mobileNumberText: phonenumberText.value.text,
                          //             ))));
                        },
                        buttonText: 'Send OTP',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (() => controller.googleSignIn(context)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/googleicon.svg",
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: const Text('Continue with google'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (controller.logInState == LogInState.LOADING)
                Container(
                  margin: EdgeInsets.only(bottom: 100),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                      //color: Colors.amber,
                      ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
