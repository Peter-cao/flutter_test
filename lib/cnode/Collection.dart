import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Collection extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return CollectionState();
  }
  
}

class CollectionState extends State<Collection>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("收藏"),
      ),
      body: Center(
        child: Text("收藏"),
      ),
    );
  }
  
}