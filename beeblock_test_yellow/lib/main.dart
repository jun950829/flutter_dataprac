// @dart=2.9
import 'package:beeblock_test_yellow/Login/login.dart';
import 'package:beeblock_test_yellow/testPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MainPage/mainpage.dart';
import 'OneCoinTrade/maincoin.dart';
import 'serviceio/globalSGA.dart';
import 'network/wss_main.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => MaterialApp(
        scrollBehavior: MyBehavior(),
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.white,
            fontFamily: 'NotoSansKR',
            textSelectionTheme: TextSelectionThemeData(
              //selectionHandleColor: Colors.transparent,
              cursorColor: Colors.black,
              selectionColor: Color(0xffFFBC00),
              selectionHandleColor: Colors.transparent,
            )),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[900],
        ),
        initialRoute: '/',
        routes: {
          '/login': (context) => login(),
          '/': (context) => MyHomePage(
              title: 'BeeBlock', gChannel: wssConnect(gGlobalSGA.isMode)),
          '/example': (context) => example(),
          '/trade': (context) => CoinTrade(),
        },
        //home: MyHomePage(title: 'BeeBlock'),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
