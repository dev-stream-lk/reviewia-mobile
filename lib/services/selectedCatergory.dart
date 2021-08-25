// class SelectedCatergory {
//   late int categoryId;
//   late String categoryName;
//   // late List<dynamic> subCategoryList;
//
//   SelectedCatergory({required this.categoryId, required this.categoryName});
//
//   SelectedCatergory.fromJson(Map<String, dynamic> json) {
//     categoryId = json['categoryId'];
//     categoryName = json['categoryName'];
//     // subCategoryList = json['subCategoryList'];
//     // if (json['subCategoryList'] != null) {
//     //   subCategoryList = <SubCategoryList>[];
//     //   json['subCategoryList'].forEach((v) {
//     //     subCategoryList.add(new SubCategoryList.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['categoryId'] = this.categoryId;
//     data['categoryName'] = this.categoryName;
//     // data['subCategoryList'] = this.subCategoryList;
//     // if (this.subCategoryList != null) {
//     //   data['subCategoryList'] =
//     //       this.subCategoryList.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
// //
// // class SubCategoryList {
// //   late int subCategoryId;
// //   late String subCategoryName;
// //   late List<Posts> posts;
// //   late List<BrandList> brandList;
// //
// //   SubCategoryList(
// //       {required this.subCategoryId, required this.subCategoryName, required this.posts, required this.brandList});
// //
// //   SubCategoryList.fromJson(Map<String, dynamic> json) {
// //     subCategoryId = json['subCategoryId'];
// //     subCategoryName = json['subCategoryName'];
// //     if (json['posts'] != null) {
// //       posts = <Posts>[];
// //       json['posts'].forEach((v) {
// //         posts.add(new Posts.fromJson(v));
// //       });
// //     }
// //     if (json['brandList'] != null) {
// //       brandList = <BrandList>[];
// //       json['brandList'].forEach((v) {
// //         brandList.add(new BrandList.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['subCategoryId'] = this.subCategoryId;
// //     data['subCategoryName'] = this.subCategoryName;
// //     if (this.posts != null) {
// //       data['posts'] = this.posts.map((v) => v.toJson()).toList();
// //     }
// //     if (this.brandList != null) {
// //       data['brandList'] = this.brandList.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Posts {
// //   late int postId;
// //   late  double rate;
// //   late int viewCount;
// //   late String title;
// //   late List<ImgURLL> imgURL;
// //   late String description;
// //   late String createdAt;
// //   late String type;
// //   late int reviewCount;
// //   late String createdBy;
// //   late bool blocked;
// //   late String subCategory;
// //   late String brand;
// //   late List<dynamic> reviews;
// //
// //   Posts(
// //       {required this.postId,
// //         required this.rate,
// //         required this.viewCount,
// //         required this.title,
// //         required this.imgURL,
// //         required this.description,
// //         required this.createdAt,
// //         required this.type,
// //         required this.reviewCount,
// //         required this.createdBy,
// //         required this.blocked,
// //         required this.subCategory,
// //         required this.brand,
// //         required this.reviews});
// //
// //   Posts.fromJson(Map<String, dynamic> json) {
// //     postId = json['postId'];
// //     rate = json['rate'];
// //     viewCount = json['viewCount'];
// //     title = json['title'];
// //     if (json['imgURL'] != null) {
// //       imgURL = <ImgURLL>[];
// //       json['imgURL'].forEach((v) {
// //         imgURL.add(new ImgURLL.fromJson(v));
// //       });
// //     }
// //     description = json['description'];
// //     createdAt = json['createdAt'];
// //     type = json['type'];
// //     reviewCount = json['reviewCount'];
// //     createdBy = json['createdBy'];
// //     blocked = json['blocked'];
// //     subCategory = json['subCategory'];
// //     brand = json['brand'];
// //     reviews = json['reviews'];
// //     // if (json['reviews'] != null) {
// //     //   reviews = <dynamic>[];
// //     //   json['reviews'].forEach((v) {
// //     //     reviews.add(new Re.fromJson(v));
// //     //   });
// //     // }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['postId'] = this.postId;
// //     data['rate'] = this.rate;
// //     data['viewCount'] = this.viewCount;
// //     data['title'] = this.title;
// //     if (this.imgURL != null) {
// //       data['imgURL'] = this.imgURL.map((v) => v.toJson()).toList();
// //     }
// //     data['description'] = this.description;
// //     data['createdAt'] = this.createdAt;
// //     data['type'] = this.type;
// //     data['reviewCount'] = this.reviewCount;
// //     data['createdBy'] = this.createdBy;
// //     data['blocked'] = this.blocked;
// //     data['subCategory'] = this.subCategory;
// //     data['brand'] = this.brand;
// //     data['reviews'] = this.reviews;
// //     // if (this.reviews != null) {
// //     //   data['reviews'] = this.reviews.map((v) => v!.toJson()).toList();
// //     // }
// //     return data;
// //   }
// // }
// //
// // class ImgURLL {
// //   late int id;
// //   late String url;
// //
// //   ImgURLL({required this.id, required this.url});
// //
// //   ImgURLL.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     url = json['url'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['url'] = this.url;
// //     return data;
// //   }
// // }
// //
// // class BrandList {
// //   late int id;
// //   late String name;
// //
// //   BrandList({required this.id,required this.name});
// //
// //   BrandList.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['name'] = this.name;
// //     return data;
// //   }
// // }

class SelectedCatergory {
  late int categoryId;
  late String categoryName;
  late String type;
  late List<dynamic> subCategoryList;

  SelectedCatergory(
      {required this.categoryId, required this.categoryName, required this.type, required this.subCategoryList});

  SelectedCatergory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    type = json['type'];
    if (json['subCategoryList'] != null) {
      subCategoryList = <SubCategoryList>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList.add(new SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['type'] = this.type;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryList {
  late int subCategoryId;
  late String subCategoryName;

  SubCategoryList(
      {required this.subCategoryId, required this.subCategoryName});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    return data;
  }
}
