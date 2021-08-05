import 'dart:async';
import 'dart:convert';

import 'package:beeblock_test_yellow/network/wss_main.dart';
import 'package:beeblock_test_yellow/serviceio/globalSGA.dart';
import 'package:beeblock_test_yellow/serviceio/svcheader.dart';
import 'package:flutter/material.dart';
import 'package:beeblock_test_yellow/serviceio/svc20003.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

/*int _server_call(dynamic header, dynamic body)
{
  int sequence = gGlobalSGA.getRequestSeq();

  gRequst.clear();
  UsrSvc20003 usrSvc20003 = UsrSvc20003();
  gGlobalSGA.setUserPswd(getId.text, getPW.text);
  usrSvc20003.makeUsrSvc20003(usid: getId.text, pswd: getPW.text, jsonYn: 'Y');
  gRequst.add(gHeader.setSvcHeader(usrSvc20003.requestData(), usrSvc20003.svcCode, gGlobalSGA.getRequestSeq()));
  gRequst.add(usrSvc20003.requestData());

  gChannel.sink.add(gRequst.toBytes());
  gRequst.clear();
}*/

class _loginState extends State<login> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    late final getId = TextEditingController();
    late final getPW = TextEditingController();

    SvcHeader gHeader = SvcHeader();

    //gRequst.clear();

    return Scaffold(
      body:
    Container(
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: getId,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID'
              ),
            ),
            TextField(
              obscureText: true,
              controller: getPW,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
            ),
            FloatingActionButton(
                onPressed: () {
                  gRequst.clear();
                  UsrSvc20003 usrSvc20003 = UsrSvc20003();
                  gGlobalSGA.setUserPswd(getId.text, getPW.text);
                  usrSvc20003.makeUsrSvc20003(usid: getId.text, pswd: getPW.text, jsonYn: 'Y');
                  gRequst.add(gHeader.setSvcHeader(usrSvc20003.requestData(), usrSvc20003.svcCode, gGlobalSGA.getRequestSeq()));
                  gRequst.add(usrSvc20003.requestData());

                  gChannel.sink.add(gRequst.toBytes());
                }, child: Icon(Icons.print),
            ),
            StreamBuilder(
              stream: gStreamCtrlSvc.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData) {
                  UsrSvcObject usrSvcObject = snapshot.data;
                  Map<String, dynamic> result = jsonDecode(usrSvcObject.responseSvcObject);
                  return Text('header: svc(${usrSvcObject.responseHeader.svc}), seq(${usrSvcObject.responseHeader.seq})' +
                      '\nbody    :' +
                      '${result["userid"]}');

                } else {
                  return Text('데이터 로딩 실패');
                }
              })
          ],
        ),
      ),
    ),
      );
  }
}
