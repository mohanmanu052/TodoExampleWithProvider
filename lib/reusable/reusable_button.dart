import 'package:eired_sample/constants/color_contants.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  String? buttonText;
  VoidCallback? onPressed;
  Color? backgroundColor;
  ReusableButton(
      {Key? key, this.buttonText, this.onPressed, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor ?? ColorConstants.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          buttonText ?? '',
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
