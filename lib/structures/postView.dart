
class PostsView {
  late int postId;
  late double rate;
  late int viewCount;
  late String title;
  late List<ImgURL> imgURL;
  late String description;
  late String createdAt;
  late String type;
  late String createdBy;
  late bool blocked;
  late String subCategory;
  late String brand;
  late List<dynamic> reviews;

  PostsView(
      {required this.postId,
        required this.rate,
        required this.viewCount,
        required this.title,
        required this.imgURL,
        required this.description,
        required this.createdAt,
        required this.type,
        required this.createdBy,
        required this.blocked,
        required this.subCategory,
        required this.brand,
        required this.reviews});

  PostsView.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    rate = json['rate'];
    viewCount = json['viewCount'];
    title = json['title'];
    if (json['imgURL'] != null) {
      imgURL = <ImgURL>[];
      json['imgURL'].forEach((v) {
        imgURL.add(new ImgURL.fromJson(v));
      });
    }
    description = json['description'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    type = json['type'];
    blocked = json['blocked'];
    subCategory = json['subCategory'];
    brand = json['brand'];
    // reviews = json['reviews'];

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
    // data['imgURL'] = this.imgURL;
    data['imgURL'] = this.imgURL.map((v) => v.toJson()).toList();
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['blocked'] = this.blocked;
    data['subCategory'] = this.subCategory;
    // data['reviews']=this.reviews;
    // data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    return data;
  }
}
class ImgURL {
  late int id;
  late String url;

  ImgURL({required this.id, required this.url});

  ImgURL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}


