import 'package:beeblock_test_yellow/serviceio/httpsession.dart';
import 'package:beeblock_test_yellow/serviceio/unitsvctest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class example extends StatefulWidget {
  const example({Key? key}) : super(key: key);

  @override
  _exampleState createState() => _exampleState();
}

class _exampleState extends State<example> {

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView (
      child : Container(
        color: Colors.white,
        child: FutureBuilder<dynamic> (
          future: httpTest('https://zzzzzhahatestserver.beeblock.co.kr/api/tb_content/get_pk?pk=0513_01&category=BN&subCategory=BN_E&lang=ko&isNear=true&isSubCategory=false&ver=1628144302092'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return Html(data : snapshot.data["content"]["content"]);
            } else {
              return Text("error");
            }
          },
        ),
      ),
    );
  }
}
