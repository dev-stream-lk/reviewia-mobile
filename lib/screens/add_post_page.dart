import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Center(
          child: SingleChildScrollView(
            child: Container(
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
                    'Picture Area',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // for choose image..
                  Container(
                    margin: EdgeInsets.only(top: 2 ,left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.35,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.blue,
                  ),

                  // for choosed images line..
                  Container(
                    margin: EdgeInsets.only(top: 2 ,left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.blue,
                  ),

                  // for Title text feild..
                  Container(
                      margin: EdgeInsets.only(top: 10 ,left: 2, right: 2, bottom: 10) ,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius:  BorderRadius.circular(32),
                      ),
                      child: TextField(
                          cursorColor: Colors.black,
                          //keyboardType: inputType,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Search your trips',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                          )
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2 ,left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.20,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.blue,
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
