import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myapp/model/Author.dart';
import 'package:provider/provider.dart';
import '../model/Auth.dart';
import '../utils/Utils.dart';

class My extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
  
}
class MyState extends State<My>{
  Author _me;
  String _loginname;
  bool _isLoading = true;
  
  Future<bool> _showDialog(context){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("确定退出？"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(true), // 关闭对话框
            ),
          ],
        );
      }
    );
  }

  Future  _loadData() async{
    var url= "https://cnodejs.org/api/v1/user/$_loginname";
    Dio dio = new Dio();
    Response response = await dio.get(url);
    // print(response);
    if(response.data['success']){
      _me = Author.fromJson(response.data['data']);
      setState(() {
        _isLoading = false;
      });
    }
  }
  Widget _renderLoading(){
    return Center(
      child:CircularProgressIndicator() ,
    );
  }
  Widget _randerTop(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(40),
              image: DecorationImage(
                image: NetworkImage(_me.avatarUrl),
                fit: BoxFit.cover,
              ),
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(_me.loginname,style: TextStyle(
                  fontSize: 20
                )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("创建于:"+Utils.format1(_me.createAt)),
                      ),
                      Text("积分:"+_me.score.toString()),
                    ],
                  )
                  ,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _randerMid(context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      margin: EdgeInsets.only(top: 20),
      child: ListView(
        shrinkWrap:true,
        children: ListTile.divideTiles(
          context:context,
          tiles: [
            ListTile(
              title: Text("新建主题"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){},
            ),
            ListTile(
              title: Text("我的主题"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){},
            ),
            ListTile(
              title: Text("我的回复"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){},
            ),
          ]
        ).toList()
      )
    );
  }
  
  Widget _randerLogout(context){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      // decoration: BoxDecoration(
      //   color: Colors.white
      // ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            child: Container(
              margin: EdgeInsets.only(top:10,bottom: 10),
              child: Text("登出"),
            ),
            color: Colors.white,
            onPressed: ()async {
              bool islogout = await _showDialog(context);
              if(islogout!=null){
                Provider.of<Auth>(context).setAccesstoken(null,null);
              }else{
                print("取消");
              }
            },
          )
        ],
      )
    );
    
    
  }
  @override
  Widget build(BuildContext context) {
    _loginname = Provider.of<Auth>(context).loginname;
    if(_me == null){
      _loadData();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("我的"),
      ),
      body: _isLoading?_renderLoading():Container(
        decoration:BoxDecoration(
          color: Color(0xFFDDDDDD)
        ),
        child: Column(
          children: <Widget>[
            _randerTop(),
            _randerMid(context),
            _randerLogout(context)
          ],
        ),
      ),
    );
  }
  
}