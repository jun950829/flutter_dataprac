import 'dart:convert';
import 'package:rxdart/rxdart.dart';

import 'package:beeblock_test_yellow/serviceio/globalSGA.dart';
import 'package:beeblock_test_yellow/serviceio/svc102032.dart';
import 'package:beeblock_test_yellow/serviceio/svcheader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:beeblock_test_yellow/Data/mycoin/myCoinData.dart';
import 'package:beeblock_test_yellow/OneCoinTrade/CoinName/CoinName/CoinBottomSheet.dart';
import 'package:beeblock_test_yellow/OneCoinTrade/CoinName/CoinName/MiniChart.dart';

class CoinNameWidget extends StatefulWidget {
  final double _price;
  final double _percentage;

  CoinNameWidget(this._price, this._percentage);

  @override
  _CoinNameState createState() => _CoinNameState(this._price, this._percentage);
}

class _CoinNameState extends State<CoinNameWidget> {
  double _price;
  double _percentage;

  SvcHeader gHeader = SvcHeader();

  var won = NumberFormat('###,###,###,###.##', "en_US");

  _CoinNameState(this._price, this._percentage);

  final mainStream = gStreamCtrlSvc.stream.mergeWith([gStreamCtrlSise.stream]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gRequst.clear();
    UsrSvc102032 usrSvc102032 = UsrSvc102032();
    usrSvc102032.makeUsrSvc102032(code: 'ETH/KRW');
    gRequst.add(gHeader.setSvcHeader(usrSvc102032.requestData(), usrSvc102032.svcCode, gGlobalSGA.getRequestSeq()));
    gRequst.add(usrSvc102032.requestData());

    gChannel.sink.add(gRequst.toBytes());

    print('init!!');

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 64,
        color: Colors.white,
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child:
                  Container(
                    height:24,
                    child: Row(
                      children: [
                        Text(
                          '${sampleCoinData['BTC']['name']} ${sampleCoinData['BTC']['code']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0.sp,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 24.0.w,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: buildBottomSheet,
                        //backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        clipBehavior: Clip.antiAliasWithSaveLayer);
                  },
                ),
                Container(
                  //height: 24,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //현재가
                        StreamBuilder(
                            stream: mainStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              //sise 면
                              if(snapshot.data is String) {
                                UsrSvcRtsCheg usrSvcRtsCheg = UsrSvcRtsCheg();
                                usrSvcRtsCheg.parseData(snapshot.data);
                                return Text(
                                    double.parse(usrSvcRtsCheg.curr).floor().toString(),
                                  style: TextStyle(
                                      color: Color(0xffD8352C),
                                      fontSize: 20.0.sp,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              //svc면
                              else if(snapshot.hasData) {
                                UsrSvcObject usrSvcObject = snapshot.data;
                                Map<String, dynamic> result = jsonDecode(
                                    usrSvcObject.responseSvcObject);
                                return Text(result["ticker"]["price"],
                                  style: TextStyle(
                                    color: Color(0xffD8352C),
                                    fontSize: 20.0.sp,
                                    fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text('no data');
                              }
                            }),
                        // Text(
                        //   '${won.format(sampleCoinData['BTC']['price'])}',
                        //   style: TextStyle(
                        //       color: Color(0xffD8352C),
                        //       fontSize: 20.0.sp,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        Icon(
                          Icons.arrow_drop_up_sharp,
                          color: Color(0xffD8352C),
                        ),
                        //등락가
                        StreamBuilder(
                            stream: mainStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              //sise 면
                              if(snapshot.data is String) {
                                UsrSvcRtsCheg usrSvcRtsCheg = UsrSvcRtsCheg();
                                usrSvcRtsCheg.parseData(snapshot.data);
                                return Text(
                                double.parse(usrSvcRtsCheg.diff).floor().toString(),
                                  style: TextStyle(
                                      color: Color(0xffD8352C),
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              //svc면
                              else if(snapshot.hasData) {
                                UsrSvcObject usrSvcObject = snapshot.data;
                                Map<String, dynamic> result = jsonDecode(
                                    usrSvcObject.responseSvcObject);
                                return Text(result["ticker"]["change"],
                                  style: TextStyle(
                                    color: Color(0xffD8352C),
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text('no data');
                              }
                            }),
                        // Text(
                        //   '${won.format(_price)}',
                        //   style: TextStyle(
                        //       color: Color(0xffD8352C),
                        //       fontSize: 12.0.sp,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        //등락률
                        StreamBuilder(
                            stream: mainStream,
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              //sise 면
                              if(snapshot.data is String) {
                                UsrSvcRtsCheg usrSvcRtsCheg = UsrSvcRtsCheg();
                                usrSvcRtsCheg.parseData(snapshot.data);
                                return Text(
                                ' ( ${usrSvcRtsCheg.rate} %)',
                                  style: TextStyle(
                                      color: Color(0xffD8352C),
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold),
                                );
                              }
                              //svc면
                              else if(snapshot.hasData) {
                                UsrSvcObject usrSvcObject = snapshot.data;
                                Map<String, dynamic> result = jsonDecode(
                                    usrSvcObject.responseSvcObject);
                                return Text(' ( ${result["ticker"]["rate"]} %)',
                                  style: TextStyle(
                                    color: Color(0xffD8352C),
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text('no data');
                              }
                            }),
                        // Text(
                        //   ' (${(_percentage.toStringAsFixed(2))}%)',
                        //   style: TextStyle(
                        //       color: Color(0xffD8352C),
                        //       fontSize: 12.0.sp,
                        //       fontWeight: FontWeight.bold),
                        // )
                      ]),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      StreamBuilder(
                          stream: mainStream,
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            //sise 면
                            if(snapshot.data is String) {
                              UsrSvcRtsCheg usrSvcRtsCheg = UsrSvcRtsCheg();
                              usrSvcRtsCheg.parseData(snapshot.data);
                              return Text(
                                double.parse(usrSvcRtsCheg.h24gvol).toStringAsFixed(4),
                                  style: TextStyle(
                                      fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                                  );
                            }
                            //svc면
                            else if(snapshot.hasData) {
                              UsrSvcObject usrSvcObject = snapshot.data;
                              Map<String, dynamic> result = jsonDecode(
                                  usrSvcObject.responseSvcObject);
                              return Text(result["ticker"]["h24_gvol"],
                                style: TextStyle(
                                    fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                              );
                            } else {
                              return Text('no data');
                            }
                          }),
                      Text(
                        '거래량 (24H)',
                        style: TextStyle(
                            fontSize: 10.0.sp, color: Color(0xff737373)),
                      ),
                    ],
                  ),
                ),
                MiniChart()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: BuildCoinBottomSheet()
    );
  }     /// Bottom sheet
}
