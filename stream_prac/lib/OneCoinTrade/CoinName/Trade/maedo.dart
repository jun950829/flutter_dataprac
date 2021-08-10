import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stream_prac/MainPage/BeeBlockNews/topButton.dart';
import 'package:stream_prac/OneCoinTrade/CoinName/Trade/jijungga.dart';
import 'package:stream_prac/OneCoinTrade/CoinName/Trade/jijungstop.dart';
import 'package:stream_prac/OneCoinTrade/CoinName/Trade/sijangga.dart';


class MaedoWidget extends StatefulWidget {

  @override
  _MaedoState createState() => _MaedoState();
}

class _MaedoState extends State<MaedoWidget> {

  int _tapIdx = 0;    /// 지정가, 시장가, 지정스탑 선택

  var won = NumberFormat('###,###,###,###', 'en_US');

  final List<bool> _isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0,left: 10.0.w,right: 10.0.w),
        width: 220.w,
        height: 607,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PriceTab(0, '지정가'),
              PriceTab(1, '시장가'),
              PriceTab(2, '지정스탑')
            ],
          ),      /// 지정가, 시장가, 지정스탑
          SizedBox(height: 14,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            width: 200.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '사용가능',
                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${won.format(8805863)}  KRW',
                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                ),
                //_tradeIdx==0||_tradeIdx==1?PriceDecisionWidget(_tradeIdx,_tapIdx)
              ],
            ),
          ),    /// 사용가능 금액
          SizedBox(
            height: 13.0,
          ),
          PriceDecision(_tapIdx),
          SizedBox(
            height: 14.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            width: 200.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최소 주문',
                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${won.format(5000)}  KRW',
                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                ),
                //_tradeIdx==0||_tradeIdx==1?PriceDecisionWidget(_tradeIdx,_tapIdx)
              ],
            ),
          ),    /// 최소 주문
          SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {

                },
                child: Text('초기화',
                  style: TextStyle(
                      color: Color(0xff2376F1)
                  ),),
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(95.0.w,34.0),
                    side: BorderSide(
                        color: Color(0xff2376F1)
                    )
                ),
              ),
              OutlinedButton(
                onPressed: () {  },
                child: Text('매도',
                  style: TextStyle(
                      color: Colors.white
                  ),),
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(95.0.w,34.0),
                    backgroundColor: Color(0xff2376F1)
                ),
              ),
            ],
          )           /// 초기화 or 매수
        ]));
  }

  Widget PriceTab(int op,String text){
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
                child: Icon(
                  Icons.check,
                  size: 13.0.w,
                ),
                visible: _tapIdx == op ? true : false,
                maintainSize: false),
            Text(
              '$text',
              style: TextStyle(
                fontSize: 13.0.w,
                color:
                _tapIdx == op ? Colors.black : Color(0xff737373),
                fontWeight: _tapIdx == op
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
                color: _tapIdx == op
                    ? Color(0xffFFBC00)
                    : Color(0xffE0E3E5))),
      ),
      onTap: () {
        setState(() {
          _tapIdx = op;
        });
      },
    );
  }   /// 지정가, 시장가, 지정스탑 탭 Widget
}

Widget PriceDecision(int tapIdx){
  if(tapIdx==0)
    return JiJungGa();
  else if(tapIdx==1)
    return SiJangGa();
  else
    return JiJungStop();
}

