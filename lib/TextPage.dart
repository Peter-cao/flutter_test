import 'package:flutter/material.dart';

class TextPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      final Map args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar:AppBar(
        title: Text('TextPage'),
      ),
      body: Center(
        child: Text(
          'Hello Word ${args != null?args['a']:''}',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color:Color(0xFF0000ff)
          ),
        ),
      ),
    );
  }
}