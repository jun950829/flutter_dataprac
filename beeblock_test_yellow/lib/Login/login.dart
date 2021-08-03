import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    late final getId = TextEditingController();
    late final getPW = TextEditingController();

    return Container(
      width: width,
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: getId,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID'
              ),
            ),
            TextField(
              controller: getPW,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
            ),
            FloatingActionButton(
                onPressed: () {

                }, child: Icon(Icons.print),
            ),
          ],
        ),
      ),
    );
  }
}
