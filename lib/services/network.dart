import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/components/review_cards.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/structures/allCategory.dart';
import 'package:reviewia/structures/categoryView.dart';
import 'package:reviewia/structures/post.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedCatergory.dart';

List<Post> parsePost(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => Post.fromJson(e)).toList();
  return posts;
}

Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  if (response.statusCode == 200) {
    return compute(parsePost, response.body);
  } else {
    throw Exception("API Error");
  }
}

List<PostsView> parsePostView(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => PostsView.fromJson(e)).toList();
  return posts;
}

Future<List<PostsView>> fetchPostView() async {
  String url = KBaseUrl + "api/public/posts/all";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parsePostView, response.body);
  } else {
    throw Exception("API Error");
  }
}

List<PostsView> parsePostViewStep(String responseBody) {
  var list = json.decode(responseBody);
  var posts = list.map((e) => PostsView.fromJson(e)).toList();
  return posts;
}

Future<List<PostsView>> fetchPostViewStep(String page, String size) async {
  String url = KBaseUrl + "api/public/posts?page=" + page + "&size=" + size;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parsePostViewStep, response.body);
  } else {
    throw Exception("API Error");
  }
}

List<AllCatergory> parseCategoryView(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => AllCatergory.fromJson(e)).toList();
  return posts;
}

Future<List<AllCatergory>> fetchAllCategoryView() async {
  String url = KBaseUrl + "api/public/category/all";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parseCategoryView, response.body);
  } else {
    throw Exception("API Error");
  }
}

List<ImgURL> parseImageURL(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => ImgURL.fromJson(e)).toList();
  return posts;
}

List<CategoryView> parseCategoryViewGet(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => CategoryView.fromJson(e)).toList();
  return posts;
}

Future<List<CategoryView>> fetchCategoryView() async {
  String url = KBaseUrl + "api/public/category/names";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parseCategoryViewGet, response.body);
  } else {
    throw Exception("API Error");
  }
}

List<SelectedCatergory> parseSelectedCatergoryGet(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  print(list.toString());
  // var posts = SelectedCatergory.fromJson(list);
  var posts = list.map((e) => SelectedCatergory.fromJson(e)).toList();
  return posts;
}

Future<SelectedCatergory> fetchSelectedCatergory(String catId) async {
  String url = KBaseUrl + "api/public/category/"+catId+"/subcategory/";
  // String url = KBaseUrl+"api/public/category/all";
  // final response = await http.get( Uri.parse(url));
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    late SelectedCatergory selectedCatergory;
    print(response.body.toString());
    var decodedUserData = jsonDecode(response.body);

      selectedCatergory = new SelectedCatergory(
          categoryId: decodedUserData['categoryId'],
          categoryName: decodedUserData['categoryName'],
          type: decodedUserData['type'],
          subCategoryList: decodedUserData['subCategoryList']);

    return selectedCatergory;
  } else {
    throw Exception("API Error");
  }
}

Future getAllCategoryPosts(String catId)async{
  String url = KBaseUrl + "api/public/post/category?id="+catId;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return compute(parsePostView, response.body);
  } else {
    throw Exception("API Error");
  }
}

Future getAllSubCategoryPosts(String subCategoryId)async{
  String url = KBaseUrl + "api/public/post/category/sub?id="+subCategoryId;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return compute(parsePostView, response.body);
  } else {
    throw Exception("API Error");
  }
}

//get Reviews

List<ReviewStruct> parseReviewStructGet(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var posts = list.map((e) => ReviewStruct.fromJson(e)).toList();
  return posts;
}

Future<List<ReviewStruct>> fetchReviewStruct(String postId) async {
  print(postId);
  String url = KBaseUrl + "api/public/review/all?id="+postId;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parseReviewStructGet, response.body);
  } else {
    throw Exception("API Error");
  }
}

Future postReview(String userName,String t,String createdUser,int postId,double rate,String des) async {
  String url = KBaseUrl + "api/user/review?email="+userName;
  http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : t,
      },
      body: jsonEncode(<String,dynamic>{
        "reviewedBy": createdUser,
        "postId": postId,
        "description": des,
        "userRate": rate
      })
  );
  print(response.statusCode);
  if (response.statusCode==200){
    return "Review is set";
  }
  // if(response.)
}
