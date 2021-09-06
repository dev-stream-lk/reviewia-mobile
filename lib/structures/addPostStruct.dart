import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddPost {
  late String title;
  late String type;
  late String Category;
  late String SubCategory;
  late String subId;
  late String brand;
  late String description;
  late List<Asset> images = [];


  AddPost({required this.title, required this.type, required this.Category, required this.SubCategory, required this.subId,
    required this.brand, required this.description, required this.images});

}