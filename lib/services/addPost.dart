import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/post.dart';
import 'package:reviewia/services/postView.dart';

Future getUserDetails(String url)async{

  print("add post+++++");
  http.Response response = await http.get(
    Uri.parse(url),
  );

  String data = response.body;
  var decodedUserData = jsonDecode(data);
  return data;

}