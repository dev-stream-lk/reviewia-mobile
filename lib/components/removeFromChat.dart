import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reviewia/components/select_reviewer_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedGroup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;


import '../home_data.dart';

class RemoveFromChat extends StatefulWidget {
  late SlectedGroup groupData;
  RemoveFromChat({required this.groupData});
  List<String> selectedEmails = <String>[];
  bool _isloading = true;
  bool _isloadingBtn = true;
  @override
  _RemoveFromChatState createState() => _RemoveFromChatState();
}

class _RemoveFromChatState extends State<RemoveFromChat> {
  late List<Users> memberList = <Users>[];

  _loadMembers() async {
    var members = await widget.groupData.users.map((e) => Users.fromJson(e)).toList();
    String userName = await UserState().getUserName();
    setState(() {
      memberList = members.where((element) {
        var userEmail = '${element.email}';
        return userEmail!= userName;
      }).toList();
      widget._isloading = false;
      widget._isloadingBtn=false;
    });

  }

  Future<void> removeMembers(List<String> listOfReviewers) async {
    String userName = await UserState().getUserName();
    print(listOfReviewers);
    // var d = await createInstantGroup(widget.postId, listOfReviewers);
    // Navigator.pop(context);

    String token = (await UserState().getToken());
    String url = KBaseUrl + 'api/user/group/remove?id='+widget.groupData.id.toString();

      Alert(
        context: context,
        type: AlertType.warning,
        title: "Are you sure do you want to remove selected members?",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
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

              if (response.statusCode == 201) {
                print(await response.stream.bytesToString());

                //Alert..
                setState(() {
                  widget._isloadingBtn = false;
                });
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Removed",
                  buttons: [
                    DialogButton(
                      color: Kcolor,
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 3);
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
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            // onPressed: () =>Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName)),
            width: MediaQuery.of(context).size.width * 100 / 360,
          ),
          DialogButton(
            color: Kcolor,
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 1);
            },
            // onPressed: () =>Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName)),
            width: MediaQuery.of(context).size.width * 100 / 360,
          )
        ],
      ).show();

  }

  @override
  void initState() {
    setState(() {
      widget._isloading = true;
    });
    _loadMembers();
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
              : memberList.length > 0
              ? ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Center(
                child: SelectReviewerCard(
                  isSelected: widget.selectedEmails.contains(
                      memberList[index].email),
                  reviewerEmail:
                  memberList[index].email,
                  reviewerName:
                  memberList[index].firstName + " "+memberList[index].lastName ,
                  onSelectedReviewer: selectReviewer,
                ),
              );
            },
            itemCount: memberList.length,
          )
              : Container(
            child: Text(
              "No other available members ",
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
            // child: widget._isloadingBtn
            //     ? Center(
            //   child: CircularProgressIndicator(
            //     color: Colors.white,
            //   ),
            // )
            child: Text(
              "Remove from Instant group \n " +
                  widget.selectedEmails.length.toString() +
                  " \n members",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              setState(() {
                widget._isloadingBtn=true;
              });
              print(widget.selectedEmails);
              removeMembers(widget.selectedEmails);
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
