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

  Future<String>setStateDisplayName(String displayName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('displayName').toString()!=displayName){
      await prefs.setString('displayName', displayName);
    }
    return 'set-Display Name';
  }

  Future<String>setStateAvatar(String avatar) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('avatar').toString()!=avatar){
      await prefs.setString('avatar', avatar);
    }
    return 'set-avatar';
  }

  Future<String>setNumberOfNotification(String noOfNotification) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('noOfNotification').toString()!=noOfNotification){
      await prefs.setString('noOfNotification', noOfNotification);
    }
    return 'set-noOfNotification';
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
  Future<String> getDisplayName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Display Name is::"+prefs.getString('displayName').toString());
    return (prefs.getString('displayName').toString());
  }

  Future getNoOfNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("noOfNotification is::"+prefs.getString('noOfNotification').toString());
    return (prefs.getString('noOfNotification').toString());
  }
  Future getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("avatar is::"+prefs.getString('avatar').toString());
    return (prefs.getString('avatar').toString());
  }

  String SendNotificationNumber(){
    var dd = getNoOfNotification();
    return dd.toString();
  }


}