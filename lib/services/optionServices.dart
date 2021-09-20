import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:reviewia/components/loading.dart';
import 'package:reviewia/components/review_cards.dart';
import 'package:reviewia/components/reviewers_loading.dart';
import 'package:reviewia/components/select_reviewer_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/favouriteListStruct.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:reviewia/structures/postView.dart';

import 'network.dart';

enum SingingCharacter { fakepost, notRelevent,other }

selectedOption(String val, int id, context) {
  print("The Selected Value is :" + val);
  switch (val) {
    case '2':
      addToFavList(id.toString(), context);
      break;
    case '3':
      removeFromFavList(id.toString(), context);
      print("case--3");
      break;
    case '4':
      createInstantGroup(id.toString(), context);
      print("case--4");
      break;
    case '5':
      deletePost(id.toString(), context);
      print("case--5");
      break;
    case '6':
      reportThePost(id.toString(), context);
      print("case--6");
  }
}

createInstantGroup(String id, BuildContext context) {
  List<String> locations = [
    "1",
    "2",
  ];
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 100, //16
        child: Container(
          height: MediaQuery.of(context).size.height * (320 / 765),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * (50 / 765),
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Add Reviewers to group \n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ReviewersLoading(postId: id),
            ],
          ),
        ),
      );
    },
  );
}

Future addToFavList(String id, BuildContext context) async {
  String userName = await UserState().getUserName();
  String token = await UserState().getToken();

  String url =
      KBaseUrl + "api/user/post/favourite?email=" + userName + "&id=" + id;
  http.Response response = await post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Favorite list",
      desc: "Added the post to fav list",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  } else if (response.statusCode == 409) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Favorite list",
      desc: "Already added to fav list",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  } else {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Favorite list",
      desc: "Internal ERROR",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  }
}

Future removeFromFavList(String id, BuildContext context) async {
  String userName = await UserState().getUserName();
  String token = await UserState().getToken();

  String url =
      KBaseUrl + "api/user/post/favourite?email=" + userName + "&id=" + id;
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Favorite list",
      desc: "Successfully removed from favourite list",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  } else if (response.statusCode == 409) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Favorite list",
      desc: "Already added to fav list",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  } else {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Favorite list",
      desc: "Internal ERROR",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: MediaQuery.of(context).size.width * 100 / 360,
        )
      ],
    ).show();
  }
}

Future<FavouriteListStruct> fetchFavPostView() async {
  String userName = await UserState().getUserName();
  String url = KBaseUrl + "api/user/post/favourite?email=" + userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': t},
  );
  if (response.statusCode == 200) {
    late FavouriteListStruct favouriteListStruct;
    var decodedUserData = jsonDecode(response.body);
    favouriteListStruct = new FavouriteListStruct(
        id: decodedUserData['id'],
        createdBy: decodedUserData["createdBy"],
        posts: decodedUserData["posts"]);

    return favouriteListStruct;
  } else {
    throw Exception("API Error");
  }
}

Future setReaction(int id, bool reaction, bool remove) async {
  String userName = await UserState().getUserName();
  print("review id is:" + id.toString());
  // String url = KBaseUrl +
  //     "api/public/review/react?id=" +
  //     id.toString() +
  //     "&like=" +
  //     reaction.toString()+"&remove="+false.toString();
  String url = KBaseUrl +
      "api/public/review/react?email=" +
      userName +
      "&id=" +
      id.toString() +
      "&like=" +
      reaction.toString() +
      "&remove=" +
      remove.toString();
  http.Response response = await http.get(Uri.parse(url));
  return response.statusCode;
}

deletePost(String id, BuildContext context) async {
  print("Post ID:" + id);
  String token = await UserState().getToken();
  String url = KBaseUrl + "api/user/post?id=" + id;
  // http.Response response = await http.delete(Uri.parse(url));
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Delete the post",
    desc: "Do you want to delete the Post",
    buttons: [
      DialogButton(
        color: Kcolor,
        child: Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          deletePostSure(url, context);
        },
        width: MediaQuery.of(context).size.width * 100 / 360,
      ),
      DialogButton(
        color: Kcolor,
        child: Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: MediaQuery.of(context).size.width * 100 / 360,
      )
    ],
  ).show();
}

