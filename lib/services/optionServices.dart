import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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
      deletePost(id.toString(),context);
      print("case--5");
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

Future setReaction(int id, bool reaction,bool remove) async {
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
      "&remove="+remove.toString();
  http.Response response = await http.get(Uri.parse(url));
  return response.statusCode;
}

deletePost(String id,BuildContext context)async{
  print("Post ID:"+id);
  String token = await UserState().getToken();
  String url = KBaseUrl+"api/user/post?id="+id;
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
          onPressed: (){
              deletePostSure(url,context);


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

Future deletePostSure(String url,BuildContext context)async {
  String token = await UserState().getToken();
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token},
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
          width: MediaQuery
              .of(context)
              .size
              .width * 100 / 360,
        ),
      ],
    ).show();
  }
}

