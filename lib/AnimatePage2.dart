import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AnimatePage2B.dart';

class AnimatePage2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AnimatePage2State();
  }
}
class AnimatePage2State extends State<AnimatePage2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatePage2State"),
      ),
      body: Container(
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset(
                "images/1.jpg",
                width: 50.0,),
            ),
          ),
          onTap: (){
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: AnimatePage2B(),
                );
              }
            ));
          },
        ),
      ),
    );
  }

}