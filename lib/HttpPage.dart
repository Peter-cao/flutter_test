
import 'package:flutter/material.dart';
import 'cnode/TopicList.dart';
import 'cnode/Collection.dart';
import 'cnode/Message.dart';
import 'cnode/My.dart';
import 'cnode/Login.dart';
import 'model/Auth.dart';
import 'package:provider/provider.dart';



class HttpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HttpPageState();
  }
}

class HttpPageState extends State<HttpPage> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;
  bool isLogin = false;
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    isLogin =  Provider.of<Auth>(context).isLogin;
    List<Widget> _widgetOptions = <Widget>[
      TopicList(),
      isLogin?Collection():Login(),
      isLogin?Message():Login(),
      isLogin?My():Login(),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('收藏'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('消息'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:Theme.of(context).accentColor,
        selectedFontSize:12.0,
        onTap: _onItemTapped,
      ),
    );
  }
}