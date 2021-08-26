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
import 'package:reviewia/services/addPost.dart';
import 'package:reviewia/services/addPost_connection.dart';
import 'package:reviewia/services/getSubCategory.dart';
import 'package:reviewia/structures/selectedCatergory.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class TestAddPost extends StatefulWidget {
  const TestAddPost({Key? key}) : super(key: key);

  @override
  _TestAddPostState createState() => _TestAddPostState();
}

class _TestAddPostState extends State<TestAddPost> {





//******************for basic info******************************
  //Date time format..
  DateTime date = DateTime.now();
  Future<Null> selectTimePicker(BuildContext) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2050)
    );
    if(picked != null && picked != date){
      setState(() {
        date = picked;
        print(date.toString());
      });
    }
  }


  String valueType = "";

  List<String> type = ["Service","Product"];
  List<String> brands = [];

  //****************** for picture area ******************************
  List<Asset> images = [];
  String _error = 'No Error Dectected';
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
  }
  // **************data initializing
  String title= "";
  String SelectedType= "";
  String SelectedTypeName= "";
  String SelectedCategoryName= "";
  String SelectedSubCategoryName= "";
  var selectedTypeIndex;
  var selectedCategoryIndex;
  var selectedSubCategoryIndex;
  var selected_categoryId;
  var selected_subCategory;
  final titleText = TextEditingController();

   List<AddPost_category> _categories=[];
   List _type = [
     {
     "typeName":"Products",
     "value":"p"
      },
     {
       "typeName":"Services",
       "value":"s"
     },
   ];


  //********** to get all category for dropdown ***********
  late List categoryList=[];
  Future<dynamic> _getCategory( String selectedType)async{
    String url = KBaseUrl+"api/public/category/all";
    await http.get(Uri.parse(url)).then((response)
      {
        var data = json.decode(response.body);
        var _categoryList = data.map((e) => AddPost_category.fromJson(e)).toList();
        setState(() {
          categoryList = _categoryList;
          for (var item in categoryList) {
                print('${item.categoryName} - ${item.categoryId} - ${item.type}');
              }
        });
      }
    );
    return categoryList;
    }


  //********** to get sub category for dropdown ***********
  late List sub_categoryList=[];
  Future<dynamic> _getSubCategory( String id)async{
    print("category Id+++" +id);
    String url = KBaseUrl + "api/public/category?id="+id;
    await http.get(
        Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }).then((response) {
      late SelectedCatergory selectedCatergory;
      var data = json.decode(response.body);

      selectedCatergory = new SelectedCatergory(
          categoryId: data['categoryId'],
          categoryName: data['categoryName'],
          type: data['type'],
          subCategoryList: data['subCategoryList']);
      if (selectedCatergory.subCategoryList != null) {
        var _subcategoryList = selectedCatergory.subCategoryList.map((e) =>
            GetSubCategory.fromJson(e)).toList();
        setState(() {
          sub_categoryList = _subcategoryList;
          // for (var item in sub_categoryList) {
          //   print('${item.subCategoryName} - ${item.subCategoryId}');
          // }
        });
      }
      else {
        print("Sub category empty....");
      }
    });
    return sub_categoryList;
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

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Reviewia",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  _saveImage()async{
    if(images != null){
      for(var i = 0; i< images.length; i++){
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(
            imageData,
            filename: images[i].name,
        contentType: MediaType('image', 'jpg'));
        FormData formData = FormData.fromMap({
          "image": multipartFile
        });
        print(formData);
        // use formData to pass images....
      }
    }
  }

  //******************for terms and conditions ******************************
  bool checkBox_1_Val = false;
  bool checkBox_2_Val = false;



  int activeStep = 0;
  int upperBound = 2;
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
                NumberStepper(

                  numbers:[
                    1,
                    2,
                    3,
                  ],
                  activeStep: activeStep,
                  activeStepColor: Kcolor,
                  numberStyle: const TextStyle(color: Colors.white),


                  // This ensures step-tapping updates the activeStep.
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                header(),
                Container(
                  child: Conditioned(
                    cases: [
                      Case(activeStep == 0, builder: () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 2) ,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                              child: TextFormField(
                                  initialValue: title,
                                    onChanged: (text) {
                                    print('First text field: $text');
                                      title = '$text';
                                    },
                                  cursorColor: Colors.black,
                                  //keyboardType: inputType,
                                  decoration: InputDecoration(
                                    // hintStyle: TextStyle(fontSize: 17),
                                    hintText: 'Add Title',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 10),
                                  )
                              )
                          ),
                          //type..
                          Container(
                            margin: EdgeInsets.only(top: 20 ,left: 2, right: 2) ,
                            height: MediaQuery.of(context).size.height * 0.09,
                            padding: EdgeInsets.all(0.0),
                            child: CustomSearchableDropDown(
                              initialIndex: selectedTypeIndex,
                              hideSearch: true,
                              items: _type,
                              label: 'Select Type',
                              labelStyle:  TextStyle(fontSize: 17),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                              ),

                              dropDownMenuItems: _type?.map((item) {
                                return item['typeName'];
                              })?.toList() ??
                                  [],
                              onChanged: (value){
                                if(value!=null)
                                {
                                  setState(() {
                                    selectedTypeIndex = _type.indexOf(value);
                                    SelectedTypeName = value["typeName"];
                                    SelectedType = value["value"];
                                    _getCategory(SelectedType);
                                  });

                                }
                                else{
                                  selected_categoryId=null;
                                }
                              },
                            ),
                          ),

                          //Category...
                          Container(
                            margin: EdgeInsets.only(top: 20 ,left: 2, right: 2) ,
                            height: MediaQuery.of(context).size.height * 0.09,
                            padding: EdgeInsets.all(0.0),
                            child: CustomSearchableDropDown(
                                initialIndex: selectedCategoryIndex,
                                items: categoryList,
                                label: 'Select Category',
                                labelStyle:  TextStyle(fontSize: 17),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),

                                dropDownMenuItems: categoryList?.map((item) {
                                  if(item.type == SelectedType){
                                    return item.categoryName;
                                  }
                                })?.toList() ??
                                    [],
                                onChanged: (value){
                                  if(value!=null)
                                  {
                                    setState(() {
                                      selectedCategoryIndex = categoryList.indexOf(value);
                                      selected_categoryId = '${value.categoryId}';
                                      _getSubCategory(selected_categoryId.toString());
                                    });

                                  }
                                  else{
                                    selected_categoryId=null;
                                  }
                                },
                              ),
                            ),


                          //Subcategory...
                          Container(
                            margin: EdgeInsets.only(top: 20 ,left: 2, right: 2) ,
                            height: MediaQuery.of(context).size.height * 0.09,
                            padding: EdgeInsets.all(0.0),
                              child: CustomSearchableDropDown(
                                initialIndex: selectedSubCategoryIndex,
                                items: sub_categoryList,
                                label: 'Select Subcategory',
                                labelStyle:  TextStyle(fontSize: 17),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),

                                dropDownMenuItems: sub_categoryList?.map((item) {
                                  return item.subCategoryName;
                                })?.toList() ??
                                    [],
                                onChanged: (value){
                                  if(value!=null)
                                  {
                                    selectedSubCategoryIndex = sub_categoryList.indexOf(value);
                                    //selected_categoryId = '${value.categoryId}';
                                  }
                                  else{
                                    //selected_categoryId=null;
                                  }
                                },
                              ),
                            ),


                          //Brand...
                          Container(
                            margin: EdgeInsets.only(top: 20 ,left: 2, right: 2) ,
                            height: MediaQuery.of(context).size.height * 0.09,
                            padding: EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: (){print("Tapped____");},
                              child: CustomSearchableDropDown(
                                items: _categories,
                                label: 'Select Brand',
                                labelStyle:  TextStyle(fontSize: 17),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),

                                dropDownMenuItems: _categories.map((item) {
                                  return item.categoryName;
                                })?.toList() ??
                                    [],
                                onChanged: (value){
                                  if(value!=null)
                                  {
                                    selected_categoryId = '${value.categoryId}';
                                  }
                                  else{
                                    selected_categoryId=null;
                                  }
                                },
                              ),
                            ),

                          ),




                          // for date picker..
                          Container(
                              margin: EdgeInsets.only(top:20, left: 2, right: 2, bottom: 10) ,
                              height: MediaQuery.of(context).size.height * 0.07,
                              padding: EdgeInsets.only(top: 5.0, left: 10),
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
                                  readOnly: true ,
                                  onTap: (){
                                    selectTimePicker(context);
                                  },
                                  //keyboardType: inputType,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 17),
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.022),
                                      onPressed: () {
                                        selectTimePicker(context);
                                      },
                                      icon: Icon(Icons.calendar_today_outlined),
                                      color: Kcolor,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 2,right: 2,top: 2,bottom: MediaQuery.of(context).size.height * 0.022),
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
                        ],
                      )),
                      Case(activeStep == 1, builder: () =>Expanded(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
                                child: RaisedButton(
                                  onPressed:loadAssets ,
                                  child: Text("Pick Image"),
                                ),
                              ),
                              true == images.isEmpty?
                                  Text("Choose maximum 3 photos"):Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),]
                                ),
                                height: MediaQuery.of(context).size.height * 0.3,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.05,
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    bottom: MediaQuery.of(context).size.height * 0.05),

                                child: Center(
                                  child: Expanded(
                                    child: buildGridView(),
                                  ),
                                ),

                              ),


                            ],
                          )
                      )),
                      Case(activeStep == 1, builder: () => Icon(Icons.wb_cloudy)),
                      Case(activeStep == 2, builder: () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // for Title text feild..
                          Container(
                            margin: EdgeInsets.only(top: 30 ,left: 2, right: 2, bottom: 10) ,
                            height: MediaQuery.of(context).size.height * 0.15,
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.008),
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
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.008),
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
                                onPressed: _saveImage,
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
                      )),
                    ],
                    defaultBuilder: () => Icon(Icons.wb_sunny),
                  ),
                ),

              ],

            ),
          ),
        ),

      )
    );
  }



  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
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
              headerText(),
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

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Picture Area';

      case 2:
        return 'Agreement Section';

      default:
        return 'Basic Info';
    }
  }
}