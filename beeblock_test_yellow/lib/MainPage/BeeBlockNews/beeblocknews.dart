import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:beeblock_test_yellow/Data/news/beeblocknews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beeblock_test_yellow/MainPage/BeeBlockNews/topButton.dart';
import 'package:beeblock_test_yellow/MainPage/MenuGrid/indicator.dart';
import 'package:beeblock_test_yellow/serviceio/unitsvctest.dart';


class beeblockNewsWidget extends StatefulWidget {
  @override
  _beeblockState createState() => _beeblockState();
}

class _beeblockState extends State<beeblockNewsWidget> {

  int _itemIndex=0;
  var temp;
  final List<bool> _isSelected=[true,false,false,false,false];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(height: 8,),
      Container(
        width: width,
        height:50,
        color: Colors.white,
        padding: EdgeInsets.only(left: 16.0,right: 16.0, top: 10.0, bottom: 14.0),
        alignment: Alignment.centerLeft,
        child: Text(
              '비블록 소식',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            )),
      Container(
        padding: EdgeInsets.only(left: 16.0,right: 16.0,),
        width: width,
        height: 34,
        alignment: Alignment.center,
        color: Colors.white,
        /*child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: topButtonWidget(width,'전체',_touchedIdx==0?Colors.black:Color(0xff737373),_touchedIdx==0?FontWeight.bold:FontWeight.normal),
              onTap:(){
                setState(() {
                  _touchedIdx=0;
                });
              }
            ),
            InkWell(
                child: topButtonWidget(width,'이벤트',_touchedIdx==1?Colors.black:Color(0xff737373),_touchedIdx==1?FontWeight.bold:FontWeight.normal),
                onTap:(){
                  setState(() {
                    _touchedIdx=1;
                  });
                }
            ),
            InkWell(
                child: topButtonWidget(width,'공지사항',_touchedIdx==2?Colors.black:Color(0xff737373),_touchedIdx==2?FontWeight.bold:FontWeight.normal),
                onTap:(){
                  setState(() {
                    _touchedIdx=2;
                  });
                }
            ),
            InkWell(
                child: topButtonWidget(width,'홍보센터',_touchedIdx==3?Colors.black:Color(0xff737373),_touchedIdx==3?FontWeight.bold:FontWeight.normal),
                onTap:(){
                  setState(() {
                    _touchedIdx=3;
                  });
                }
            ),
            InkWell(
                child: topButtonWidget(width,'상장목록',_touchedIdx==4?Colors.black:Color(0xff737373),_touchedIdx==4?FontWeight.bold:FontWeight.normal),
                onTap:(){
                  setState(() {
                    _touchedIdx=4;
                  });
                }
            ),
          ],
        ),*/    /// Container를 이용한 버튼 방식
        child: ToggleButtons(
          color: Color(0xffE0E3E5),
          selectedColor: Colors.black,
          selectedBorderColor: Colors.black,
          fillColor: Colors.white,
          //splashColor: Color(0xFF6200EE).withOpacity(0.12),
          //hoverColor: Color(0xFF6200EE).withOpacity(0.04),
          borderRadius: BorderRadius.circular(4.0.r),
          constraints: BoxConstraints(minHeight: 34.0,maxWidth: width),

          isSelected: _isSelected,
          onPressed: (index) {
            setState(() {
              //isSelected=List.all
              //isSelected[index]=true;
              for(int i = 0; i < _isSelected.length; i++) {
                if (i == index)
                  _isSelected[i] = true;
                else
                  _isSelected[i] = false;
              }
            });
          },

          children: [
            topButtonWidget(20.0.w, '전체', _isSelected[0]?Colors.black:Color(0xff737373)),
            topButtonWidget(15.0.w, '이벤트', _isSelected[1]?Colors.black:Color(0xff737373)),
            topButtonWidget(10.0.w, '공지사항', _isSelected[2]?Colors.black:Color(0xff737373)),
            topButtonWidget(10.0.w, '홍보센터', _isSelected[3]?Colors.black:Color(0xff737373)),
            topButtonWidget(10.0.w, '상장목록', _isSelected[4]?Colors.black:Color(0xff737373)),
            /*Container(
              width: ((width-32.w)/5)-1.2.w,
              height: 34.0,
              alignment: Alignment.center,
              child: Text('이벤트',style: TextStyle(
                fontSize: 13.0.sp,
                color: Colors.black,
                //fontWeight:fontWeight
              ),
                textAlign: TextAlign.center,
              ),
            ),*/

          ],
        ),
      ),
      Container(
        //padding: EdgeInsets.only(left: 16.0.w,right: 16.0.w),
        height: 60*6 + 46.0,
        color: Colors.white,
        child: FutureBuilder<dynamic> (
          future: httpTest('https://zzzzzhahatestserver.beeblock.co.kr/api/tb_content/dashboard?category=BN&lang=ko&ver=1628152020860'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return
              Column(
                children: [
              CarouselSlider.builder(
              //itemPositionsListener: _itemPositionsListener,
              options: CarouselOptions(
              height: 60*6,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                //aspectRatio: 16/9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _itemIndex = index;
                  });
                },
              ),
            itemCount: snapshot.data["BN_BN"]["contents"].length~/7+1,
            // itemCount: sampleBeeBlockNews.length~/7+1,
            itemBuilder: (BuildContext context,int row,int realIndex){
            return Container(
            padding: EdgeInsets.only(left: 16.0,right: 16.0),
            width: width,
            height: 60*6,
            child: ListView.builder(
            scrollDirection: Axis.vertical,
            // itemCount: sampleBeeBlockNews.length-6*row,
            itemCount: snapshot.data["BN_BN"]["contents"].length-6*row,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int col) {
            // int key = snapshot.data["BF_DNW"]["contents"].keys.elementAt(col+6*row);
            // int key = sampleBeeBlockNews.keys.elementAt(col+6*row);
            // Map<String, Object> list = sampleBeeBlockNews[key];
            Map<String, Object> list = snapshot.data["BN_BN"]["contents"][col+6*row];
            //print(list);
            return Container(
            height: 60.0,
            child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('${list['title']}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0.sp,
            ),),
            //SizedBox(height: 1.0,),
            Text('${list['createdDate']}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
            color: Color(0xff737373),
            fontSize: 12.0.sp
            ),),
            Container(
            //padding:EdgeInsets.only(top:10.0),
            height: 1,
            width: width,
            color: Color(0xffECEFF1),
            margin: EdgeInsets.only(top:10.0),
            )
            ],
            ),
            ),
            );
            },
            ),
            );
            },
            ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16.0.w,right: 16.0.w,top: 18.0,bottom: 18.0),
                    //width: width,
                    height: 46.0,
                    alignment: Alignment.center,
                    child: oneIndicator(snapshot.data["BN_BN"]["contents"].length~/7+1, _itemIndex),
                  ),
                ],
              );

            } else {
              return Text("error");
            }
          },
        ),
      ),
    ]);
  }
}
