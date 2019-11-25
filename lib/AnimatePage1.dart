import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatePage1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AnimatePage1State();
  }
  
}
class AnimatePage1State extends State<AnimatePage1> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController  controller;

  @override
  void initState() {
    super.initState();
    controller  = AnimationController(
      duration: Duration(seconds:3 ),
      vsync: this
    );
    // animation = CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.bounceIn
    // );
    animation  = Tween(begin: 0.0,end: 300.0).animate(controller)..addListener((){
      setState(()=>{});
    })..addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });

    
    controller.forward();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatePage1"),
      ),
      body: Center(
        child: Image.asset("images/2.png",
          width: animation.value,
          height: animation.value,),
      ),
    );
  }

}