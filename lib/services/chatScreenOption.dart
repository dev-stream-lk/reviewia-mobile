import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/components/removeFromChat.dart';
import 'package:reviewia/components/reviewers_loading_chat.dart';
import 'package:reviewia/components/reviews.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/favouriteListStruct.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedGroup.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:reviewia/structures/postView.dart';

import 'network.dart';

selectedOption(String val, String id,PostsView post, String creator,context) async {
  print("The Selected Value is :" + val);
  String token = (await UserState().getToken());
  String url = KBaseUrl + "api/user/group/"+id;
  late SlectedGroup selectedgroup;
  await http.get(
      Uri.parse(url),
      headers: <String, String>{
      'Authorization': token,
      }).then((response) {
    var data = json.decode(response.body);

    selectedgroup = new SlectedGroup(
      id: data['id'],
      createdAt: data['createdAt'],
      postId: data['postId'],
      active: data['active'],
      messages: data['messages'],
      users: data['users'],
    );
  });

  switch (val) {
    case '1':
      showDetails(selectedgroup,post,creator, context);
      break;
    case '2':
      AddMembers(selectedgroup,post,context);
      break;
    case '3':
      removeFromGroup(selectedgroup,context);
      break;
    case '4':
      deactivateChat(selectedgroup.id,token, context);
      print("case--4");
      break;
    case '5':
      LeaveGroup(selectedgroup.id,token, context);
      break;
  }
}
int daysBetween(DateTime create, DateTime now) {
  create = DateTime(create.year, create.month, create.day);
  now = DateTime(now.year, now.month, now.day);
  return now.difference(create).inHours;
}

showDetails(SlectedGroup selectedgroup,PostsView post, String creator,BuildContext context) {
  var members = selectedgroup.users.map((e) => Users.fromJson(e)).toList();
  List<Users> userList= members;
  DateTime createdDate = DateTime.parse(selectedgroup.createdAt);
  DateTime now = DateTime.now();
  int different = 168 -daysBetween(createdDate, now);
  int hours = different%24;
  int days = (different/24).round();

  
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 100, //16
        child: Container(
          height: MediaQuery.of(context).size.height * (330 / 765),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Group Info",
                      style: TextStyle(
                        fontSize: 20,
                        color: Kcolor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
             SizedBox(
               height: 10,
             ),

             Row(
               children: [
                 Text("Title: ",
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                   ),
                 ),
                 Text(post.title,
                   style: TextStyle(
                       fontSize: 20,
                       //fontWeight: FontWeight.bold
                   ),
                 )
               ],
             ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Created by: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(creator,
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Remaining Time: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  hours!=0?Text(days.toString()+" Days and "+ hours.toString()+" hours",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold
                    ),
                  ):Text(days.toString()+" Days",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Message Count: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(selectedgroup.messages.length.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Members : ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: members.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFFC494C4),
                                    backgroundImage: AssetImage(userList[index].avatar),
                                    radius:
                                    MediaQuery.of(context).size.width * 22.58 / 360,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                      userList[index].firstName+ " " + userList[index].lastName,
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }
                    ),
                
              )
            ],
          ),
        ),
      );
    },
  );
}

Future AddMembers(SlectedGroup selectedgroup,PostsView post,BuildContext context) async{
  print('reviewes'+ post.postId.toString());

  var members = selectedgroup.users.map((e) => Users.fromJson(e)).toList();

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 100, //16
        child: Container(
          height: MediaQuery.of(context).size.height * (320 / 765),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Available reviewers",
                      style: TextStyle(
                          fontSize: 20,
                          color: Kcolor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ReviewersLoadingChat(postId:post.postId.toString(), members:members, groupId:selectedgroup.id.toString()),
            ],
          ),
        ),
      );
    },
  );

}

Future removeFromGroup(SlectedGroup selectedgroup, BuildContext context) async {

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 100, //16
        child: Container(
          height: MediaQuery.of(context).size.height * (320 / 765),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Remove Members",
                      style: TextStyle(
                          fontSize: 20,
                          color: Kcolor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RemoveFromChat(groupData: selectedgroup),
            ],
          ),
        ),
      );
    },
  );



}

buildLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      });
}


Future deactivateChat(int id, String token, BuildContext context) async {
  String userName = await UserState().getUserName();
  String url = KBaseUrl + "api/user/group/deactivate?email="+userName;
  bool _isload = false;
  return Alert(
    context: context,
    type: AlertType.warning,
    title: "Are You sure to Diactivate the chat?",
    desc:
    "Your chat will diactivate but all the messages will not be delete",
    buttons: [
      DialogButton(
        color: Kcolor,
        child: Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {
          buildLoading(context);
          var headers = {
            'Authorization': token,
            'Content-Type': 'application/json'
          };
          var request = http.Request('GET', Uri.parse(url));
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 3);
          }
          // Navigator.pop(context);
          // Navigator.of(context).popUntil(ModalRoute.withName(HomePage.id,));
          // Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false,arguments: (userName));
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
        onPressed: () {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 1);
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

Future LeaveGroup(int id, String token, BuildContext context) async {
  String userName = await UserState().getUserName();
  List selectedList = [];
  selectedList.add(userName);
  String url = KBaseUrl + 'api/user/group/remove?id='+id.toString();

  Alert(
    context: context,
    type: AlertType.warning,
    title: "Are you sure do you want to leave from group?",
    buttons: [
      DialogButton(
        color: Kcolor,
        child: Text(
          "yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {
          buildLoading(context);
          var headers = {
            'Authorization': token,
            'Content-Type': 'application/json'
          };
          var request = http.Request('POST', Uri.parse(url));
          request.body = json.encode({
            "emails": selectedList
          });
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 201) {
            print(await response.stream.bytesToString());

          }
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 3);
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

Future getNumberOfNotification(String userName)async{

  String url = KBaseUrl+"api/user/notification/count?email="+userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  print(response.body);
  return response.body;
}
