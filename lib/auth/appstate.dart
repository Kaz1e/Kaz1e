import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  bool isLogin = false;
  String token ;
  int id ;
  AppState() {
    getAppState();
  }
  getLogin() => isLogin;
  setLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }

  getToken() => token;
  setToken(String value) {
    token = value;
    notifyListeners();
  }

  getId() => id;
  setId(int value) {
    id = value;
    notifyListeners();
  }

  Future<void> getAppState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool("isLogin") == true;
    setLogin(isLogin);
    setToken(token);
    setId(id);
  }
}
