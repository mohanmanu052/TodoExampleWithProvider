import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static Future showSnackBar(String text, BuildContext ctx) async {
    SnackBar snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}
