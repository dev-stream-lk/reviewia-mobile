import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/components/review_cards.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/notification.dart';
import 'package:reviewia/services/getBrands.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/allCategory.dart';
import 'package:reviewia/structures/categoryView.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:reviewia/structures/loadPost.dart';
import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/post.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedCatergory.dart';
import 'package:reviewia/structures/selectedGroup.dart';

//posts

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

Future<PostsView> fetchPostViewById(String id) async {
  String url = KBaseUrl + "api/public/post?id=" + id;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    late PostsView postsView;
    var decodedUserData = jsonDecode(response.body);
    postsView = new PostsView(
      title: decodedUserData['title'],
      createdBy: '',
      reviews: [],
      email: decodedUserData['email'],
      viewCount: decodedUserData['viewCount'],
      rate: decodedUserData['rate'],
      description: '',
      subCategory: '',
      blocked: false,
      type: 'no',
      brand: new Brand.fromJson(decodedUserData['brand']),
      postId: decodedUserData['postId'],
      createdAt: '',
      imgURL: [],
    );
    return postsView;
  } else {
    throw Exception("API Error");
  }
}

Future<PostsView> fetchPostViewByIdInNotification(String id) async {
  String url = KBaseUrl + "api/public/post?id=" + id;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    late PostsView postsView;
    late List<ImgURL> imges = [];
    var decodedUserData = jsonDecode(response.body);

    if (decodedUserData['imgURL'] != null) {
      decodedUserData['imgURL'].forEach((v) {
        imges.add(new ImgURL.fromJson(v));
      });
    }
    // print(imges[0].url);
    postsView = new PostsView(
      title: decodedUserData['title'],
      createdBy: decodedUserData['createdBy'],
      reviews: [],
      email: decodedUserData['email'],
      viewCount: decodedUserData['viewCount'],
      rate: decodedUserData['rate'],
      description: decodedUserData['description'],
      subCategory: decodedUserData['subCategory'],
      blocked: decodedUserData['blocked'],
      type: decodedUserData['type'],
      brand: new Brand.fromJson(decodedUserData['brand']),
      postId: decodedUserData['postId'],
      createdAt: decodedUserData['createdAt'],
      imgURL: imges,
    );
    return postsView;
  } else {
    throw Exception("API Error");
  }
}

List<LoadPost> parsePostViewStep(String responseBody) {
  var list = json.decode(responseBody);
  var posts = list.map((e) => LoadPost.fromJson(e)).toList();
  return posts;
}

Future<LoadPost> fetchPostViewStep(String page, String size) async {
  String url = KBaseUrl +
      "api/public/posts?page=" +
      page +
      "&size=" +
      size +
      "&sort=updatedAt";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // return compute(parsePostViewStep, response.body);
    // print(response.body);
    late LoadPost loadPost;
    var decodedUserData = jsonDecode(response.body);
    loadPost = new LoadPost(
        totalItems: decodedUserData['totalItems'],
        totalPages: decodedUserData['totalPages'],
        currentPage: decodedUserData['currentPage'],
        posts: decodedUserData['posts']);

    return loadPost;
  } else {
    throw Exception("API Error");
  }
}

Future<LoadPost> fetchPostFilter(
    String type,
    String category,
    String subCategory,
    String brand,
    double rating,
    String page,
    String size) async {
  String url;
  if (category == 'All' && subCategory == "All" && brand == 'All') {
    url = KBaseUrl +
        "api/public/posts?search=type:" +
        type +
        ",rate>" +
        rating.toString() +
        "&page=" +
        page +
        "&size=" +
        size +
        "&sort=createdAt&order=asc";
  }else if (subCategory == "All" && brand == 'All' && category != 'All') {
    url = KBaseUrl +
        "api/public/posts?search=type:" +
        type +
        ",category:" +
        category +
        ",rate>" +
        rating.toString() +
        "&page=" +
        page +
        "&size=" +
        size +
        "&sort=createdAt&order=asc";
  }
  else if (subCategory != "All" && brand == 'All' && category != 'All') {
    url = KBaseUrl +
        "api/public/posts?search=type:" +
        type +
        ",category:" +
        category +
        ",subCategory:" +
        subCategory +
        ",rate>" +
        rating.toString() +
        "&page=" +
        page +
        "&size=" +
        size +
        "&sort=createdAt&order=asc";
  }else if (subCategory != "All" && brand != 'All' && category != 'All') {
    url = KBaseUrl +
        "api/public/posts?search=type:" +
        type +
        ",category:" +
        category +
        ",subCategory:" +
        subCategory +
        ",brand:" +
        brand +
        ",rate>" +
        rating.toString() +
        "&page=" +
        page +
        "&size=" +
        size +
        "&sort=createdAt&order=asc";
  }
  else {
    url = KBaseUrl +
        "api/public/posts?search=category:electronics,type:p,brand:Apple&page=" +
        page +
        "&size=" +
        size +
        "&sort=updatedAt";
  }

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // return compute(parsePostViewStep, response.body);
    // print(response.body);
    late LoadPost loadPost;
    var decodedUserData = jsonDecode(response.body);
    loadPost = new LoadPost(
        totalItems: decodedUserData['totalItems'],
        totalPages: decodedUserData['totalPages'],
        currentPage: decodedUserData['currentPage'],
        posts: decodedUserData['posts']);

    return loadPost;
  } else {
    throw Exception("API Error");
  }
}

