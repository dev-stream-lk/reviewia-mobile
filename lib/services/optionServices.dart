
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/userState.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

selectedOption(String val, int id , context)  {
  print("The Selected Value is :"+val);
  switch(val){
    case '2':
      addToFavList(id.toString(),context);
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