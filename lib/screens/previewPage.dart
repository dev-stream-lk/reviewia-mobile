import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:im_stepper/stepper.dart';
import 'package:conditioned/conditioned.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/services/addPost.dart';
import 'package:reviewia/services/addPost_connection.dart';
import 'package:reviewia/services/getSubCategory.dart';
import 'package:reviewia/structures/addPostStruct.dart';
import 'package:reviewia/structures/selectedCatergory.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:reviewia/services/getBrands.dart';
import 'package:reviewia/services/userState.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../home_data.dart';

class PreviewPost extends StatefulWidget {
  static String id = 'previewPost';
  const PreviewPost({Key? key}) : super(key: key);

  @override
  _PreviewPostState createState() => _PreviewPostState();
}

class _PreviewPostState extends State<PreviewPost> {

  bool _isLoading = false;






  //****************** for picture area ******************************
  List<Asset> images = [];
  String _error = 'No Error Dectected';


  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  buildLoading(BuildContext context) {
    if(_isLoading) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          });
    }
    else{
      Navigator.pop(context);
    }
  }

  Future<void> _saveImage(String subId, String brand, String title, String description, String type)async {
    String email= (await UserState().getUserName());
    String url = KBaseUrl+"api/user/post/create?email="+ email +"&subcategory="+ subId +"&brand="+ brand;
    String token = (await UserState().getToken());

    var headers = {
      'Authorization': token
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'post': '{"title":"$title","description":"$description", "type":"$type"}'
    });
    print("Url ::"+ url);
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      request.files.add(http.MultipartFile.fromBytes('image', imageData, filename: images[i].name));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });
      print(await response.stream.bytesToString());
      Alert(
        context: context,
        type: AlertType.success,
        title: "Post Created",
        desc: "Your post has been added to the Recently added posts ",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {

               Navigator.pushNamedAndRemoveUntil(context, HomePage.id,(route) => false, arguments:HomeData(email));
            },
            width: MediaQuery.of(context).size.width*100/360,
          )
        ],
      ).show();
    }
    else {
      print(response.reasonPhrase);
    }

  }


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as AddPost;
    print("${arguments.title}");
    images = arguments.images;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          automaticallyImplyLeading: false,
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
                children: [
                  header(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01 ,
                  ),
                  Text("Basic Info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Kcolor
                    ),),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Text(
                          "Title: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          arguments.title,
                        style: TextStyle(
                            fontSize: 17,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04 ,
                  ),
                  Row(
                    children: [
                      Text(
                          "Type: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      "p"== arguments.type?
                      Text("Products",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ):Text("Service",
                        style: TextStyle(
                          fontSize: 17,
                        ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04 ,
                  ),
                  Row(
                    children: [
                      Text(
                          "Category: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(arguments.Category,
                        style: TextStyle(
                          fontSize: 17,
                        ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04 ,
                  ),
                  Row(
                    children: [
                      Text(
                          "Sub Category: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(arguments.SubCategory,
                        style: TextStyle(
                          fontSize: 17,
                        ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04 ,
                  ),
                  Row(
                    children: [
                      Text(
                          "Brand: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(arguments.brand,
                        style: TextStyle(
                          fontSize: 17,
                        ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04 ,
                  ),
                  Row(
                    children: [
                      Text(
                        "Description: ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(arguments.description,
                        style: TextStyle(
                          fontSize: 17,
                        ),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05 ,
                  ),
                  Text("Picture Area",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Kcolor
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01 ,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Expanded(
                      child: buildGridView(),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      // Navigator.pop(context);
                        setState(() {
                            _isLoading = true;
                            buildLoading(context);
                          _saveImage(
                              arguments.subId,
                              arguments.brand,
                              arguments.title,
                              arguments.description,
                              arguments.type
                          );
                          //_resetFields();
                        });
                    },
                    color: Kcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
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
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      // setState(() {
                      //
                      //   //_saveImage();
                      //   //_resetFields();
                      //   print("Selected Type: "+ SelectedType);
                      //   print("Selected Category: "+ SelectedCategoryName);
                      //   print("Selected SubCategory: "+ SelectedSubCategoryName);
                      //   print("Selected Brand: "+ selectedBrand);
                      // });
                    },
                    color: Kcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Back',
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

                ],

              ),
            ),
          ),

        )
    );
  }





  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Kcolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Preview Post",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

}