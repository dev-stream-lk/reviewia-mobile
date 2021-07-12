import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class UserState{


  Future<String> setStateUserName (String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userName').toString()!=name){
      await prefs.setString('userName', name);
    }
    return 'set-it';
  }
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("userName is::"+prefs.getString('userName').toString());
    return (prefs.getString('userName').toString());
  }

}