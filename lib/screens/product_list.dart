import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/post.dart';

class ProductList extends StatefulWidget {
  static String id = 'product_list';
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Post> _post = <Post>[];
  List<Post> _postDisplay = <Post>[];

  bool _isLoading = true;

  _listItem(index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
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
                _postDisplay[index].title,
              ),
              Text(
                _postDisplay[index].body,
              )

            ],
          ),
        ),
      ),
    );
  }

  _searchBar(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text){
          text =text.toLowerCase();
          setState(() {
            _postDisplay = _post.where((element){
              var postTi = element.title.toLowerCase();
              return postTi.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPost().then((value) {
     setState(() {
       _isLoading=false;
       _post.addAll(value);
       _postDisplay = _post;
     });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "All Products",
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
            if(!_isLoading){
              return index == 0 ? _searchBar() : _listItem(index-1);
              // return _listItem(index);
            }else{
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
