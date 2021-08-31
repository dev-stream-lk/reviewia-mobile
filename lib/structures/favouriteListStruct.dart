import 'package:reviewia/structures/postView.dart';

class FavouriteListStruct {
  late int id;
  late String createdBy;
  late List<dynamic> posts;

  FavouriteListStruct({required this.id, required this.createdBy, required this.posts});

  FavouriteListStruct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    if (json['posts'] != null) {
      posts = <PostsView>[];
      json['posts'].forEach((v) {
        posts.add(new PostsView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}