import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/allCategory.dart';
import 'package:reviewia/services/categoryView.dart';
import 'package:reviewia/services/post.dart';
import 'package:reviewia/services/postView.dart';


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

List <PostsView>parsePostView(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => PostsView.fromJson(e)).toList();
  return posts;
}

Future <List<PostsView>> fetchPostView() async{
  String url = KBaseUrl+"api/public/posts/all";
  final response = await http.get( Uri.parse(url));
  if(response.statusCode==200){
    return compute(parsePostView,response.body);
  }else{
    throw Exception("API Error");
  }
}

List <AllCatergory>parseCategoryView(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => AllCatergory.fromJson(e)).toList();
  return posts;
}

Future <List<AllCatergory>> fetchAllCategoryView() async{
  String url = KBaseUrl+"api/public/category/all";
  final response = await http.get( Uri.parse(url));
  if(response.statusCode==200){
    return compute(parseCategoryView,response.body);
  }else{
    throw Exception("API Error");
  }
}

List <ImgURL>parseImageURL(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => ImgURL.fromJson(e)).toList();
  return posts;
}


List <CategoryView>parseCategoryViewGet(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => CategoryView.fromJson(e)).toList();
  return posts;
}

Future <List<CategoryView>> fetchCategoryView() async{
  String url = KBaseUrl+"api/public/category/names";
  final response = await http.get( Uri.parse(url));
  if(response.statusCode==200){
    return compute(parseCategoryViewGet,response.body);
  }else{
    throw Exception("API Error");
  }
}