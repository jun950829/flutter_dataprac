import 'dart:async';

import 'package:beeblock_test_yellow/network/wss_main.dart';
import 'package:beeblock_test_yellow/serviceio/globalSGA.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'BeeBlockNews/beeblocknews.dart';
import 'CoinList/myCoinList.dart';
import 'CoinList/sellCoinList.dart';
import 'Cryptonews/cryptonews.dart';
import 'LoginInfoMain/centerText.dart';
import 'LoginInfoMain/head_widget.dart';
import 'MenuGrid/eventMenuWidget.dart';
import 'MenuGrid/gridItem.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  String backendData = '';

  MyHomePage({Key? key, required this.title, required gChannel}) : super(key: key);

  // MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  Timer? _timer;
  Map<String, dynamic>? strBodyJson;

  UsrSvcRtsCheg usrSvcRtsCheg = UsrSvcRtsCheg();

  TextEditingController _controller = TextEditingController();
  late StreamSubscription _streamSubscriptionHoga;

  late StreamSubscription _streamSubscriptionSise;

  void initState() {
    debugPrint('initState');

    super.initState();

    // 시세 로그인
    //gSiseSSO('test');

    wssSsoSvc('test');

    debugPrint('initState3..');

    gListenWss('init');

    gHeartBeat('init');

    // hogaQTimer('init');

    // 데이타 소비쪽을 할 이유가 없네?
    _streamSubscriptionHoga = gStreamCtrlHoga.stream.listen(null);
    _streamSubscriptionSise = gStreamCtrlSise.stream.listen(null);
  }

  void hogaQTimer(String callType) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //  전송..
      try {
        //ModifyedHogaQ();
      } catch (e) {
        debugPrint('timer.exception>' + callType + ' >' + e.toString());
      }
    });
  }

  @override
  void dispose() {
    print("dispose");
    _timer?.cancel();
    gChannel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            width: width,
            child: ListView(children: [
              Container(
                  height: (260+376.h),
                  width: width,
                  child: Column(children: [
                    Container(
                      height: (260+376.h),
                      width: width,
                      child: Stack(children: [
                        headWidget(),    /// LoginHead
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top:12.0,bottom: 12.0),
                                  child: SvgPicture.asset('images/logo.svg',width: 130.0.w,height: 32.0,color: Colors.black,)
                              ),
                              Icon(Icons.menu, color: Colors.black)
                            ],
                          ),
                          top:12,
                          left: 16.w,
                          right: 16.w,
                        ),    /// Logo
                        Positioned(   /// MenuItems
                          top: 260,
                          child: Container(
                              width: width,
                              height: 376.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0,left: 16.0.w,right: 16.0.w),
                                    child: centerTextWidget()
                                  ),
                                  Container(
                                    height: 310.h,
                                    margin: EdgeInsets.only(top: 10.0.h),
                                    color: Color(0xffF7F7F7),
                                    padding: EdgeInsets.only(top: 16.0,left: 16.0.w,right: 16.0.w),
                                    child: gridItemWidget(),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF7F7F7),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)
                                )
                              ),
                          ),
                        ),
                      ]),
                    ),
                  ])),
              Container(
                  width: width,
                  height: 147,
                  alignment: Alignment.topCenter,
                  //padding: EdgeInsets.only(top:5.0),
                  color: Color(0xffF7F7F7),
                  //color: Colors.blue,
                  child: eventMenuWidget()
              ),
              Container(
                width: width,
                height: 240,
                color: Color(0xffF7F7F7),
                child: myCoinListWidget(),
              ),  ///  myCoinList
              Container(
                width: width,
                height: 410,
                color: Color(0xffF7F7F7),
                child: sellCoinListWidget(),
              ),  ///  SellingCoinList
              Container(
                width: width,
                height: 498,
                color: Color(0xffF7F7F7),
                child: beeblockNewsWidget(),
              ),  /// BeeBlock News
              Container(
                width: width,
                height: 498,
                color: Color(0xffF7F7F7),
                child: cryptoNewsWidget(),
              ),   /// CryptoNews
            ]))
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}