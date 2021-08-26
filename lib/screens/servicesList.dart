import 'dart:convert';

import 'package:find_dropdown/rxdart/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/structures/allCategory.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/subCate.dart';
class ServicesList extends StatefulWidget {
  static String id = 'services_list';


  @override
  _ServicesListState createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  List<AllCatergory> _post = <AllCatergory>[];
  List<AllCatergory> _postDisplay = <AllCatergory>[];
  List<subCate> _postSubDisplay = <subCate>[];

  subCateFind(List<dynamic> subCategoryList ){
    var posts = subCategoryList.map((e) => subCate.fromJson(e)).toList();
    _postSubDisplay.addAll(posts);
    print(_postSubDisplay[1].posts[0]);
    return posts;
  }

  bool _isLoading = true;

  _listItem(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: (){
          subCateFind(_postDisplay[index].subCategoryList);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index.toString(),
                ),
                Text(
                  _postDisplay[index].subCategoryList.toString(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postDisplay = _post.where((element) {
              var postTi = element.categoryName.toLowerCase();
              return postTi.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    // fetchPost().then((value) {
    //  setState(() {
    //    _isLoading=false;
    //    _post.addAll(value);
    //    _postDisplay = _post;
    //  });
    // });
    fetchAllCategoryView().then((value) {
      setState(() {
        _isLoading = false;
        _post.addAll(value);
        _postDisplay = _post;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "All Categories",
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (!_isLoading) {
            return index == 0
                ? _searchBar()
                : _listItem(index - 1);
            // return _listItem(index);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        itemCount: _postDisplay.length + 1,
      ),
    );
  }
}
