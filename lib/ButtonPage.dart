import 'package:flutter/material.dart';
class ButtonPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('ButtonPage')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Button'),
              onPressed: (){

              },
            ),
            FlatButton(
              child: Text("Button"),
              color: Colors.blue,
              onPressed: (){},
            ),
            OutlineButton(
              child: Text('Button'),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
  
}