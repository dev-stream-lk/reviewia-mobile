import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';

class ContactUs extends StatefulWidget {
  static const String id = "ContactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "Contact You",
          style: KappTitle,
        ),
      ),

      body: Center(
          child: SingleChildScrollView(
            child: Container(
              //margin with top of container between app bar...
              margin: EdgeInsets.only(top: 10 ,left: 15, right: 15,bottom: 10) ,
              height: MediaQuery.of(context).size.height * 0.86,
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
                    margin: EdgeInsets.only(left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.02,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                  ),

                  //Text for Picture Area..
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // for choose image..


                  // for social media Icon set ..
                  Container(
                    margin: EdgeInsets.only(left: 2, right: 2) ,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.058),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.facebookF,color: Kcolor,),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.google,color: Kcolor,),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.twitter,color: Kcolor,),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.linkedin,color: Kcolor,),
                        )
                      ],
                    ),
                  ),

                  Text(
                    'Send your direct messages',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // for email text feild..
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
                            icon: Icon(Icons.email_outlined),
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Email',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                          )
                      )
                  ),

                  //content area..
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
                            hintText: 'Content...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                          )
                      )
                  ),

                  // Button next....
                  Container(
                      width: MediaQuery.of(context).size.width * 1,
                      margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 2),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: MediaQuery.of(context).size.width * 0.30,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: ExactAssetImage('images/contactUs.png'),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )),
                            ],
                          ),
                          RaisedButton(
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

                          ),
                        ],
                      )
                  ),
                  // Button next....
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.10,
                  //   margin: EdgeInsets.only(left: 2, right: 2),
                  //
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //             width: MediaQuery.of(context).size.width * 0.2,
                  //             height: MediaQuery.of(context).size.width * 0.2,
                  //             decoration: new BoxDecoration(
                  //               image: new DecorationImage(
                  //                 image: ExactAssetImage('images/contactUs.png'),
                  //                 fit: BoxFit.fitHeight,
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  // )

                ],
              ),
            ),
          )
      ),
    );
  }
}
