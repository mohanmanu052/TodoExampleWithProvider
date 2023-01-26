import 'package:eired_sample/constants/error_message_constants.dart';
import 'package:eired_sample/reusable/reusable_button.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final VoidCallback? onTrygainTap;
  const NoDataFound({Key? key, this.onTrygainTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.hourglass_empty_rounded,
              size: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              ErrorMessageConstants.nodatafound,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ReusableButton(
            buttonText: 'Try Again',
            onPressed: onTrygainTap,
          )
        ],
      ),
    );
  }
}
