import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reviewia/components/loading.dart';
import 'package:reviewia/components/review_cards.dart';
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
      createInstantGroup( id.toString(),context);
      print("case--4");
      break;
  }
}

createInstantGroup(String id,BuildContext context) {

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
          height: MediaQuery.of(context).size.height*(320/765),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*(50/765),
                child:Text("\n Reviews \n") ,
              ),
              ReviewersLoading(postId:id),
            ],
          ),
        ),
      );
    },
  );
}

class ReviewersLoading extends StatefulWidget {
  late String postId ;
  ReviewersLoading({required this.postId});
  late List<ReviewStruct> _reviewCards = <ReviewStruct>[];
  List<ReviewStruct> _uniquereviewCards = <ReviewStruct>[];
  bool _isloading = true;
  @override
  _ReviewersLoadingState createState() => _ReviewersLoadingState();
}

class _ReviewersLoadingState extends State<ReviewersLoading> {
  getUniqueSet(List<ReviewStruct>reviewCards){

    // var s = reviewCards.toSet().toList();
    for(int i = 0 ; i< reviewCards.length;i++){
      var flags=0;
      for(int j=0;j< widget._uniquereviewCards.length;j++){
        if(widget._uniquereviewCards[j].email==reviewCards[i].email){
          print(widget._uniquereviewCards[j].email + "is email ");
          flags =1;
        }
      }
      if(flags==0){
        setState(() {
          widget._uniquereviewCards.add(reviewCards[i]);
        });
      }

    }
    print(widget._uniquereviewCards.toString()+"is unique values");
    // List<ReviewStruct> unique = reviewCards.
  }
  @override
  void initState() {
    setState(() {
      widget._isloading=true;
    });
    fetchReviewStruct(widget.postId).then((value) {
      setState(() {
        widget._reviewCards.addAll(value);
        getUniqueSet(widget._reviewCards);
         widget._isloading = false;
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget._isloading ? MediaQuery.of(context).size.height*(40/765): MediaQuery.of(context).size.height*(220/765),
      child:widget._isloading ? CircularProgressIndicator(): ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Center(
            child:  SelectReviewerCard(
              isSelected: false,
              reviewerEmail:widget._uniquereviewCards[index].email,
              reviewerName: widget._uniquereviewCards[index].reviewedBy,
            ),
          );
        },
        itemCount: widget._uniquereviewCards.length,
      ),
    );
  }
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

Future setReaction(int id, bool reaction) async {
  String url = KBaseUrl +
      "api/public/review/react?id=" +
      id.toString() +
      "&like=" +
      reaction.toString();
  http.Response response = await http.get(Uri.parse(url));
  return response.statusCode;
}
