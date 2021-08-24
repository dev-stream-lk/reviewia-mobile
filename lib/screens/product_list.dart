import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/post.dart';
import 'package:reviewia/services/postView.dart';

class ProductList extends StatefulWidget {
  static String id = 'product_list';
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Post> _post = <Post>[];
  List<Post> _postDisplay = <Post>[];

  List<PostsView> _postView = <PostsView>[];
  List<PostsView> _postDisplayView = <PostsView>[];


  bool _isLoading = true;

  _listItem(index) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _listItemView(index) {
    print(_postDisplayView[index].reviews);
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
                _postDisplayView[index].imgURL[0].url.toString(),
              ),
              Text(
                _postDisplayView[index].description,
              )
            ],
          ),
        ),
      ),
    );
  }

  _listItemViewProductCards(index) {
    print("created by " + _postDisplayView[index].createdBy);
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.040),
        child: ProductCard(
          title: _postDisplayView[index].title,
          detail: _postDisplayView[index],
          photoUrl1:_postDisplayView[index].imgURL.isNotEmpty?_postDisplayView[index].imgURL[0].url.toString():"https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
        ));
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
              var postTi = element.title.toLowerCase();
              return postTi.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _searchBarView() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postDisplayView = _postDisplayView.where((element) {
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
    // fetchPost().then((value) {
    //  setState(() {
    //    _isLoading=false;
    //    _post.addAll(value);
    //    _postDisplay = _post;
    //  });
    // });
    fetchPostView().then((value) {
      setState(() {
        _isLoading = false;
        _postView.addAll(value);
        _postDisplayView = _postView.where((element) {
          var postTi = element.type.toLowerCase();
          return postTi.contains("p");
        }).toList();
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
          if (!_isLoading) {
            return index == 0
                ? _searchBarView()
                : _listItemViewProductCards(index - 1);
            // return _listItem(index);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        itemCount: _postDisplayView.length + 1,
      ),
    );
  }
}
