import 'package:reviewia/structures/subCate.dart';

class AllCatergory {
  late int categoryId;
  late String categoryName;
  late List<dynamic> subCategoryList;

  AllCatergory({required this.categoryId, required this.categoryName, required this.subCategoryList});

  AllCatergory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryList = json['subCategoryList'];
    // if (json['subCategoryList'] != null) {
    //   subCategoryList =  <subCate>[];
    //   json['subCategoryList'].forEach((v) {
    //     subCategoryList.add(subCate.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}