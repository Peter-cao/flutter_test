import 'package:flutter/material.dart';
import 'TextPage.dart';
import 'ButtonPage.dart';
import 'ContainerPage.dart';
import 'ImagePage.dart';
import 'FlexPage.dart';
import 'AnimatePage.dart';
import 'HttpPage.dart';
import 'CNodeDetail.dart';



void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      routes:{
        "textPage":(context)=> TextPage(),
        "ButtonPage":(context)=> ButtonPage(),
        "ContainerPage":(context)=> ContainerPage(),
        "ImagePage":(context)=> ImagePage(),
        "FlexPage":(context)=> FlexPage(),
        "AnimatePage":(context)=> AnimatePage(),
        "HttpPage":(context)=> HttpPage(),
        "CNodeDetail":(context)=> CNodeDetail(),
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState() =>MyHomePageState();
  
}
class MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('测试用例')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Text'),
              onPressed: (){
                Navigator.pushNamed(context, 'textPage');
              },
            ),
            RaisedButton(
              child: Text('buttom'),
              onPressed: (){
                Navigator.pushNamed(context, 'ButtonPage');
              },
            ),
            RaisedButton(
              child: Text('Container'),
              onPressed: (){
                Navigator.pushNamed(context, 'ContainerPage');
              },
            ),
            RaisedButton(
              child: Text('Image'),
              onPressed: (){
                Navigator.pushNamed(context, 'ImagePage');
              },
            ),
            RaisedButton(
              child: Text('Flex'),
              onPressed: (){
                Navigator.pushNamed(context, 'FlexPage');
              },
            ),
            RaisedButton(
              child: Text('http'),
              onPressed: (){
                Navigator.pushNamed(context, 'HttpPage');
              },
            ),
            RaisedButton(
              child: Text('动画'),
              onPressed: (){
                Navigator.pushNamed(context, 'AnimatePage');
              },
            ),
            RaisedButton(
              child: Text('路由传参'),
              onPressed: (){
                Navigator.pushNamed(context, 'textPage',arguments:{'a':'test'});
              },
            ),
            
          ],
        ),
      ),
    );
  }

}