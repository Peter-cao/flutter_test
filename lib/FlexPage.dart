import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlexPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlexPage'),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 50,
            height: 100,
            color: Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              color: Colors.yellow,
            ),
          )
        ],
      ),
    );
  }
  
}