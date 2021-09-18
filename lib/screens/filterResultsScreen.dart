import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/postView.dart';

class FilterResultScreen extends StatefulWidget {
  late String type;
  late String category;
  late String subCategory;
  late String brand;
  late double rating;

  FilterResultScreen(
      {required this.type,
      required,
      required this.category,
      required this.subCategory,
      required this.brand,
      required this.rating});

  @override
  _FilterResultScreenState createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  List<PostsView> _postView = <PostsView>[];
  List<PostsView> _postDisplayView = <PostsView>[];
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  int _cMax = 0;
  late int totalPages;
  late int currentPage;
  late int _nOfPost = _postView.length;
  late String userName;
  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          if (text.isNotEmpty) {
            setState(() {
              _postDisplayView = _postView.where((element) {
                var postTi = element.title.toLowerCase();
                return postTi.contains(text);
              }).toList();
            });
          }
          if (text.isEmpty) {
            setState(() {
              _postDisplayView = _postView;
            });
          }
        },
      ),
    );
  }

  _listItemViewProductCards(index) {
    // Brand brand = new Brand(id: _postDisplayView[index].brand.id, name: _postDisplayView[index].brand.name);
    // index = _postDisplayView.length - index - 1;
    print("created by " + _postDisplayView[index].createdBy);
    print("LoadPost Size " + _postDisplayView[index].brand.name);
    // print("total items " + _loadPost[0].totalItems.toString());

    return Container(
        child: ProductCard(
      title: _postDisplayView[index].title,
      detail: _postDisplayView[index],
      photoUrl1: _postDisplayView[index].imgURL.isNotEmpty
          ? _postDisplayView[index].imgURL[0].url.toString()
          : "https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
      id: _postDisplayView[index].postId,
      userName: userName,
    ));
  }

  Future getBuildingData() async {
    print("type is:" +
        widget.type +
        "\n" +
        "categoryName is:" +
        widget.category +
        "\n" +
        "brandName is:" +
        widget.brand +
        "\n" +
        "subCategoryName is:" +
        widget.subCategory +
        "\n" +
        "rate is:" +
        widget.rating.toString());
    // var d = await fetchPostViewStep("0", "3");
    var dd = await fetchPostFilter(widget.type, widget.category,
        widget.subCategory, widget.brand, widget.rating, "0", "3");
    setState(() {
      _postView = [];
      _postDisplayView = [];
      var posts = dd.posts.map((e) => PostsView.fromJson(e)).toList();
      totalPages = dd.totalPages;
      currentPage = dd.currentPage;
      _postView.addAll(posts);
      _postDisplayView.addAll(_postView);
      _isLoading = false;
      print(posts);
    });
    // fetchPostViewStep("0","2").then((value){
    //   setState(() {
    //     _loadPost.add(value[0]);
    //   });
    // });
  }

  Future getMoreBuildingData() async {
    print(currentPage.toString() +
        ":is current page" +
        "total pages:" +
        totalPages.toString());
    if (currentPage <= totalPages - 1) {
      var dd = await fetchPostFilter(
          widget.type,
          widget.category,
          widget.subCategory,
          widget.brand,
          widget.rating,
          (currentPage + 1).toString(),
          "3");
      // var dd = await fetchPostViewStep((currentPage + 1).toString(), "3");
      setState(() {
        var posts = dd.posts.map((e) => PostsView.fromJson(e)).toList();
        _postView.addAll(posts);
        _postDisplayView.addAll(posts);
        _isLoading = false;
        currentPage++;
        print(posts);
      });
    }
  }

  Future getUserDate() async {
    var dd = await UserState().getUserName();
    setState(() {
      userName = dd;
    });
  }

  @override
  void initState() {
    getUserDate();
    getBuildingData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Hello');
        // getMoreData();
        getMoreBuildingData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text("Filter Screen"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (!_isLoading) {
                          return index == 0
                              ? _searchBar()
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
                ),
              ],
            ),
          ),
        ));
  }
}
