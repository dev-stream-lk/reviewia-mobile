
class GetSubCategory {
  late int subCategoryId;
  late String subCategoryName;

  GetSubCategory({required this.subCategoryId,required this.subCategoryName});
  GetSubCategory.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['categoryId'];
    subCategoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    return data;
  }
}
