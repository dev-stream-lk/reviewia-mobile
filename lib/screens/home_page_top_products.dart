import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/components/selction_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/product_list.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/servicesList.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/post.dart';
import 'package:reviewia/services/postView.dart';
import 'package:search_choices/search_choices.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
    //   setState(() {
    //     _isLoading = false;
    //     _post.addAll(value);
    //     _postDisplay = _post;
    //   });
    // });
    fetchPostView().then((val) {
      setState(() {
        _isLoading = false;
        _postView.addAll(val);
        _postDisplayView =_postView;
      });
    });
    super.initState();
  }

  String? selectedValueSingleDialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                  padding: EdgeInsets.all(15),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: SelectionCard(title: "Products"),
                      onTap: () =>
                          {Navigator.pushNamed(context, ProductList.id)},
                    ),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    GestureDetector(
                      child: SelectionCard(title: "Services"),
                      onTap: () =>
                          {Navigator.pushNamed(context, ServicesList.id)},
                    ),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    SelectionCard(title: "Most Viewed"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    SelectionCard(title: "My posts"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
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
              Scrollbar(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (!_isLoading) {
                      return index == 0 ? _searchBar() : _listItemViewProductCards(index - 1);
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
