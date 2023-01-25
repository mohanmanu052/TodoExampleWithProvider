import 'package:eired_sample/constants/color_contants.dart';
import 'package:eired_sample/modules/home/homescreen.dart';
import 'package:eired_sample/modules/login/controller/login_controller.dart';
import 'package:eired_sample/reusable/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumberText;
  final String? verficationId;
  const OtpScreen({Key? key, this.mobileNumberText, this.verficationId})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, controller, _) {
      return Scaffold(
        body: SafeArea(
            child: Container(
                //alignment: Alignment.center,
                child: Stack(children: [
          if (controller.logInState == LogInState.OTPVERIFYING)
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          Container(
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Enter the OTP sent to ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
                  TextSpan(
                      text: widget.mobileNumberText ?? '',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.primaryColor,
                          fontSize: 14)),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                controller: pinController,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                onCompleted: ((value) {
                  controller.confirmOTP(value, widget.verficationId!, context,
                      widget.mobileNumberText!);
                }),

                defaultPinTheme: PinTheme(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13),
                    constraints: BoxConstraints(minHeight: 50, minWidth: 80),
                    decoration: _pinBoxDecoration,
                    padding: const EdgeInsets.all(16)),
                onSubmitted: (String pin) => () {
                  controller.confirmOTP(pinController.text,
                      widget.verficationId!, context, widget.mobileNumberText!);
                },
                length: 6,
                // controller: otpController,
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.logInState == LogInState.OTPERROR)
                Text('Wrong OTP entered',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color(0xffD15353), fontSize: 11)),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    controller.sendOTP(widget.mobileNumberText ?? '', context);
                  },
                  child: Text('Resend OTP',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorConstants.primaryColor, fontSize: 12))),
              const SizedBox(
                height: 20,
              ),
              ReusableButton(
                onPressed: () async {
                  controller.confirmOTP(pinController.text,
                      widget.verficationId!, context, widget.mobileNumberText!);
                },
                buttonText: 'Confirm OTP',
              )
            ],
          ),
        ]))),
      );
    });
  }

  BoxDecoration get _pinBoxDecoration {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey),
      //borderRadius: BorderRadius.circular(20),
      color: Colors.grey,
    );
  }
}
