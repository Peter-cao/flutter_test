import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myapp/model/Reply.dart';
import '../utils/Utils.dart';
import 'package:dio/dio.dart';
import '../model/Topic.dart';
import 'package:provider/provider.dart';
import '../model/Auth.dart';


class CNodeDetail extends StatefulWidget{
  final String id;
  final String title;
  CNodeDetail({
    Key key,
    @required this.id,  // 接收一个id参数
    @required this.title,  // 接收一个title参数
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CNodeDetailState(id:id,title:title);
  }
}
class CNodeDetailState extends State<CNodeDetail>{
  CNodeDetailState({
    @required this.id,  // 接收一个id参数
    @required this.title,  // 接收一个title参数
  });
  final String id;
  final String title;
  bool isLoading = true;
  bool _isLogin;
  String _accesstoken="";
  Topic _detail;
  initState(){
    super.initState();
    
  }
  Future  _loadData() async{
    var url= "https://cnodejs.org/api/v1/topic/$id?accesstoken=$_accesstoken";
    Dio dio = new Dio();
    Response response = await dio.get(url);
    
    if(response.data['success']){
      if(mounted){
        setState(() {
          _detail = Topic.fromJson(response.data['data']);
          print(_detail.isCollect);
          isLoading = false;
        });
      }
    }
  }
  Future  _collectTopic() async{

    var url= "https://cnodejs.org/api/v1/topic_collect/${_detail.isCollect?"de_collect":"collect"}";
    Dio dio = new Dio();
    Response response = await dio.post(url,data: {
      "accesstoken":_accesstoken,
      "topic_id": _detail.id 
    });
    print(response);
    if(mounted){
      setState(() {
        _detail.isCollect = !_detail.isCollect;
      });
    }
  }
  Future  _up(id) async{
    var url= "https://cnodejs.org/api/v1/reply/$id/ups";
    Dio dio = new Dio();
    print(url);
    print(_accesstoken);
    Response response = await dio.post(url,data: {
      "accesstoken":_accesstoken,
    });
    print(response);
    if(mounted){
      // setState(() {
      //   _detail.isCollect = !_detail.isCollect;
      // });
    }
  }
  void _showSnackBar(context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('请先登录'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
  Widget _randerTop(BuildContext context){
    
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(_detail.author.avatarUrl),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.red,
              padding:EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_detail.author.loginname,style: TextStyle(fontSize: 14)),
                  Padding(
                    padding:EdgeInsets.only(top:8.0),
                    child: Text(Utils.format(_detail.lastReplyAt)),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            iconSize :18,
            icon: _detail.isCollect? Icon(Icons.favorite,color: Colors.redAccent,): Icon(Icons.favorite_border),
            // splashColor:Colors.transparent,
            onPressed: (){
              if(_isLogin){
                _collectTopic();
              }else{
                _showSnackBar(context);
              }
              
            },
          ),
          IconButton(
            iconSize :18,
            icon: Icon(Icons.reply),
            // splashColor:Colors.transparent,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
  Widget _randerLoading(){
    return Center(
      child:CircularProgressIndicator() ,
    );
  }
  Widget _randerReply(context,Reply reply,int i){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(reply.author.avatarUrl),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(reply.author.loginname+"  "+ i.toString()+"楼"),
                    Text(Utils.format(reply.createAt))
                  ],
                ),
              )
            ),
            IconButton(
              iconSize :18,
              icon: Icon(Icons.reply),
              // splashColor:Colors.transparent,
              onPressed: (){
                print("回复");
              },
            ),
            GestureDetector(
              onTap: (){
                if(_isLogin){
                  _up(reply.replyId);
                }else{
                  _showSnackBar(context);
                }
              },//点击
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up,size: 15.0,),
                    Text("+"+reply.ups.length.toString())
                  ],
                ),
              ),
            ),
          ],
        ),
        Html(
          data:reply.content
        ),
        Divider(color:Colors.grey[600]),
      ],
    );
  }
  Widget _randerReplies(context){
    List<Widget> list  = [];
    list.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text("${_detail.replies.length}回复"),
      )
    );
    for(var i =0;i < _detail.replies.length;i++){
      list.add(
        _randerReply(context,_detail.replies[i],i+1)
      );
    }
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: list,
      ),
    );
  }
  Widget _randerDetail(BuildContext context){
    return Scrollbar(
        child:SingleChildScrollView(
          child:Column(
            children: <Widget>[
              _randerTop(context),
              Html(
                padding: EdgeInsets.all(8.0),
                data: _detail.content,
              ),
              Container(
                height: 20.0,
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD)
                ),
              ),
              _randerReplies(context)
              // _detail.replies??_randerReplies()
            ],
          )
        )
      );
  }
  @override
  Widget build(BuildContext context) {
    _isLogin =  Provider.of<Auth>(context).isLogin;
    if(_isLogin){
      _accesstoken =  Provider.of<Auth>(context).accesstoken;
    }
    if(_detail == null){
      _loadData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return isLoading?_randerLoading():_randerDetail(context);
        }
      ),
    );
  }

}