import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/components/product_view_card.dart';
import 'package:reviewia/components/review_cards.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/search_page.dart';
import 'package:reviewia/screens/testPage.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home_Page.dart';

class ProductView extends StatefulWidget {
  late PostsView todos;
  late int reviewId;

  ProductView({required this.todos ,required this.reviewId});
  
  // const ProductView({Key? key,required this.todos}) : super(key: key);
  static String id = "ProductView";

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _currentIndex = 0;
  late double rate;
  late String reviewDetail="";
  List<String> test = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  bool _isLoading = false;
  String? displayName;
  String? token;
  late String userName;
  List<Widget> _screenContainer = [
    HomePage(),
    TestAddPost(),
    ProfilePage(),
  ];
  List<ImgURL> _image = <ImgURL>[];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  loadPost()async{
    var data = await fetchPostViewById(widget.todos.postId.toString());
    setState(() {
        widget.todos.rate = data.rate;
    });
  }

  getReviews() {
    fetchReviewStruct(widget.todos.postId.toString()).then((value) {
      setState(() {
        _reviewCards = <ReviewStruct>[];
        _isLoading = false;
        _reviewCards.addAll(value);
      });
    });
  }
  Future getRefreshData() async {
    loadPost();
    getReviews();
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getReviews();
    super.initState();
  }

