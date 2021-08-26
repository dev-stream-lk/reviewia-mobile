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
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/reviewStruct.dart';

import 'add_post_page.dart';
import 'home_Page.dart';

class ProductView extends StatefulWidget {
  late PostsView todos;

  ProductView({required this.todos});
  // const ProductView({Key? key,required this.todos}) : super(key: key);
  static String id = "ProductView";

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _currentIndex = 0;
  List<String> test = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  bool _isLoading = false;
  List<Widget> _screenContainer = [
    HomePage(),
    AddPost(),
    ProfilePage(),
  ];
  List<ImgURL> _image = <ImgURL>[];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
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

  @override
  void initState() {
    setState(() {
      _isLoading=true;
    });
    getReviews();
    super.initState();
  }

  _listItemViewProductCards(index) {
    // print("created by " + test[index]);
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.040),
        child: ReviewCards(
          reviewedBy: _reviewCards[index].reviewedBy,
          rate: _reviewCards[index].finalRate,
          detail: _reviewCards[index].description,
        ));
  }

  createAReview(){
    setState(() {
      _isLoading=true;
    });
    Navigator.pop(context);
    getReviews();
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
        actions: [
          IconButton(
            onPressed: () {
              _bootomPage(context);
              ;
            },
            icon: Icon(
              Icons.rate_review_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
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
                    // photoUrl1:widget.todos.imgURL,
                    // widget.todos.imgURL[0],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, right: 10),
                    child:(!_isLoading)?ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _listItemViewProductCards(index);
                        // return _listItem(index);
                      },
                      itemCount: _reviewCards.length,
                    ): CircularProgressIndicator(),
                  ),
                ),
                // ReviewCards(),
                // ReviewCards(),
                // ReviewCards(),
                // ReviewCards(),
              ],
            ),
          ),
        ),
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
          return Container(
            padding: EdgeInsets.all(15),
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
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a Your Review'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height * (12.5 / 692),
                          horizontal:
                              MediaQuery.of(context).size.width * (40 / 360)),
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
                ),
              ],
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
