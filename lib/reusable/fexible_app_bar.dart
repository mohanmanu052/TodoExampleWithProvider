import 'package:eired_sample/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 70.0;
  static var format = DateFormat('dd MMM yyyy');
  var dateString = format.format(DateTime.now());
  HomeController? controller;
  MyFlexiableAppBar({required this.controller});
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        height: statusBarHeight + appBarHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/mountains.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // margin: EdgeInsets.only(top: 40, left: 10, right: 10),

          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 1,
                      //fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.only(top: 50, left: 5),
                        child: Text(
                          'Your \nThings',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      flex: 1,
                      // fit: FlexFit.tight,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (controller!.categoryCountList != null &&
                                controller!.categoryCountList!.isNotEmpty)
                              GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.5,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8),
                                  itemCount:
                                      controller?.categoryCountList?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _itemsCategeory(context,
                                        controller?.categoryCountList?[index]);
                                  }),
                          ],
                        ),
                      )),
                ]),
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(6),
                child: Text(dateString,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400))),
          ]),
        ));
  }

  Widget _itemsCategeory(
      BuildContext context, MapEntry<String, int>? categoryCountList) {
    return Container(
        // height: 20,
        child: RichText(
      text: TextSpan(children: [
        WidgetSpan(
            child: Column(
          children: [
            Text(
              categoryCountList?.key ?? '',
              // Noto Sans Japanese
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              categoryCountList?.value.toString() ?? '',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        )),
      ]),
    ));
  }
}
