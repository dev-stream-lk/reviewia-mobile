import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reviewia/components/select_reviewer_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedGroup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;


import '../home_data.dart';

class ReviewersLoadingChat extends StatefulWidget {
  late String postId;
  late String groupId;
  late List<Users> members = <Users>[];
  ReviewersLoadingChat({required this.postId, required this.members, required this.groupId});
  late List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  List<ReviewStruct> uniqueSet = <ReviewStruct>[];
  List<String> selectedEmails = <String>[];
  // late List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  // List<ReviewStruct> _uniquereviewCards = <ReviewStruct>[];
  // List<String> reviwersEmails = <String>[];
  bool _isloading = true;
  bool _isloadingBtn = true;
  var d = false;
  @override
  _ReviewersLoadingChatState createState() => _ReviewersLoadingChatState();
}

class _ReviewersLoadingChatState extends State<ReviewersLoadingChat> {
  createUniqueList(List<ReviewStruct> reviewCards) {
    // var s = reviewCards.toSet().toList();
    for (int i = 0; i < widget._reviewCards.length; i++) {
      var flags = 0;
      for (int j = 0; j < widget.uniqueSet.length; j++) {
        if (widget.uniqueSet[j].email == widget._reviewCards[i].email) {
          flags = 1;
        }
      }
      if (flags == 0) {

        bool flag2 = true;
        for(var item in widget.members){
          if(widget._reviewCards[i].email == item.email){
            flag2 = false;
          }
        }
        if(flag2){
          widget.uniqueSet.add(widget._reviewCards[i]);
        }
      }
    }
  }

  Future<void> addNewMembers(List<String> listOfReviewers) async {
    String userName = await UserState().getUserName();
    print(listOfReviewers);
   // var d = await createInstantGroup(widget.postId, listOfReviewers);
    // Navigator.pop(context);

    String token = (await UserState().getToken());
    String url = KBaseUrl + 'api/user/group/add?id='+widget.groupId;
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "emails": listOfReviewers
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      //Alert..
    setState(() {
    widget._isloadingBtn=false;
    });
    Alert(
    context: context,
    type: AlertType.success,
    title: "Reviewers Added",
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

    }
    else {
      print(response.statusCode);
      print("not sent");
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
        createUniqueList(widget._reviewCards);
        widget._isloading = false;
        widget._isloadingBtn=false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectReviewer(dynamic reviewStruct) {
      var isSelected = widget.selectedEmails.contains(reviewStruct.toString());
      setState(() {
        isSelected
            ? widget.selectedEmails.remove(reviewStruct.toString())
            : widget.selectedEmails.add(reviewStruct.toString());
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
              : widget.uniqueSet.length > 0
              ? ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Center(
                child: SelectReviewerCard(
                  isSelected: widget.selectedEmails.contains(
                      widget.uniqueSet[index].email),
                  reviewerEmail:
                  widget.uniqueSet[index].email,
                  reviewerName:
                  widget.uniqueSet[index].reviewedBy,
                  onSelectedReviewer: selectReviewer,
                ),
              );
            },
            itemCount: widget.uniqueSet.length,
          )
              : Container(
            child: Text(
              "No other available reviewers ",
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        ),
        !widget._isloading
            ? Container(
          height: MediaQuery.of(context).size.height * (60 / 765),
          width: MediaQuery.of(context).size.width * (210 / 362),
          child: widget.selectedEmails.length > 0
              ? FlatButton(
            padding: EdgeInsets.all(10),
            child: widget._isloadingBtn
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
                : Text(
              "Add Instant group \n with " +
                  widget.selectedEmails.length.toString() +
                  " \n reviewers",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              setState(() {
                widget._isloadingBtn=true;
              });
              print(widget.selectedEmails);
              addNewMembers(widget.selectedEmails);
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
