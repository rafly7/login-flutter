import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
//0xEEEC2F2F
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: Text('data'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.red,
              height: 400,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              height: 400,
              width: double.infinity,
              child: RaisedButton(
                child: Text('Tap'),
                onPressed: () {
                  print('requests');
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.brown,
              height: 400,
              width: double.infinity,
              child: Text('data'),
            )
          ]
        ),
      ),
    );
  }

  Widget CustomCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Flexible(
            child: Card(
              color: Color(0xBBB3D4F9),
              margin: EdgeInsets.only(right: 20.0,),
              child: Column(
                children: <Widget>[
                  IconButton(
                      iconSize: 50.0, icon: Icon(Icons.list), onPressed: () {}),
                  Text(
                    "List",
                  )
                ],
              ),
            ),
          )),
          Container(
              child: Flexible(
            child: Card(
              color: Color(0xBBB3D4F9),
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                      iconSize: 50.0, icon: Icon(Icons.list), onPressed: () {}),
                  Text(
                    "List",
                  )
                ],
              ),
            ),
          )),
          Container(
              child: Flexible(
            child: Card(
              color: Color(0xBBB3D4F9),
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                      iconSize: 50.0, icon: Icon(Icons.list), onPressed: () {}),
                  Text(
                    "List",
                  )
                ],
              ),
            ),
          )),
          Container(
              child: Flexible(
            child: Card(
              color: Color(0xBBB3D4F9),
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                      iconSize: 50.0, icon: Icon(Icons.list), onPressed: () {}),
                  Text(
                    "List",
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}