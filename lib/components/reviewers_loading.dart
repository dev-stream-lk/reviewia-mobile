import 'package:flutter/material.dart';
import 'package:reviewia/components/select_reviewer_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../home_data.dart';

class ReviewersLoading extends StatefulWidget {
  late String postId;
  late String state;
  ReviewersLoading({required this.postId});
  late List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  List<ReviewStruct> _uniquereviewCards = <ReviewStruct>[];
  List<String> reviwersEmails = <String>[];
  bool _isloading = true;
  bool _isloadingBtn = true;
  var d = false;
  @override
  _ReviewersLoadingState createState() => _ReviewersLoadingState();
}

class _ReviewersLoadingState extends State<ReviewersLoading> {
  getUniqueSet(List<ReviewStruct> reviewCards) {
    // var s = reviewCards.toSet().toList();
    for (int i = 0; i < reviewCards.length; i++) {
      var flags = 0;
      for (int j = 0; j < widget._uniquereviewCards.length; j++) {
        if (widget._uniquereviewCards[j].email == reviewCards[i].email) {
          print(widget._uniquereviewCards[j].email + "is email ");
          flags = 1;
        }
      }
      if (flags == 0) {
        setState(() {
          widget._uniquereviewCards.add(reviewCards[i]);
        });
      }
    }
    print(widget._uniquereviewCards.toString() + "is unique values");
    // List<ReviewStruct> unique = reviewCards.
  }

  createInstantGroupUser(List<String> listOfReviewers) async {

    print(listOfReviewers);
    var d = await createInstantGroup(widget.postId, listOfReviewers);
    // Navigator.pop(context);
    if (d.toString() == "Instant Group is Created") {
      setState(() {
        widget._isloadingBtn=false;
      });
      Alert(
        context: context,
        type: AlertType.success,
        title: "Instant Group Created",
        desc:
            "Group is created you can ask futher details about product using it ",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
              // Navigator.pop(context);
              // Navigator.of(context).popUntil(ModalRoute.withName(HomePage.id,));
              // Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false,arguments: (userName));
            },
            // onPressed: () =>Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName)),
            width: MediaQuery.of(context).size.width * 100 / 360,
          )
        ],
      ).show();
    } else if (d.toString() == "Already Group is crated") {
      setState(() {
        widget._isloadingBtn=false;
      });
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Already Create a group",
        desc:
            "You  can  only create one group please deactivate previous created groups",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);

              // Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false,arguments: (userName));
            },
            width: MediaQuery.of(context).size.width * 100 / 360,
          )
        ],
      ).show();
    } else {
      return "widget.state";
    }
  }

  @override
  void initState() {
    setState(() {
      widget._isloading = true;
    });
    fetchReviewStruct(widget.postId).then((value) {
      setState(() {
        widget._reviewCards.addAll(value);
        getUniqueSet(widget._reviewCards);
        widget._isloading = false;
        widget._isloadingBtn=false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectReviewer(dynamic reviewStruct) {
      var isSelected = widget.reviwersEmails.contains(reviewStruct.toString());
      setState(() {
        isSelected
            ? widget.reviwersEmails.remove(reviewStruct.toString())
            : widget.reviwersEmails.add(reviewStruct.toString());
        print(reviewStruct.toString());
      });
    }

    return Column(
      children: [
        Container(
          height: widget._isloading
              ? MediaQuery.of(context).size.height * (40 / 765)
              : MediaQuery.of(context).size.height * (180 / 765),
          child: widget._isloading
              ? CircularProgressIndicator()
              : widget._uniquereviewCards.length > 0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SelectReviewerCard(
                            isSelected: widget.reviwersEmails.contains(
                                widget._uniquereviewCards[index].email),
                            reviewerEmail:
                                widget._uniquereviewCards[index].email,
                            reviewerName:
                                widget._uniquereviewCards[index].reviewedBy,
                            onSelectedReviewer: selectReviewer,
                          ),
                        );
                      },
                      itemCount: widget._uniquereviewCards.length,
                    )
                  : Container(
                      child: Text(
                        "Still Not any reviewers on the post",
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                    ),
        ),
        !widget._isloading
            ? Container(
                height: MediaQuery.of(context).size.height * (60 / 765),
                width: MediaQuery.of(context).size.width * (210 / 362),
                child: widget.reviwersEmails.length > 0
                    ? FlatButton(
                        padding: EdgeInsets.all(10),
                        child: widget._isloadingBtn
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Create Instant group \n with " +
                                    widget.reviwersEmails.length.toString() +
                                    " \n reviewers",
                                textAlign: TextAlign.center,
                              ),
                        onPressed: () async {
                          setState(() {
                            widget._isloadingBtn=true;
                          });
                          print(widget.reviwersEmails);
                          createInstantGroupUser(widget.reviwersEmails);
                          // Navigator.pop(context);
                        },
                        color: Kcolor,
                        textColor: Colors.white,
                      )
                    : null,
              )
            : Container(
                height: MediaQuery.of(context).size.height * (2 / 765),
              )
      ],
    );
  }
}
