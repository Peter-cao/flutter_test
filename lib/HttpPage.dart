
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
  bool _isLoading = false;
  String _currTab = '';
  List<Tab> _tabs;
  TabController _tabController; //需要定义一个Controller
  ScrollController _scrollController; 
  Map<String,dynamic> _topicsOfCategory = {
      "": {
        "isFetched": false,
        "label": "全部",
        "currentPage": 1,
        "list": []
      },
      "good": {
        "isFetched": false,
        "label": "精华",
        "currentPage": 1,
        "list": []
      },
      "share": {
        "isFetched": false,
        "label": "分享",
        "currentPage": 1,
        "list": []
      },
      "job": {
        "isFetched": false,
        "label": "招聘",
        "currentPage": 1,
        "list": []
      }
  };
  initState(){
    super.initState();
    _getData();
    _tabController = TabController(length: _topicsOfCategory.length,vsync:this);
    _tabController.addListener((){  
        // print(_tabController.index);
        _currTab =  _topicsOfCategory.keys.toList()[_tabController.index];
        if(_topicsOfCategory[_currTab]["list"].length==0){
          _getData();
        }
    });
    _scrollController = ScrollController();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // print(_scrollController.position.maxScrollExtent);
        _topicsOfCategory[_currTab]['currentPage'] += 1;
        _getData();
      }
    });
    _tabs = <Tab>[];
    _topicsOfCategory.forEach((k, v) {
      _tabs.add(new Tab(
        text: v["label"]
      ));
    });
  }

  Future<void> _handleRefresh(){
    _topicsOfCategory[_currTab]['currentPage'] = 1;
    return _getData();
  }
  dispose(){
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }
  Widget _renderLoading(){
    return Center(
      child:CircularProgressIndicator() ,
    );
  }
  Widget _renderRow(BuildContext context, item) {
    return ListTile( 
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
    );
  }
  Widget _buildLoadMore() {
    // return Container(child:  Padding(
    //   padding: const EdgeInsets.all(18.0),
    //   child: Center(
    //     child: Text("加载中……"),
    //   ),
    // ),color: Colors.white70,);
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: !_isLoading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _tabViews = [];
    _topicsOfCategory.forEach((key,topic){
      _tabViews.add(!topic["isFetched"]?_renderLoading():
        RefreshIndicator(
          child:ListView.separated(
            itemCount:topic['list'].length+1,
            separatorBuilder: (BuildContext context, int index) => Divider(color:Colors.grey[600]),
            itemBuilder: (BuildContext context, int index) {
              if(index==topic['list'].length){
                return _buildLoadMore();
              }else{
                return _renderRow(context,topic['list'][index]);
              }
            },
            controller: _scrollController,
          ),
          onRefresh:_handleRefresh
        )
        
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('CNode'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
  Future  _getData() async{
    if(_isLoading) return ;
    _isLoading = true;
    var url= "https://cnodejs.org/api/v1/topics?tab=${_currTab}&limit=15&page=${_topicsOfCategory[_currTab]['currentPage']}";
    Dio dio = new Dio();
    Response response = await dio.get(url);
    if(response.data['success']){
      _isLoading = false;
      setState(() {
        if(_topicsOfCategory[_currTab]['currentPage']==1){
          _topicsOfCategory[_currTab]['list'] =  response.data['data'];
        }else{
          _topicsOfCategory[_currTab]['list'].addAll(response.data['data']);
        }
        _topicsOfCategory[_currTab]['isFetched'] = true;
      });
      
    }
  }

}