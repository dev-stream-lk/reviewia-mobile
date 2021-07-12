import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/services/userState.dart';

class UserServices {

  UserServices(this.url,this.email,this.password, this.firstName,this.lastName);

  UserState userState = new UserState();
  final String url;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

   //add your own ip
  Future getLogin() async {
    http.Response response = await post(
        Uri.parse(url),
        body: jsonEncode(<String,String>{
          "email": email,
          "password": password,
        })
    );
    if (response.statusCode==200){
        await userState.setStateUserName(email);
      return "Can Login";
    }
    // if(response.)
  }

  Future getRegister() async {
    http.Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String>{
          "firstName":firstName,
          "lastName":lastName,
          "email": email,
          "password": password,
        })
    );
    print(response.statusCode);
    if (response.statusCode==201){
      return "Account is Created";
    }
    // if(response.)
  }




}