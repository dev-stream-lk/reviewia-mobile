import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/addPost.dart';
import 'package:reviewia/services/getSubCategory.dart';



////***************** for post add..getCategory

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


////***************** for post add..SubtCategory

List <GetSubCategory> parseAddPost_subcategory(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var sub_categories = list.map((e) => GetSubCategory.fromJson(e)).toList();
  print("hello..");
  return sub_categories;
}

Future <List<GetSubCategory>> fetchSubCategory(id)async{

  String url = KBaseUrl+"api/public/category?id=8";

  final response = await http.get(
      Uri.parse(url),
  );
  print(response.statusCode);
  if(response.statusCode==200){
    return compute(parseAddPost_subcategory,response.body);
  }else{
    throw Exception("API Error in subcategory");
  }

}
