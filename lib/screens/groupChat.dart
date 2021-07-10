import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/messageCard.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/components/product_view_card.dart';
import 'package:reviewia/components/review_cards.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/search_page.dart';

import 'add_post_page.dart';
import 'home_Page.dart';

class GroupChat extends StatefulWidget {
  static String id = "GroupChat";

  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  int _currentIndex = 0;
  List<Widget> _screenContainer = [
    HomePage(),
    AddPost(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text("Product 1 Instant Group"),
        actions: [
          IconButton(
            onPressed: () {
              print('pop up');
              _bootomPage(context);
              ;
            },
            icon: Icon(
              Icons.rate_review_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductViewCard(),
              MessageCards(),
              // ReviewCards(),
            ],
          ),
        ),
      ),
    );
  }
}

void _bootomPage(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(MediaQuery.of(context).size.width*25/360)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(15),
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  // color:Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Type message..",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close),)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                  child: Container(
                    margin: EdgeInsets.only(top: 10 ,left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.20,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                    ),
                    child: TextField(
                        cursorColor: Colors.black,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(

                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Content',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                        )
                    ),
                  )

                // child: Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.black,
                //       ),
                //       borderRadius: BorderRadius.all(Radius.circular(20))
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Text("Add a text"),
                //   ),
                // ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    iconSize: MediaQuery.of(context).size.width * 0.12,
                    // padding: EdgeInsets.symmetric(
                    //     vertical:
                    //     MediaQuery.of(context).size.height *
                    //         (12.5 / 692),
                    //     horizontal:
                    //     MediaQuery.of(context).size.width *
                    //         (40 / 360)),
                    color: Kcolor,
                    onPressed: () {
                      Navigator.pushNamed(context, GroupChat.id);
                    },
                    // child: Text(
                    //   'Add a review',
                    //   style: KbuttonSignin,
                    // ),
                    // shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //         color: Colors.blue,
                    //         width: 1,
                    //         style: BorderStyle.solid),
                    //     borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),

            ],

          ),
        );
      });
}
