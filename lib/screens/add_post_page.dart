import 'package:flutter/material.dart';
import 'package:reviewia/components/button_logon.dart';
import 'package:reviewia/screens/add_post_page2.dart';
import 'package:reviewia/screens/home_Page.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final tabs = [
    AddPost2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin with top of container between app bar...
      margin: EdgeInsets.only(top: 10 ,left: 15, right: 15,bottom: 10) ,
      height: MediaQuery.of(context).size.height * 1.10,
      padding: EdgeInsets.all(10.0),

      //container color, shadow, corner radius adjestment...
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // smooth page indicator..
          Container(
            margin: EdgeInsets.only(top: 2 ,left: 2, right: 2) ,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.all(10.0),
            color: Colors.blue,
          ),

          //Text for Picture Area..
          Text(
            'Basic Info',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),


          // for Title text feild..
          Container(
              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10) ,
              height: MediaQuery.of(context).size.height * 0.06,
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
                  //keyboardType: inputType,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Post Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                  )
              )
          ),

          // for Title text feild..
          Container(
              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10) ,
              height: MediaQuery.of(context).size.height * 0.06,
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
                  //keyboardType: inputType,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Post Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                  )
              )
          ),

          // for Title text feild..
          Container(
              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10) ,
              height: MediaQuery.of(context).size.height * 0.06,
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
                  //keyboardType: inputType,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Post Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                  )
              )
          ),
          Container(
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
                    hintText: 'Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                  )
              )
          ),

          // Button next....
          Container(
              width: MediaQuery.of(context).size.width * 0.25,
              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10),

              child: RaisedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPost2()),
                  );
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ],
                ) ,

              )
          )

        ],
      ),
    );

  }
}
