// @dart = 2.9
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviewia/components/button_logon.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/add_post_page3.dart';
import 'package:reviewia/screens/home_Page.dart';

class AddPost2 extends StatefulWidget {
  static const String id = "AddPost2";

  @override
  _AddPost2State createState() => _AddPost2State();
}

class _AddPost2State extends State<AddPost2> {

  PickedFile _imageFile;
  String _status;
  bool _imageLoading;
  ImagePicker _imagePicker;

  @override
  void initState() {
    super.initState();

    _status = "";
    _imageLoading = false;
    _imagePicker = ImagePicker();

  }

  Future<PickedFile> _loadImage( ImageSource imageSource ) async{
    PickedFile file = await _imagePicker.getImage(source: imageSource);
    if(null!= file){
      //
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "Add new post",
          style: KappTitle,
        ),
      ),

      body: Center(
          child: SingleChildScrollView(
              child: Container(
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
                              child: Column(
                                children: [
                                  null == _imageFile
                                      ? Container()
                                      : Image.file(
                                    File(_imageFile.path),
                                    filterQuality: FilterQuality.high,
                                  ),
                                  SizedBox(height: 10),
                                  Text(_status),
                                  SizedBox(height: 10),
                                  Container(
                                      child: RaisedButton(
                                        onPressed: () async {
                                          setState(() {
                                            _imageLoading = true;
                                            _imageFile = null;
                                          });
                                          PickedFile file = await _loadImage(ImageSource.gallery);
                                          if(null != file){
                                            setState(() {
                                              _imageFile = file;
                                              _imageLoading = false;
                                              _status = "Loaded";
                                            });
                                          }
                                          else{
                                            setState(() {
                                              _imageFile = null;
                                              _imageLoading = false;
                                              _status = "Error";
                                            });
                                          }
                                        },
                                        color: Kcolor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'choose Image',
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
                                  ),

                                ],
                              ),
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
                                width: MediaQuery.of(context).size.width * 0.27,
                                margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10),

                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddPost3()),
                                    );
                                  },
                                  color: Kcolor,
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
                      ),
                    )
                ),
              )
          )
      ),
    );
  }
}


