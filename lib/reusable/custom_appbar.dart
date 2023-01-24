import 'package:eired_sample/constants/color_contants.dart';
import 'package:flutter/material.dart';

PreferredSize customAppBar(BuildContext context,
    {required String inputTitle,
    VoidCallback? onBackButtonClicked,
    //custom
    IconData? customIcon,
    VoidCallback? onCustomIconClicked,
    bool isCoustomColor = false}) {
  return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 4, right: 4),
        decoration: const BoxDecoration(
          color: ColorConstants.primaryColor,
        ),
        child: Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (() => Navigator.pop(context)),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 4, right: 4),
              alignment: Alignment.topCenter,
              child: Text(
                inputTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ));
}
