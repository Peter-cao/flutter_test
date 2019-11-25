import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StaggerAnimation.dart';

class AnimatePage3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AnimatePage3State();
  }
  
}
class AnimatePage3State extends State<AnimatePage3> with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatePage3State"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color:  Colors.black.withOpacity(0.5),
              ), 
            ),
            child: StaggerAnimation(
              controller: _controller
            ),
          ),
        ),
      ),
    );
  }

}