Future<LoadPost> fetchPostViewSearch(String title) async {
  String url = KBaseUrl + "api/public/posts??title=" + title;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // return compute(parsePostViewStep, response.body);
    // print(response.body);
    late LoadPost loadPost;
    var decodedUserData = jsonDecode(response.body);
    loadPost = new LoadPost(
        totalItems: decodedUserData['totalItems'],
        totalPages: decodedUserData['totalPages'],
        currentPage: decodedUserData['currentPage'],
        posts: decodedUserData['posts']);

    return loadPost;
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
  String url = KBaseUrl + "api/public/category/" + catId + "/subcategory/";
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

Future getAllCategoryPosts(String catId) async {
  String url = KBaseUrl + "api/public/post/category?id=" + catId;
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

Future getAllSubCategoryPosts(String subCategoryId) async {
  String url = KBaseUrl + "api/public/post/category/sub?id=" + subCategoryId;
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

List<GetBrands> parseGetBrandList(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  print(list.toString());
  // var posts = SelectedCatergory.fromJson(list);
  var brandList = list.map((e) => GetBrands.fromJson(e)).toList();
  return brandList;
}

Future getBrandList(String subCategoryId) async {
  String url = KBaseUrl + "api/public/subcategory/" + subCategoryId + "/brands";
  GetBrands getBrands;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    // var decodedUserData = jsonDecode(response.body);
    return compute(parseGetBrandList, response.body);
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
  String url = KBaseUrl + "api/public/review/all?id=" + postId;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(parseReviewStructGet, response.body);
  } else {
    throw Exception("API Error");
  }
}

Future postReview(String userName, String t, String createdUser, int postId,
    double rate, String des) async {
  String url = KBaseUrl + "api/user/review?email=" + userName;
  http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': t,
      },
      body: jsonEncode(<String, dynamic>{
        "reviewedBy": createdUser,
        "postId": postId,
        "description": des,
        "userRate": rate
      }));
  print(response.statusCode);
    return response;
  // if(response.)
}

Future<ReviewStruct> fetchReviewOfNotification(String id) async {
  String token = await UserState().getToken();
  String url = KBaseUrl + 'api/user/review/' + id;
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': token},
  );
  ReviewStruct reviewStruct;
  print(response);
  if (response.statusCode == 200) {
    var decodedUserData = jsonDecode(response.body);
    reviewStruct = new ReviewStruct(
        reviewId: decodedUserData['reviewId'],
        reviewedBy: decodedUserData['reviewedBy'],
        email: decodedUserData['email'],
        postId: decodedUserData['postId'],
        createdAt: decodedUserData['createdAt'],
        description: decodedUserData['description'],
        userRate: decodedUserData['userRate'],
        likeCount: decodedUserData['likeCount'],
        dislikeCount: decodedUserData['dislikeCount'],
        reportCount: decodedUserData['reportCount'],
        sentimentRate: decodedUserData['sentimentRate'],
        finalRate: decodedUserData['finalRate'],
        blocked: decodedUserData['blocked'],
        likedList: [],
        dislikedList: []);

    return reviewStruct;
  } else {
    throw Exception("API Error");
  }
}

//create inStantgroup
Future createInstantGroup(String postId, List<String> reviewersList) async {
  String userName = await UserState().getUserName();
  String token = await UserState().getToken();
  print(postId);
  String url =
      KBaseUrl + "api/user/group?email=" + userName + "&post=" + postId;

  http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(<String, dynamic>{"emails": reviewersList}));

  print(response.statusCode);
  if (response.statusCode == 201) {
    return "Instant Group is Created";
  } else if (response.statusCode == 412) {
    return "Already Group is crated";
  }
}

Future getInstantGroupforNotification(String id) async {
  String t = await UserState().getToken();
  String url = KBaseUrl + 'api/user/group/' + id;
  ChatListStruct chatListStruct;
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  if (response.statusCode == 200) {
    // return compute(parsePostViewStep, response.body);
    // print(response.body);

    var data = jsonDecode(response.body);
    chatListStruct = new ChatListStruct(
        id: data['id'],
        createdAt: data['createdAt'],
        postId: data['postId'],
        active: data['active'],
        createdBy: new CreatedBy.fromJson(data['createdBy']));

    print("Chat id is :" + chatListStruct.id.toString());
    return chatListStruct;
  } else {
    throw Exception("API Error");
  }
}

//get Notifications

Future getNumberOfNotification(String userName) async {
  String url = KBaseUrl + "api/user/notification/count?email=" + userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  print(response.body);
  return response.body;
}

List<NotificationStruct> parseNotifications(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var notifications = list.map((e) => NotificationStruct.fromJson(e)).toList();
  return notifications;
}

Future<List<NotificationStruct>> fetchNotification() async {
  String userName = await UserState().getUserName();
  String url = KBaseUrl + "api/user/notification?email=" + userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  print(response);
  if (response.statusCode == 200) {
    return compute(parseNotifications, response.body);
  } else {
    throw Exception("API Error");
  }
}

Future setMarkedOfNotification(String nId) async {
  String url = KBaseUrl + "api/user/notification/edit?id=" + nId;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  print(response.body);
  return response.body;
}


Future UpdateReviewById(String reviewId, String userName, String t, String createdUser, int postId,
    double rate, String des) async {
    print("review Id-"+ reviewId.toString());
    print("UserName-"+ userName.toString());
    print("creator-"+ createdUser.toString());
    print("review-"+ des.toString());


  String url = KBaseUrl + "api/user/review?email=" + userName+"&id="+ reviewId.toString() ;
  http.Response response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': t,
      },
      body: jsonEncode(<String, dynamic>{
        "reviewedBy": createdUser,
        "postId": postId,
        "description": des,
        "userRate": rate
      }));
  print(response.statusCode);
  return response;
  // if(response.)
}