Future deletePostSure(String url, BuildContext context) async {
  String token = await UserState().getToken();
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    int count = 0;
    Alert(
      context: context,
      type: AlertType.success,
      title: "Delete the post",
      desc: "SuccessFully Deleted the post",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okey",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
          width: MediaQuery.of(context).size.width * 100 / 360,
        ),
      ],
    ).show();
  }
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
_reportAlart(String reason,String id, BuildContext context) async{
   buildLoading(context);
  var tk = await UserState().getToken();
  var uN = await UserState().getUserName();
  var n = await ReprotItem( uN,tk, id, "p", reason);
  var response = int.parse(n.statusCode.toString());
  assert(response is int);
  int count = 0;

  if(response == 201){
    print("Reported");
    Alert(
      context: context,
      type: AlertType.success,
      title: "Reported the post",
      buttons: [
        DialogButton(
          color: Kcolor,
          child: Text(
            "Okey",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).popUntil((_) => count++ >= 3);
          },
          width: MediaQuery.of(context).size.width * 100 / 360,
        ),
      ],
    ).show();

  }
}

reportThePost(String id, BuildContext context) {

  List<dynamic> reason = <dynamic>[];

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Report Options",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Inappropriate Review",
                      "value": "Inappropriate Review",
                    },
                    {
                      "display": "Abusive Content",
                      "value": "Abusive Content",
                    },
                    {
                      "display": "Its a spam",
                      "value": "Its a spam",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  onSaved: (value) {
                    if (value == null) return;

                      reason = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  child: Text('Report'),
                  onPressed: (){
                    print("report");
                      String Newreason ="";
                      for(var item in reason){
                        Newreason = Newreason + '${item}, ';
                      }
                      print(Newreason);
                     _reportAlart(Newreason,id,context);
                     // Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // return showDialog(
  //   context: context,
  //   builder: (context) {
  //
  //
  //     // return Dialog(
  //     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     //   elevation: 100, //16
  //     //   child: Container(
  //     //     height: MediaQuery.of(context).size.height * (450 / 765),
  //     //     child: Column(
  //     //       children: [
  //     //         Container(
  //     //           height: MediaQuery.of(context).size.height * (50 / 765),
  //     //           margin: EdgeInsets.only(bottom: 10, top: 10),
  //     //           child: Text(
  //     //             "Report the group \n",
  //     //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //     //           ),
  //     //         ),
  //     //         ReportList(),
  //     //       ],
  //     //     ),
  //     //   ),
  //     // );
  //   },
  // );
}

class ReportList extends StatefulWidget {


  SingingCharacter? _character = SingingCharacter.fakepost;
  late bool isEnable=false;


  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('hell');
    return Container(
      child: Column(
        //-------------------------------Option menu------------------------------------------
        children: <Widget>[
          // ListTile(
          //   title: const Text('FakePost'),
          //   leading: Radio<SingingCharacter>(
          //     value: SingingCharacter.fakepost,
          //     groupValue: widget._character,
          //     onChanged: (SingingCharacter? value) {
          //       setState(() {
          //         widget._character = value;
          //       });
          //       print('sss');
          //     },
          //   ),
          // ),
          // ListTile(
          //   title: const Text('other'),
          //   leading: Radio<SingingCharacter>(
          //     value: SingingCharacter.other,
          //     groupValue: widget._character,
          //     onChanged: (SingingCharacter? value)  {
          //       setState(() {
          //         widget.isEnable=true;
          //         widget._character=value;
          //       });
          //       print('sss-2');
          //     },
          //   ),
          // ),
          !widget.isEnable?Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              enabled:true ,
            ),
          ):Divider(
            height: 5,
          ),
        ],
      ),
    );
  }
}
