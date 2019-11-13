
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HttpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HttpPageState();
  }
  
}

class HttpPageState extends State<HttpPage> with SingleTickerProviderStateMixin{
  List _listAll = [];
  List _listGood = [];
  List _listShare = [];
  List _listJob = [];
  String _tab = 'all';
  TabController _tabController; //需要定义一个Controller
  final List tabs = [{
    'title':'全部',
    'id':'all',
  },{
    'title':'精华',
    'id':'good',
  },{
    'title':'分享',
    'id':'share',
  },{
    'title':'招聘',
    'id':'job',
  }];
  Map<String,List<ListTile>> listData = {
    "all":[],
    "good":[],
    "share":[],
    "job":[],
  };
  initState(){
    super.initState();
    _getData();
    _tabController = TabController(length: tabs.length,vsync:this);
    _tabController.addListener((){  
      if(_tabController.indexIsChanging){
        // print(_tabController.index);
        _tab = tabs[_tabController.index]['id'];
        _getData();
      }
    });
  }
  dispose(){
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    var _list;
    if(_tab=="all"){
      _list = _listAll;
    }else if(_tab == 'good'){
      _list = _listGood;
    }else if(_tab == 'share'){
      _list = _listShare;
    }else if(_tab == 'job'){
      _list = _listJob;
    }
    _list.forEach((item){
        listData[_tab].add(ListTile( 
            key: Key(item["id"]),
            title: Text(item["title"],style: TextStyle(fontSize: 18.0) ),
            subtitle: Text(item["create_at"]),
            leading:  CircleAvatar(
              backgroundImage: NetworkImage(item["author"]["avatar_url"]),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.pushNamed(context, 'CNodeDetail',arguments:item);
            },
        ));
      });
    // listData.forEach((key,list){
    //   var _list;
    //   if(key == 'all'){
    //     _list = _list_all;
    //   }else if(key == 'good'){
    //     _list = _list_good;
    //   }else if(key == 'share'){
    //     _list = _list_share;
    //   }else if(key == 'job'){
    //     _list = _list_job;
    //   }
    //   _list.forEach((item){
    //     list.add(ListTile( 
    //         key: Key(item["id"]),
    //         title: Text(item["title"],style: TextStyle(fontSize: 18.0) ),
    //         subtitle: Text(item["create_at"]),
    //         leading:  CircleAvatar(
    //           backgroundImage: NetworkImage(item["author"]["avatar_url"]),
    //         ),
    //         trailing: Icon(Icons.keyboard_arrow_right),
    //         onTap: (){
    //           Navigator.pushNamed(context, 'CNodeDetail',arguments:item);
    //         },
    //     ));
    //   });
    // });
    
    // print(listData);
    return Scaffold(
      appBar: AppBar(
        title: Text('CNode'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabs.map((tab) =>Tab(text: tab['title'])).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:tabs.map((tab) {
          return ListView(
              key:Key(tab["id"]),
              children:ListTile.divideTiles(context:context,tiles:listData[tab["id"]],color: Colors.grey[600]).toList(),
            );
        }).toList(),
      ),
    );
  }
  Future  _getData() async{
    var url= "https://cnodejs.org/api/v1/topics?tab="+_tab;
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.data['success']){
      switch(_tab){
        case  'all':
          setState(() {
            _listAll = response.data['data'];
          });
          break;
        case  'good':
          setState(() {
            _listGood = response.data['data'];
          });
          break;
        case  'share':
          setState(() {
            _listShare = response.data['data'];
          });
          break;
        case  'job':
          setState(() {
            _listJob = response.data['data'];
          });
          break;
      }
      
    }
  }

}