import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/services/post.dart';


List <Post> parsePost(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => Post.fromJson(e)).toList();
  return posts;
}

Future <List<Post>> fetchPost()async{

  final response = await http.get( Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  if(response.statusCode==200){
    return compute(parsePost,response.body);
  }else{
    throw Exception("API Error");
  }

}