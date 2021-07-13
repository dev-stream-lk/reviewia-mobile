import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class UserState{


  Future<String> setStateUserName (String name,String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userName').toString()!=name){
      await prefs.setString('userName', name);
    }
    if(prefs.getString('token').toString()!=token){
      await prefs.setString('token', token);
    }
    return 'set-it';
  }
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("userName is::"+prefs.getString('userName').toString());
    return (prefs.getString('userName').toString());
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Token is::"+prefs.getString('token').toString());
    return (prefs.getString('token').toString());
  }



}