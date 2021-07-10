import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/screens/groupChat.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/screens/profile_page.dart';

class GroupCard extends StatefulWidget {
  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  double rate = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, GroupChat.id);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          margin: EdgeInsets.only(bottom: 10, top: 10),
          decoration: BoxDecoration(
            // color: Colors.cyan,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFEFE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),

                  // color:Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFC494C4),
                          backgroundImage: AssetImage('images/pep.jpg'),
                          radius: MediaQuery.of(context).size.width * 22.58 / 360,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child:
                          Text("Chamari Wikrmawardna", style: KPostCard)),
                      Expanded(
                          flex: 1,
                          child:Text(
                            '(Creator)',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black26,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ) ,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding:
                  EdgeInsets.only(left: 15,  right: 15, bottom: 10),
                  decoration: BoxDecoration(
                    // color: Color(0xFFAAAAAA),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                'Content: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Product 1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                  'Create Date: ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                          Text(
                            '2021/07/12',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
