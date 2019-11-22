import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../model/Auth.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
  
}

class LoginState extends State<Login>{
  bool isLoading = false ,success = true;
  TextEditingController  textController;
  GlobalKey _formKey= new GlobalKey<FormState>();
  FocusNode focusNode1 = new FocusNode();

  initState(){
    textController = TextEditingController();
    textController.text = "da0198ac-7bd0-4308-b144-afa03b1c6d8a";
    super.initState();
  }

  dispose(){
    super.dispose();
    textController.dispose();
  }

  Future  _login() async{
    if(!(_formKey.currentState as FormState).validate()){
      return;
    }
    focusNode1.unfocus();
    try {
      if(isLoading) return;
      setState(() {
        isLoading = true;
      });
      var url= "https://cnodejs.org/api/v1/accesstoken";
      Dio dio = new Dio();
      Response response = await dio.post(url,data:{
        "accesstoken":textController.text
      });
      setState(() {
        isLoading = false;
      });
      print(response);
      if(response.data['success']){
        success = true;
        Provider.of<Auth>(context).setAccesstoken(textController.text,response.data['loginname']);
      }
    }on DioError catch(e) {
      print(e);
      success = false;
      setState(() {
        isLoading = false;
      });
    }
    (_formKey.currentState as FormState).validate();
  }

  Future _showDialog(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("在CNode社区网站登录你的账户，然后在右上角找到[设置]按钮，点击进入后将页面滑动到最底部来查看你的Access Token。"),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
          ],
        );
      }
    );
  }
  Widget _randerBg(){
    return Column(
      children: <Widget>[
        Container(
          height: 150.0,
          decoration:BoxDecoration(
            image:DecorationImage(
              image:AssetImage("images/login_header_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:25.0),
                child: Image.asset("images/logo_light.png",height:50.0),
              )
            ],
          )
        ),
        Expanded(
          child: Container(
            decoration:BoxDecoration(
              color: Colors.grey[50]
            )
          ),
        )
      ],
    );
  }
  Widget _randerLogin(context){
    return Positioned(
      top: 90.0,
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("cnodejs.org",style: TextStyle(
              color: Colors.white
            ),),
          ),
          Form(
            key: _formKey, //设置globalKey，用于后面获取FormState
            child: Card(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Access Token",
                      ),
                      validator: (v){
                        if(v.trim().length > 0){
                          if(success){
                            return null;
                          }else{
                            return "Access Token非法";
                          }
                        }else{
                          return "Access Token不能为空";
                        }

                      },
                      onEditingComplete:(){
                        _login();
                      },
                      focusNode: focusNode1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        onPressed: (){
                          _login();
                        },
                        child: Text("登录",style: TextStyle(
                          color: Colors.white
                        ),),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.crop_free),
                          label: Text("扫码登录"),
                          onPressed: (){
                            Navigator.pushNamed(context, 'QrCode');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              _showDialog();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("如何获取Access Token?",style: TextStyle(
                color: Theme.of(context).accentColor,
                decoration:TextDecoration.underline
              )),
            ),
          ),
        ],
      ),
    );
  }
  Widget _randerLoading(){
    return AnimatedOpacity(
      duration: Duration(milliseconds:300),
      opacity:isLoading?1.0:0.0,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("登录"),
      ),
      body: Stack(
        children: <Widget>[
          _randerBg(),
          _randerLogin(context),
          _randerLoading()
        ],
      ),
    );
  }
  
}