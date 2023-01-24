import 'package:eired_sample/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 70.0;
  static var format = DateFormat('dd MMM yyyy');
  var dateString = format.format(DateTime.now());
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
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.8,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return _itemsCategeory(context);
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

          //   child: Stack(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Flexible(
          //               flex: 1,
          //               //fit: FlexFit.tight,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     padding: EdgeInsets.all(6),
          //                     margin: EdgeInsets.only(top: 10),
          //                     child: Text(
          //                       'Your \n Things',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .headline1
          //                           ?.copyWith(
          //                               color: Colors.white,
          //                               fontSize: 30,
          //                               fontWeight: FontWeight.w400),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   Container(
          //                     padding: EdgeInsets.all(6),
          //                     child: Text(
          //                       dateString,
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyText1
          //                           ?.copyWith(
          //                               color: Colors.white,
          //                               fontWeight: FontWeight.w400),
          //                     ),
          //                   ),
          //                 ],
          //               )),
          //           Flexible(
          //               fit: FlexFit.tight,
          //               child: Container(
          //                 // margin: EdgeInsets.only(bottom: 20),
          //                 alignment: Alignment.topRight,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.end,
          //                   children: [
          //                     GridView.builder(
          //                         shrinkWrap: true,
          //                         gridDelegate:
          //                             const SliverGridDelegateWithFixedCrossAxisCount(
          //                                 crossAxisCount: 2, childAspectRatio: 2),
          //                         itemCount: 4,
          //                         itemBuilder: (BuildContext context, int index) {
          //                           return _itemsCategeory(context);
          //                         }),
          //                   ],
          //                 ),
          //               ))
          //         ],
          //       )
          //     ],
          //   ),
        ));
  }

  Widget _itemsCategeory(BuildContext context) {
    return Container(
        // height: 20,
        child: RichText(
      text: TextSpan(children: [
        WidgetSpan(
            child: Column(
          children: [
            Text(
              '24',
              // Noto Sans Japanese
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w200),
            ),
            Text(
              'Personal',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        )),
        // WidgetSpan(child: Text('yyy'))
      ]),
    ));
  }
}
