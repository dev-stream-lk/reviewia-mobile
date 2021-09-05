import 'package:reviewia/structures/postView.dart';

class MyPostsStruct {
  late List<dynamic> posts;

  MyPostsStruct({required this.posts});

  MyPostsStruct.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <PostsView>[];
      json['posts'].forEach((v) {
        posts.add(new PostsView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}