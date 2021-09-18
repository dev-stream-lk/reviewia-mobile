import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
class FilterResultScreen extends StatefulWidget {
  late String type;
  late String category;
  late String subCategory;
  late String brand;
  late double rating;



  FilterResultScreen({required this.type,required,required this.category,required this.subCategory,required this.brand,required this.rating});

  @override
  _FilterResultScreenState createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Kcolor,
          title: Text(
            "Filter Screen"
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      color: Colors.red,
                      child: Text(widget.subCategory),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
