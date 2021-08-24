import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/allCategory.dart';
import 'package:reviewia/services/categoryView.dart';
import 'package:reviewia/services/post.dart';
import 'package:reviewia/services/postView.dart';
import 'package:reviewia/services/addPost.dart';



////***************** for post add..

List <AddPost_category> parseAddPost_category(String responseBody){
var list = json.decode(responseBody) as List<dynamic>;
var categories = list.map((e) => AddPost_category.fromJson(e)).toList();
print("hello..");
return categories;
}

Future <List<AddPost_category>> fetchCategory()async{

String url = KBaseUrl+"api/public/category/all";
final response = await http.get( Uri.parse(url));
if(response.statusCode==200){
return compute(parseAddPost_category,response.body);
}else{
throw Exception("API Error");
}

}
