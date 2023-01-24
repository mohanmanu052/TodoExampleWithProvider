import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Function yesCallback;
  final String title;
  final String content;

  CustomAlertDialog({
    required this.yesCallback,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
            yesCallback();
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
