import 'dart:async';

import 'package:eired_sample/constants/shareprefrence_constants.dart';
import 'package:eired_sample/modules/home/homescreen.dart';
import 'package:eired_sample/modules/login/widget/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var res = getSharedPrerenceData();
    Timer(Duration(seconds: 2), () {
      res.then((value) {
        if (value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
    });
    ;
  }

  Future<bool> getSharedPrerenceData() async {
    bool isLogged = await SharedPrefrenceLocal.checkLogin();
    return isLogged ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white, height: MediaQuery.of(context).size.height
          // child: FlutterLogo(size: MediaQuery.of(context).size.height
          // )

          ),
    );
  }
}
