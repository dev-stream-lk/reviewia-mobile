
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/favouriteListStruct.dart';
import 'package:reviewia/structures/myPostStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:reviewia/structures/postView.dart';

List<PostsView> parseMyPostView(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => PostsView.fromJson(e)).toList();
  return posts;
}

Future <List<PostsView>> fetchMyPost() async {
  String userName = await UserState().getUserName();
  String url = KBaseUrl + "api/user/posts?email="+userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization' : t
    },
  );
  if (response.statusCode == 200) {
    return compute(parseMyPostView, response.body);
  } else {
    throw Exception("API Error");
  }
}