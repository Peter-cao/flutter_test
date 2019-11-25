import 'package:flutter/material.dart';
import 'package:myapp/model/Topic.dart';
import 'TextPage.dart';
import 'ButtonPage.dart';
import 'ContainerPage.dart';
import 'ImagePage.dart';
import 'FlexPage.dart';
import 'AnimatePage.dart';
import 'AnimatePage1.dart';
import 'AnimatePage2.dart';
import 'AnimatePage3.dart';
import 'HttpPage.dart';
import 'cnode/CNodeDetail.dart';
import 'cnode/qrcode.dart';
import 'model/Topic.dart';
import 'package:provider/provider.dart';
import 'model/Auth.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Auth>.value(
      value: Auth(),
      child: MaterialApp(
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
          "AnimatePage1":(context)=> AnimatePage1(),
          "AnimatePage2":(context)=> AnimatePage2(),
          "AnimatePage3":(context)=> AnimatePage3(),
          "HttpPage":(context)=> HttpPage(),
          "QrCode":(context)=> QrCode(),
          "CNodeDetail":(context){
            Topic topic  = ModalRoute.of(context).settings.arguments;
            return CNodeDetail(id:topic.id,title:topic.title);
          },
        },
        home: new MyHomePage(),
      )
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
              child: Text('动画1'),
              onPressed: (){
                Navigator.pushNamed(context, 'AnimatePage1');
              },
            ),
            RaisedButton(
              child: Text('Hero动画'),
              onPressed: (){
                Navigator.pushNamed(context, 'AnimatePage2');
              },
            ),
            RaisedButton(
              child: Text('交织动画'),
              onPressed: (){
                Navigator.pushNamed(context, 'AnimatePage3');
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
