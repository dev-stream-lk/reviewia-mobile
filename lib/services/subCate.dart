import 'package:reviewia/services/postView.dart';

class subCate {
  late int subCategoryId;
  late String subCategoryName;
  late List<dynamic> posts;

  subCate({required this.subCategoryId, required this.subCategoryName, required this.posts});

  subCate.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    posts = json ["posts"];
    // if (json['posts'] != null) {
    //   posts = <PostsView>[];
    //   json['posts'].forEach((v) {
    //     posts.add(new PostsView.fromJson(json));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }


}