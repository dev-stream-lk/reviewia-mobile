import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/groupCard.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';

class ChatList extends StatefulWidget {
  static String id = 'ChatList';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text(
            "My Groups",
            style: KappTitle,
          ),
        ),

        body: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015),
                    child: Text(
                      'My Chats',
                      style: KReviewiaMostTitle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  GroupCard(),
                  GroupCard(),
                  GroupCard(),
                  GroupCard(),
                  GroupCard(),
                ],
              ),
            ),
          ),
        ));
  }
}
