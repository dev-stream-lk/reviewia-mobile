import 'package:flutter/material.dart';
import 'package:reviewia/components/button_logon.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/home_Page.dart';

class AddPost3 extends StatefulWidget {
  static const String id = "AddPost3";

  @override
  _AddPost3State createState() => _AddPost3State();
}

class _AddPost3State extends State<AddPost3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
        title: Text(
          "Add new post",
          style: KappTitle,
        ),
      ),

      body: Center(
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
                    'Agreement Section',
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
                      width: MediaQuery.of(context).size.width * 0.28,
                      margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10),

                      child: RaisedButton(
                        onPressed: (){},
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit',
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
            ),
          )
      ),
    );
  }
}
