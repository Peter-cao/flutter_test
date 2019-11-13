import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImagePage'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage('https://mat1.gtimg.com/pingjs/ext2020/qqindex2018/dist/img/qq_logo_2x.png'),
              width: 200,
            ),
            Image.asset("images/2.png",width:200.0)
          ],
        )
      ),
    );
  }
  
}