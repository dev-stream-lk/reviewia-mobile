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

  bool checkBox_1_Val = false;
  bool checkBox_2_Val = false;

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


                  // for Title text feild..
                  Container(
                      margin: EdgeInsets.only(top: 30 ,left: 2, right: 2, bottom: 10) ,
                      height: MediaQuery.of(context).size.height * 0.15,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: checkBox_1_Val,
                              activeColor: Kcolor,
                              onChanged:(newVal){
                                setState(() {
                                  checkBox_1_Val = newVal!;
                                });
                              },
                              ),
                          Container(
                            width:  MediaQuery.of(context).size.width * 0.70,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'You will not be allowed to edit or delete a product or service post once it is submitted.',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10 ,left: 2, right: 2, bottom: 10) ,
                    height: MediaQuery.of(context).size.height * 0.18,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: checkBox_2_Val,
                          activeColor: Kcolor,
                          onChanged:(newVal){
                            setState(() {
                              checkBox_2_Val = newVal!;
                            });
                          },
                        ),
                        Container(
                          width:  MediaQuery.of(context).size.width * 0.70,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            'You will agree to follow the Terms & Conditions and refrain from adding any sort of inapprpriate, plagarized or invalid details.',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Button next....
                  Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10),

                      child: RaisedButton(
                        onPressed: (){},
                        color: Kcolor,
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
