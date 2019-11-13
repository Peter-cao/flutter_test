import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ContainerPage")
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  width: 200,
                  height: 100,
                  child: Text(
                    "Hello Container ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ),
                Container(
                  color: Colors.blue,
                  width: 200,
                  height: 100,
                  margin: EdgeInsets.only(top:30),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Hello Container ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.only(top:30),
                  child: Text(
                    "Hello Container ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.only(top:30),
                  transform: Matrix4.rotationZ(0.5),
                  child: Text(
                    "Hello Container ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                )
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: Image.asset("images/2.png",width:100.0),
            )
        ],
      )
    );
  }
  
}