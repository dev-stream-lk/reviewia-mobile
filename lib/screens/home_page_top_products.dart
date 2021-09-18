import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/components/selction_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/screens/product_list.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/service_list.dart';
import 'package:reviewia/screens/servicesList.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/loadPost.dart';
import 'package:reviewia/structures/post.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:search_choices/search_choices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageTopProducts extends StatefulWidget {
  const HomePageTopProducts({Key? key}) : super(key: key);

  @override
  _HomePageTopProductsState createState() => _HomePageTopProductsState();
}

class _HomePageTopProductsState extends State<HomePageTopProducts> {
  List<String> locations = ["1", "2", "3", "4", "5"];

  List<Post> _post = <Post>[];
  List<Post> _postDisplay = <Post>[];

  List<PostsView> _postView = <PostsView>[];
  List<PostsView> _postDisplayView = <PostsView>[];
  List<PostsView> _temppostDisplayView = <PostsView>[];

  List<LoadPost> _loadPost = <LoadPost>[];

  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  int _cMax = 0;
  late int totalPages;
  late int currentPage;
  late int _nOfPost = _postView.length;
  late String userName;
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
              )
            ],
          ),
        ),
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

  _searchBarBuild() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) async {
          text = text.toLowerCase();
          if (text.isNotEmpty) {
            var dd = await fetchPostViewSearch(text);
            setState(() {
              _postDisplayView = [];
              var posts = dd.posts.map((e) => PostsView.fromJson(e)).toList();
              _postDisplayView.addAll(posts);
              _isLoading = false;
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

  Future getBuildingData() async {
    var dd = await fetchPostViewStep("0", "3");
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
      var dd = await fetchPostViewStep((currentPage + 1).toString(), "3");
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

  Future getData() async {
    fetchPostView().then((val) {
      setState(() {
        _postView = <PostsView>[];
        _postDisplayView = <PostsView>[];
        _temppostDisplayView = <PostsView>[];
        _cMax = 0;
        _isLoading = false;
        _postView.addAll(val);
        _nOfPost = _postView.length;
        _temppostDisplayView.addAll(_postView.reversed);
        _postDisplayView = _temppostDisplayView.sublist(0, 3);
      });
    });
  }

  Future getUserDate() async {
    var dd = await UserState().getUserName();
    setState(() {
      userName = dd;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // fetchPost().then((value) {
    //   setState(() {
    //     _isLoading = false;
    //     _post.addAll(value);
    //     _postDisplay = _post;
    //   });
    // });
    super.initState();
    // getData();
    getUserDate();
    getBuildingData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Hello');
        // getMoreData();
        getMoreBuildingData();
      }
    });
  }

  getMoreData() {
    // _postDisplayView.add(_temppostDisplayView.elementAt(3));
    print("get more");
    setState(() {
      for (int i = _cMax + 3; i < _cMax + 6; i++) {
        print(_cMax.toString() +
            " no of post" +
            _nOfPost.toString() +
            "i is" +
            i.toString());
        if (i >= _nOfPost) {
          _cMax = _nOfPost;
          return;
        }
        _postDisplayView.add(_temppostDisplayView.elementAt(i));
      }
      _cMax = _cMax + 3;
    });
  }

  String? selectedValueSingleDialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: getBuildingData,
      child: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //     margin: EdgeInsets.symmetric(
                //         vertical: MediaQuery.of(context).size.height * 0.015),
                //     child: CupertinoSearchTextField(
                //       padding: EdgeInsets.all(20),
                //       placeholder: "Search Here",
                //     )),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.020),
                  height: MediaQuery.of(context).size.height * 0.1485,
                  child: ListView(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // GestureDetector(
                      //   child: SelectionCard(title: "Products"),
                      //   onTap: () =>
                      //       {Navigator.pushNamed(context, ProductList.id)},
                      // ),
                      Column(children: [
                        IconButton(
                          iconSize: 30.0,
                          icon: const Icon(Icons.devices_other, color: Kcolor),
                          tooltip: 'Products',
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.pushNamed(context, ProductList.id);
                          },
                        ),
                        Text('Products', style: TextStyle(color: Kcolor))
                      ]),
                      Divider(
                        indent: 30,
                        thickness: 25,
                      ),
                      // GestureDetector(
                      //   child: SelectionCard(title: "Services"),
                      //   onTap: () =>
                      //       {Navigator.pushNamed(context, ServiceList.id)},
                      // ),

                      Column(children: [
                        IconButton(
                          iconSize: 30.0,
                          icon: const FaIcon(FontAwesomeIcons.userCog,
                              color: Kcolor),
                          tooltip: 'Services',
                          onPressed: () {
                            Navigator.pushNamed(context, ServiceList.id);
                          },
                        ),
                        Text('Services', style: TextStyle(color: Kcolor))
                      ]),
                      Divider(
                        indent: 30,
                        thickness: 25,
                      ),
                      // GestureDetector(
                      //   child: SelectionCard(title: "Favourite Posts"),
                      //   onTap: () =>
                      //       {Navigator.pushNamed(context, FavouriteList.id)},
                      // ),
                      Column(children: [
                        IconButton(
                          iconSize: 30.0,
                          icon: const Icon(Icons.favorite, color: Kcolor),
                          tooltip: 'Favorites',
                          onPressed: () {
                            Navigator.pushNamed(context, FavouriteList.id);
                          },
                        ),
                        Text('Favorites', style: TextStyle(color: Kcolor))
                      ]),
                      Divider(
                        indent: 30,
                        thickness: 25,
                      ),
                      // SelectionCard(title: "My posts"),
                      Column(children: [
                        IconButton(
                          iconSize: 30.0,
                          icon: const FaIcon(FontAwesomeIcons.userTag,
                              color: Kcolor),
                          tooltip: 'My Posts',
                          onPressed: () {
                            Navigator.pushNamed(context, MyPost.id);
                          },
                        ),
                        Text('My Posts', style: TextStyle(color: Kcolor))
                      ]),
                      // Divider(
                      //   indent: 30,
                      //   thickness: 25,
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.015),
                  child: Text(
                    'Most Recent Posts',
                    style: KReviewiaMostTitle,
                    textAlign: TextAlign.left,
                  ),
                ),
                // Container(
                //   child: _searchBar(),
                // ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
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

                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
                // ProductCard(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

//
// ListView.builder(
// physics: BouncingScrollPhysics(),
// scrollDirection: Axis.vertical,
// itemCount: locations.length,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// return ProductCard();
// }),
