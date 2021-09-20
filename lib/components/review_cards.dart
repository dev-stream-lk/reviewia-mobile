import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReviewCards extends StatefulWidget {
  late int reviewId;
  late String reviewedBy;
  late String detail;
  late double rate;
  late ReviewStruct reviewCardAllDetails;
  late String isColored;
  late BuildContext context;
  ReviewCards(
      {required this.reviewId,
      required this.reviewedBy,
      required this.detail,
      required this.rate,
      required this.reviewCardAllDetails,required this.isColored, required this.context});

  @override
  _ReviewCardsState createState() => _ReviewCardsState();
}

class _ReviewCardsState extends State<ReviewCards> {
  late String status = "still not assign";
  String email="";
  final inputController = TextEditingController();
  //late double newRate;
  bool _isLoading = false;

  putReaction(String state, bool removeStatus) async {
    bool s = state == "like" ? true : false;
    var dd = await setReaction(widget.reviewId, s, removeStatus);
    print(dd.toString());
  }

  userReaction() async {
    var userName = await UserState().getUserName();

    setState(() {
      inputController.text = widget.detail;
          email = userName;
          //newRate = widget.rate;
    });
    for (int i = 0; i < widget.reviewCardAllDetails.likedList.length; i++) {
      if (userName.toString() ==
          widget.reviewCardAllDetails.likedList[i].email.toString()) {
        setState(() {
          status = "like";
        });
        return;
      }
    }
    for (int i = 0; i < widget.reviewCardAllDetails.dislikedList.length; i++) {
      if (userName.toString() ==
          widget.reviewCardAllDetails.dislikedList[i].email.toString()) {
        setState(() {
          status = "dislike";
        });
        return;
      }
    }
  }

  @override
  void initState() {
    userReaction();
    setState(() {

    });
    super.initState();
  }

  UpdateReview() async {
    var dp = await UserState().getDisplayName();
    var tk = await UserState().getToken();
    var uN = await UserState().getUserName();
    setState(() {
      _isLoading = true;
    });
    //await getDisplayName();
    // print("Name is " + displayName.toString());
    // print("token is " + token.toString());
    // print("userName is " + userName.toString());
    var n = await UpdateReviewById(widget.reviewId.toString(),uN.toString(), tk.toString(),
        dp.toString(), widget.reviewCardAllDetails.postId, widget.rate, inputController.text);
    print("My response : "+ n.statusCode.toString());

    var response = int.parse(n.statusCode.toString());
    assert(response is int);

    if(response == 201){
      Navigator.pop(context);
      // loadPost();
      // getReviews();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.275,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      // padding:EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        // color: Colors.cyan,
        color: widget.isColored=='yes'?KSelectedFeedback:Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          KBoxShadow
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFC494C4),
                    backgroundImage: AssetImage('images/rev_img.png'),
                    radius: MediaQuery.of(context).size.width * 18.58 / 360,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.reviewedBy, style: KPostCard),
                        Text(
                          "Created Date: " +
                              widget.reviewCardAllDetails.createdAt
                                  .substring(0, 10),
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: KDetailColor.withOpacity(KOpacityOnDetail),
                          ),
                        ),
                        Text(int.parse(widget.reviewCardAllDetails.createdAt
                                    .substring(11, 13)) >
                                12
                            ? widget.reviewCardAllDetails.createdAt
                                    .substring(11, 16) +
                                "pm"
                            : widget.reviewCardAllDetails.createdAt
                                    .substring(11, 16) +
                                "am",style:  TextStyle(
                          fontWeight: FontWeight.w100,
                          color: KDetailColor.withOpacity(KOpacityOnDetail),
                        ),)
                      ],
                    ),
                  ),
                ),
                email != ""?Expanded(
                    flex: 1,
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (item) => {
                        if(item == 2){
                          _bootomPage( widget.context)
                        }
                      },
                      itemBuilder: email == widget.reviewCardAllDetails.email?(context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Report",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ]:(context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Report",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )): CircularProgressIndicator(),
              ],
            ),
          ),
          Container(
            child: Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 10 / 360),
                  child: Text(
                    widget.detail,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // color: Colors.red,
                )),
          ),
          Container(
            child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 10 / 360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        widget.rate.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        width: 12,
                      ),
                      RatingBar.builder(
                        initialRating: widget.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Kcolor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Container(
                        width: 85,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 20 / 360),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  if (status == "dislike" ||
                                      status == "still not assign") {
                                    setState(() {
                                      if (status == "dislike") {
                                        setState(() {
                                          widget.reviewCardAllDetails
                                              .dislikeCount--;
                                        });
                                      }
                                      status = "like";
                                      widget.reviewCardAllDetails.likeCount++;
                                    });
                                    putReaction(status, false);
                                  } else if (status == "like") {
                                    setState(() {
                                      status = "still not assign";
                                      widget.reviewCardAllDetails.likeCount--;
                                    });
                                    putReaction("like", true);
                                  }
                                },
                                child: Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: status == "still not assign"
                                          ? Colors.black
                                          : status == "like"
                                              ? Kcolor
                                              : Colors.black,
                                    ),
                                    Text("(" +
                                        widget.reviewCardAllDetails.likeCount
                                            .toString() +
                                        ")"),
                                  ],
                                )
// color: Colors.red,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  if (status == "like" ||
                                      status == "still not assign") {
                                    setState(() {
                                      if (status == 'like') {
                                        widget.reviewCardAllDetails.likeCount--;
                                      }
                                      status = "dislike";
                                      widget
                                          .reviewCardAllDetails.dislikeCount++;
                                    });
                                    putReaction(status, false);
                                  } else if (status == "dislike") {
                                    setState(() {
                                      status = "still not assign";
                                      widget
                                          .reviewCardAllDetails.dislikeCount--;
                                    });
                                    putReaction("dislike", true);
                                  }
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_down,
                                        color: status == "still not assign"
                                            ? Colors.black
                                            : status == "dislike"
                                                ? Kcolor
                                                : Colors.black,
                                      ),
                                      Text("(" +
                                          widget
                                              .reviewCardAllDetails.dislikeCount
                                              .toString() +
                                          ")"),
                                    ],
                                  ),
// color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
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
                                controller: inputController,
                                maxLines: 4,
                                onChanged: (val) {
                                  setState(() {
                                    //reviewDetail = val.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a Your Review'),
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
                                  initialRating: widget.rate,
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
                                       widget.rate = rating;
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
                                UpdateReview();
                                print(inputController.text);
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
