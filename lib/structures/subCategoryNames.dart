class SubCategoryNames {
  late String subCategoryName;
  late int postCount;
  late int subCategoryId;

  SubCategoryNames({required this.subCategoryName, required this.postCount, required this.subCategoryId});

  SubCategoryNames.fromJson(Map<String, dynamic> json) {
    subCategoryName = json['subCategoryName'];
    postCount = json['postCount'];
    subCategoryId = json['subCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryName'] = this.subCategoryName;
    data['postCount'] = this.postCount;
    data['subCategoryId'] = this.subCategoryId;
    return data;
  }
}