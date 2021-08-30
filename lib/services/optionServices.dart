
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/favouriteListStruct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:reviewia/structures/postView.dart';


selectedOption(String val, int id , context)  {
  print("The Selected Value is :"+val);
  switch(val){
    case '2':
      addToFavList(id.toString(),context);
      break;
    case '3':
      removeFromFavList(id.toString(),context);
      print("case--3");
      break;
  }
}



Future addToFavList(String id , BuildContext context)async{
  String userName = await UserState().getUserName();
  String token = await UserState().getToken();

  String url = KBaseUrl + "api/user/post/favourite?email="+userName+"&id="+id;
  http.Response response = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : token
      },
  );
  print(response.statusCode);
  if(response.statusCode==200){
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
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }else if(response.statusCode==409){
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
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }else{
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
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }


}

Future removeFromFavList(String id , BuildContext context)async{
  String userName = await UserState().getUserName();
  String token = await UserState().getToken();

  String url = KBaseUrl + "api/user/post/favourite?email="+userName+"&id="+id;
  http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : token
    },
  );
  print(response.statusCode);
  if(response.statusCode==200){
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
          onPressed: (){
            Navigator.pop(context);},
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }else if(response.statusCode==409){
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
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }else{
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
          width: MediaQuery.of(context).size.width*100/360,
        )
      ],
    ).show();
  }


}

Future<FavouriteListStruct>fetchFavPostView() async {
  String userName = await UserState().getUserName();
  String url = KBaseUrl + "api/user/post/favourite?email="+userName;
  String t = await UserState().getToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization' : t
    },
  );
  if (response.statusCode == 200) {
    late FavouriteListStruct favouriteListStruct;
    var decodedUserData = jsonDecode(response.body);
    favouriteListStruct = new FavouriteListStruct(
        id:decodedUserData['id'] ,
        createdBy: decodedUserData["createdBy"],
        posts: decodedUserData["posts"]);


    return favouriteListStruct;
  } else {
    throw Exception("API Error");
  }
}

Future setReaction(int id,bool reaction)async{
  String url = KBaseUrl+"api/public/review/react?id="+id.toString()+"&like="+reaction.toString();
  http.Response response = await http.get(Uri.parse(url));
  return response.statusCode;
}


