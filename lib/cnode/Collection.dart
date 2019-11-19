import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myapp/model/Topic.dart';
import '../model/Auth.dart';
import 'package:provider/provider.dart';
import '../utils/Utils.dart';

class Collection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CollectionState();
  }
}
class CollectionState extends State<Collection>{
  bool _isFetched = false;
  List _topicList = [];
  String _loginname;
  @override
  Widget build(BuildContext context) {
    _loginname =  Provider.of<Auth>(context).loginname;
    _getData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        centerTitle:true,
        title: Text("收藏"),
      ),
      body: Center(
        child: _isFetched?_randerList(context):_renderLoading(),
      ),
    );
  }
  Widget _renderLoading(){
    return Center(
      child:CircularProgressIndicator() ,
    );
  }
  Widget _randerList(context){
    return ListView.separated(
      itemCount:_topicList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color:Colors.grey[600]),
      itemBuilder: (BuildContext context, int index) {
          return _renderRow(context,_topicList[index]);
      }
    );
  }
  Widget _renderRow(context,topic){
    Topic item = Topic.fromJson(topic);
    return ListTile( 
        key: Key(item.id),
        title: Text(item.title,style: TextStyle(fontSize: 18.0) ),
        subtitle:_randerSubtitle(item),
        leading:  CircleAvatar(
          backgroundImage: NetworkImage(item.author.avatarUrl),
        ),
        trailing: Text("${item.replyCount}/${item.visitCount}"),
        onTap: (){
          Navigator.pushNamed(context, 'CNodeDetail',arguments:item);
        },
    );
  }
  Widget _randerSubtitle(Topic item){
    List<Widget> list  = [];
    if(item.good||item.top){
      list.add(Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(item.good?"精华":"置顶",style: TextStyle(
          fontSize: 14,
          color: Colors.white
        ),),
      ));
    }
    list.add(Text(item.author.loginname+"   "+Utils.format(item.lastReplyAt)));
    return Row(
      children:list
    );
  }
  Future  _getData() async{
    var url= "https://cnodejs.org/api/v1/topic_collect/$_loginname";
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.data['success']){
      if(mounted){
        setState(() {
            _topicList =  response.data['data'];
            _isFetched = true;
        });
      }
    }
  }
}