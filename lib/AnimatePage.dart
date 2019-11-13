import 'package:flutter/material.dart';

class AnimatePage extends StatefulWidget{
  @override
  createState() {
    return AnimatePageState();
  }
  
}
class AnimatePageState extends State<AnimatePage>{
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatePage'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            AnimatedOpacity(
              opacity:_visible?1.0:0.0,
              duration: Duration(milliseconds: 1000),
              child: Image.asset("images/2.png"),
            ),
            RaisedButton(
              child: Text("显示隐藏"),
              onPressed: (){
                setState(() {
                  _visible = !_visible;
                });
              },
            )
          ],
        ),
      ),
    );
  }
  
}