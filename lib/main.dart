import 'package:eired_sample/constants/color_contants.dart';
import 'package:eired_sample/modules/home/provider/homescreen_provider.dart';
import 'package:eired_sample/modules/login/controller/login_controller.dart';
import 'package:eired_sample/modules/login/provider/login_service_provider.dart';
import 'package:eired_sample/modules/todo/controller/add_todo_controller.dart';
import 'package:eired_sample/modules/todo/provider/add_todo_provider.dart';
import 'package:eired_sample/modules/viewtodo/controller/todo_view_controller.dart';
import 'package:eired_sample/reusable/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/home/controller/home_controller.dart';

ThemeData _themeData = ThemeData(
  primaryColor: ColorConstants.primaryColor,
  textTheme: const TextTheme(
      headline6: TextStyle(
          fontFamily: 'Sofia Sans Extra Condensed',
          fontSize: 14,
          //fontWeight: FontWeight.w400,
          color: Colors.white),
      button: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white),
      bodyText1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black),
      headline1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black)),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TodoViewController>(
              create: (_) => TodoViewController(
                  HomeScreenServiceProvider.getHomeApiService())),
          ChangeNotifierProvider<HomeController>(
              create: (_) => HomeController(
                  HomeScreenServiceProvider.getHomeApiService())),
          ChangeNotifierProvider<AddTodoController>(
              create: (_) =>
                  AddTodoController(AddTodoServiceProvider.getService())),
          ChangeNotifierProvider<LoginController>(
            create: (_) =>
                LoginController(LoginServiceProvider.getApiService()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: _themeData,
          home: SplashScreen(),
        ));
  }
}
