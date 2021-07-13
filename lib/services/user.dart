import 'dart:convert';
import 'dart:io';

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

    // print(response.headers);
    var S = response.headers.toString();
    print("It is a String "+ S);

     // print(slist);
    // for(var header in slist){
    //   if (header.isEmpty) {
    //     continue;
    //   }
    //   var splitIdx = header.indexOf(': ');
    //   if (splitIdx == -1) {
    //     continue;
    //   }
    //   print("Header is: "+ header+"\n");
    //   print("index: "+ splitIdx.toString()+"\n");
    //   var key = header.substring(1, splitIdx).toLowerCase();
    //   var value = header.substring(splitIdx + 2);
    //   print("keys: "+ key + "\n");
    //   // if (S.containsKey(key)) {
    //   //   headers[key] = '${headers[key]}, $value';
    //   // } else {
    //   //   headers[key] = value;
    //   // }
    //   // print("index: "+ splitIdx.toString());
    //
    //   // print("ss: "+ header);
    // }

    var ss = S.indexOf('authorization');
    print("It is a String "+ ss.toString());
    if(ss.toString()!='-1'){
      var e = S.indexOf("access-control-max-age");
      print(e.toString());
      var sString = S.substring(ss.toInt()+15,e.toInt()-1);
      print(sString);
      if (response.statusCode==200 && ss != -1){
        await userState.setStateUserName(email,sString);
        return "Can Login";
      }
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
  
  Future getUserDetails()async{
    String t = await userState.getToken();
    print("print token is "+ t);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
       'Authorization': t,
      },
    );
    String data = response.body;
    var decodedUserData = jsonDecode(data);
    print(decodedUserData);
    return decodedUserData;

  }

  Future updatedProfile()async{
    http.Response response = await http.put(
      Uri.parse(url),
      headers:  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode==200){
      return "Updated completd";
    }

  }



}