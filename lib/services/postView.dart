
class PostsView {
  late int postId;
  late double rate;
  late int viewCount;
  late String title;
  late String imgURL;
  late String description;
  late String createdAt;
  late String createdBy;
  late bool blocked;
  late String subCategory;
  late List<dynamic> reviews;

  PostsView(
      {required this.postId,
        required this.rate,
        required this.viewCount,
        required this.title,
        required this.imgURL,
        required this.description,
        required this.createdAt,
        required this.createdBy,
        required this.blocked,
        required this.subCategory,
        required this.reviews});

  PostsView.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    rate = json['rate'];
    viewCount = json['viewCount'];
    title = json['title'];
    imgURL = json['imgURL'];
    description = json['description'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    blocked = json['blocked'];
    subCategory = json['subCategory'];
    reviews = json['reviews'];
    // if (json['reviews'] != null) {
    //   reviews = new List<>();
    //   json['reviews'].forEach((v) {
    //     reviews.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['rate'] = this.rate;
    data['viewCount'] = this.viewCount;
    data['title'] = this.title;
    data['imgURL'] = this.imgURL;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['blocked'] = this.blocked;
    data['subCategory'] = this.subCategory;
    data['reviews']=this.reviews;
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}


// class PostsView {
//   int postId;
//   int rate;
//   int viewCount;
//   String title;
//   String imgURL;
//   String description;
//   String createdAt;
//   String createdBy;
//   bool blocked;
//   String subCategory;
//   List<Null> reviews;
//
//   PostsView(
//       {this.postId,
//         this.rate,
//         this.viewCount,
//         this.title,
//         this.imgURL,
//         this.description,
//         this.createdAt,
//         this.createdBy,
//         this.blocked,
//         this.subCategory,
//         this.reviews});
//
//   PostsView.fromJson(Map<String, dynamic> json) {
//     postId = json['postId'];
//     rate = json['rate'];
//     viewCount = json['viewCount'];
//     title = json['title'];
//     imgURL = json['imgURL'];
//     description = json['description'];
//     createdAt = json['createdAt'];
//     createdBy = json['createdBy'];
//     blocked = json['blocked'];
//     subCategory = json['subCategory'];
//     if (json['reviews'] != null) {
//       reviews = new List<Null>();
//       json['reviews'].forEach((v) {
//         reviews.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['postId'] = this.postId;
//     data['rate'] = this.rate;
//     data['viewCount'] = this.viewCount;
//     data['title'] = this.title;
//     data['imgURL'] = this.imgURL;
//     data['description'] = this.description;
//     data['createdAt'] = this.createdAt;
//     data['createdBy'] = this.createdBy;
//     data['blocked'] = this.blocked;
//     data['subCategory'] = this.subCategory;
//     if (this.reviews != null) {
//       data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

