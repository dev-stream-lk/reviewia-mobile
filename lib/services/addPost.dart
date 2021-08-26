
class AddPost_category {
  late int categoryId;
  late String categoryName;
  late String type;

  AddPost_category({required this.categoryId, required this.categoryName, required this.type});

  AddPost_category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['type'] = this.type;

    return data;
  }
}
