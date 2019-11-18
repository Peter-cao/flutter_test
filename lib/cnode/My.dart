import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class My extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
  
}
class MyState extends State<My>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("我的"),
      ),
      body: Center(
        child: Text("我的"),
      ),
    );
  }
  
}