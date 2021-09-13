import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/reviewStruct.dart';

class ReviewCards extends StatefulWidget {
  late int reviewId;
  late String reviewedBy;
  late String detail;
  late double rate;
  late ReviewStruct reviewCardAllDetails;
  ReviewCards(
      {required this.reviewId,
      required this.reviewedBy,
      required this.detail,
      required this.rate,
      required this.reviewCardAllDetails});

  @override
  _ReviewCardsState createState() => _ReviewCardsState();
}

class _ReviewCardsState extends State<ReviewCards> {
  late String status = "still not assign";

  putReaction(String state, bool removeStatus) async {
    bool s = state == "like" ? true : false;
    var dd = await setReaction(widget.reviewId, s, removeStatus);
    print(dd.toString());
  }

  userReaction() async {
    var userName = await UserState().getUserName();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.275,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      // padding:EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: KBoxDeco,
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
                Expanded(
                    flex: 1,
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (item) => {print(item)},
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Report",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ))
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
}
