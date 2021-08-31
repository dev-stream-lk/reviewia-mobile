import 'package:reviewia/structures/postView.dart';

class LoadPost {
  late int totalItems;
  late int totalPages;
  late int currentPage;
  late List<dynamic> posts;

  LoadPost({required this.totalItems, required this.totalPages, required this.currentPage, required this.posts});

  LoadPost.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    if (json['posts'] != null) {
      posts =<PostsView>[];
      json['posts'].forEach((v) {
        posts.add(new PostsView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

