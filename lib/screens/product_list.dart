import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/subCategoryList.dart';
import 'package:reviewia/structures/categoryView.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/post.dart';
import 'package:reviewia/structures/postView.dart';

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

  List<CategoryView> _catView = <CategoryView>[];
  List<CategoryView> _catDisplayView = <CategoryView>[];


  bool _isLoading = true;

  bool _isLoadingCat = true;

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

  _listCategoryView(index){
    return topBarButon(t: _catDisplayView[index].categoryName,id:_catDisplayView[index].categoryId.toString());
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
            _postDisplayView = _postView.where((element) {
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
    fetchCategoryView().then((val) {
        setState(() {
        _isLoadingCat = false;
        _catView.addAll(val);
        _catDisplayView =_catView;
        });
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child:(!_isLoadingCat)?ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _catDisplayView.length,
              itemBuilder: (BuildContext context, int index){
                return _listCategoryView(index);
              },
            ):Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(
            flex: 12,
            // height: MediaQuery.of(context).size.height*0.8,
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}

class topBarButon extends StatefulWidget {
  String t;
  String id;
  topBarButon({required this.t,required this.id});


  @override
  _topBarButonState createState() => _topBarButonState();
}

class _topBarButonState extends State<topBarButon> {
  late IconData k;
  setIcon(String l){
    print(widget.id);
    if(l.toLowerCase()=="clothes"){
      k =FontAwesomeIcons.tshirt;
    }else if(l.toLowerCase()=="electronics"){
      k =FontAwesomeIcons.mobile;
    }else if(l.toLowerCase()=="education"){
      k= FontAwesomeIcons.book;
    }else{
      k = FontAwesomeIcons.circle;
    }
  }

  @override
  void initState() {
    setIcon(widget.t);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCatergoryList(catId: widget.id,catName:widget.t),
          ),
        );
      },
      child: Container(
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(30),
          //     )
          // ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
                child: Container(child: Icon(k,color:Kcolor,))

            ),
            Expanded(
              flex: 2,
              child: Container(
                  child: Text(widget.t)),
            )
          ],
        )
      ),
    );
  }
}
