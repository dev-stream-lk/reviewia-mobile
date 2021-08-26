class CategoryView {
  late int categoryId;
  late String categoryName;

  CategoryView({required this.categoryId, required this.categoryName});

  CategoryView.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    return data;
  }
}