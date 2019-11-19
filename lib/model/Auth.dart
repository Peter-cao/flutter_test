import 'package:flutter/material.dart';
class Auth with ChangeNotifier {
  String _accesstoken;
  String _loginname;
  get accesstoken => _accesstoken;
  get loginname => _loginname;
  get isLogin => _accesstoken!=null;

  void setAccesstoken(String accesstoken,String loginname) {
    _accesstoken = accesstoken;
    _loginname = loginname;
    notifyListeners();
  }
}