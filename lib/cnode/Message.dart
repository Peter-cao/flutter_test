import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MessageState();
  }
  
}
class MessageState extends State<Message>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("消息"),
      ),
      body: Center(
        child: Text("消息"),
      ),
    );
  }

}