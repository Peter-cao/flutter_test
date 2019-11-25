import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatePage2B extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatePage2B"),
      ),
      body: Center(
        child: Hero(
          tag: "avatar",
          child: Image.asset("images/1.jpg"),
        ),
      ),
    );
  }

}