  _listItemViewProductCards(index,BuildContext context) {
    index = _reviewCards.length - index - 1;
    print("created by " + widget.reviewId.toString());
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.040),
        child: ReviewCards(
          reviewedBy: _reviewCards[index].reviewedBy,
          rate: _reviewCards[index].finalRate,
          detail: _reviewCards[index].description,
          reviewId: _reviewCards[index].reviewId,
          reviewCardAllDetails:_reviewCards[index],
          isColored:(_reviewCards[index].reviewId==widget.reviewId)?'yes':'no',
          context: context
        ));
  }

  Future getDisplayName() async {
    var dp = await UserState().getDisplayName();
    var tk = await UserState().getToken();
    var uN = await UserState().getUserName();
    setState(() {
      print(dp.toString());
      displayName = dp.toString();
      token = tk.toString();
      userName = uN.toString();
    });
    // print(displayName);
  }

  createAReview() async {
    setState(() {
      _isLoading = true;
    });
    await getDisplayName();
    // print("Name is " + displayName.toString());
    // print("token is " + token.toString());
    // print("userName is " + userName.toString());
    var n = await postReview(userName.toString(), token.toString(),
        displayName.toString(), widget.todos.postId, rate, reviewDetail);
    print("My response : "+ n.statusCode.toString());

    var response = int.parse(n.statusCode.toString());
    assert(response is int);

    if(response == 201){
      Navigator.pop(context);
      loadPost();
      getReviews();
    }
    else if(response == 412){
      return Alert(
        context: context,
        type: AlertType.error,
        title: "Review And Rate Missed Match Error",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()  {
              Navigator.pop(context);
              },
            // onPressed: () =>Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName)),
            width: MediaQuery.of(context).size.width * 100 / 360,
          ),
        ],
      ).show();
    }
    else{
      return Alert(
        context: context,
        type: AlertType.error,
        title: "Api Error",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()  {
              Navigator.pop(context);
            },
            // onPressed: () =>Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName)),
            width: MediaQuery.of(context).size.width * 100 / 360,
          ),
        ],
      ).show();
    }

  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          // setState(() {
          // _postDisplay = _post.where((element) {
          //   var postTi = element.title.toLowerCase();
          //   return postTi.contains(text);
          // }).toList();
          // });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Image url is");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text("Product View"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _bootomPage(context);
        //       ;
        //     },
        //     icon: Icon(
        //       Icons.rate_review_rounded,
        //     ),
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: getRefreshData,
        child: SafeArea(
          child: Scrollbar(
            isAlwaysShown: true,
            thickness: 10,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: ProductViewCard(
                      title: widget.todos.title.toString(),
                      description: widget.todos.description,
                      rating: widget.todos.rate,
                      photoUrl1: widget.todos.imgURL.isNotEmpty
                          ? widget.todos.imgURL[0].url.toString()
                          : "https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
                      createdBy: widget.todos.createdBy,
                      todos: widget.todos,
                      // photoUrl1:widget.todos.imgURL,
                      // widget.todos.imgURL[0],
                    ),
                  ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, right: 10),
                      child: (!_isLoading)
                          ? ListView.builder(
                              shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return _listItemViewProductCards(index,context);
                                // return _listItem(index);
                              },
                              itemCount: _reviewCards.length,
                            )
                          : CircularProgressIndicator(),
                    ),
                  // SingleChildScrollView(
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 10, right: 10),
                  //     child: (!_isLoading)
                  //         ? ListView.builder(
                  //             shrinkWrap: true,
                  //             scrollDirection: Axis.vertical,
                  //             itemBuilder: (context, index) {
                  //               return _listItemViewProductCards(index);
                  //               // return _listItem(index);
                  //             },
                  //             itemCount: _reviewCards.length,
                  //           )
                  //         : CircularProgressIndicator(),
                  //   ),
                  // ),
                  // ReviewCards(),
                  // ReviewCards(),
                  // ReviewCards(),
                  // ReviewCards(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Review",
        onPressed: () {
          _bootomPage(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Kcolor,
      ),
    );
  }
  void _bootomPage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                  MediaQuery.of(context).size.width * 25 / 360)),
        ),
        builder: (BuildContext bc) {
          return Scrollbar(
            isAlwaysShown: false,
            thickness: 5,
            radius: Radius.circular(15),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.72,
                padding: EdgeInsets.only(left: 15, right: 15),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        // color:Colors.red,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Write a Review",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                    maxLines: 4,
                                    onChanged: (val) {
                                      setState(() {
                                        reviewDetail = val.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter a Your Review" ),
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Rate it: ",
                                  style: KPostReviewCard,
                                ),
                                RatingBar.builder(
                                  wrapAlignment: WrapAlignment.spaceBetween,
                                  initialRating: 3.0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 35,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Kcolor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      rate = rating;
                                      print(rate);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      (12.5 / 692),
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          (40 / 360)),
                              color: Kcolor,
                              onPressed: () {
                                createAReview();

                              },
                              child: Text(
                                'Add a review',
                                style: KbuttonSignin,
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

// class ReviewCards extends StatelessWidget {
//   const ReviewCards({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3,
//       margin:
//           EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
//       decoration: KBoxDeco,
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: CircleAvatar(
//                     backgroundColor: Color(0xFFC494C4),
//                     backgroundImage: AssetImage('images/pep.jpg'),
//                     radius: MediaQuery.of(context).size.width *
//                         22.58 /
//                         360,
//                   ),
//                 ),
//                 Expanded(
//                     flex: 3,
//                     child: Text("Chamari Wikrmawardna",
//                         style: KPostCard)),
//                 Expanded(flex: 1, child: Icon(Icons.settings))
//               ],
//             ),
//           ),
//           Expanded(
//               flex: 2,
//               child: Container(
//
//                 padding: EdgeInsets.all(MediaQuery.of(context).size.width*10/360),
//                 child: Text("This is a very good product. It is very usefull",style: KPostReviewCard),
//                 // color: Colors.red,
//               )),
//           Expanded(
//               flex: 1,
//               child:Container(
//                 padding: EdgeInsets.all(MediaQuery.of(context).size.width*10/360),
//                 child: Row(
//                   children: [
//                     Expanded(flex:1, child: Text("3.6",style:TextStyle(fontSize: 16,fontWeight:FontWeight.w600),)),
//
//                     RatingBar.builder(
//                       initialRating:3.6,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemSize: 20,
//                       itemPadding:
//                       EdgeInsets.symmetric(horizontal: 4.0),
//                       itemBuilder: (context, _) => Icon(
//                         Icons.star,
//                         color: Kcolor,
//                       ),
//                       onRatingUpdate: (rating) {
//
//                       },
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*60/360),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               child: Expanded(
//                                 flex:2,
//                                 child: Container(
//                                   child: Icon(
//                                     Icons.thumb_up,
//                                     color: Kcolor,
//                                   ),
//                                   // color: Colors.red,
//                                 ),
//                               ),
//                               onTap: (){
//                                 print('liked it');
//                               },
//                             ),
//                             Expanded(flex:1,child: SizedBox()),
//                             Expanded(
//                               flex:2,
//                               child: Container(
//                                 child: Icon(
//                                   Icons.thumb_down,
//                                 ),
//                                 // color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
