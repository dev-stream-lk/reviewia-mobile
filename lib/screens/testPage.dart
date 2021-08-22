import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:im_stepper/stepper.dart';
import 'package:conditioned/conditioned.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/addPost.dart';
import 'package:flutter/scheduler.dart';

class TestAddPost extends StatefulWidget {
  const TestAddPost({Key? key}) : super(key: key);

  @override
  _TestAddPostState createState() => _TestAddPostState();
}

class _TestAddPostState extends State<TestAddPost> {

  String url =  KBaseUrl+ "api/public/category/all";



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
  List<String> brands = [
    "Home Lands",
    "Arduino",
    "Atlas",
  ];
  List<String> category = [
    "Education",
    "Electronic",
    "Jobs",
    "Properties",
  ];

  //****************** for picture area ******************************
  List<Asset> images = [];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
    print("Add post page******");
    SchedulerBinding.instance!.addPostFrameCallback((_) => getCategory());
  }

  void getCategory () async {
    String data = await getUserDetails(url);
    print(data);
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

                          // for type selection dropdown field..
                          Container(
                              margin: EdgeInsets.only(top: 20 ,left: 2, right: 2) ,
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                              ),

                              //Type selection dropdown..
                              child: FindDropdown(
                                items: type,
                                onChanged: (item) {
                                  print(item);
                                },
                                selectedItem: "Select type",
                                showSearchBox: false,
                                searchBoxDecoration: InputDecoration(hintText: "Search", border: OutlineInputBorder()),
                                backgroundColor: Colors.white,
                                titleStyle: TextStyle(color: Colors.blue),
                                validate: (String? item) {
                                  if (item == null)
                                    return "Required field";
                                  else if (item == "Brasil")
                                    return "Invalid item";
                                  else
                                    return null;
                                },
                              )
                          ),

                          // for Category selection dropdown field..
                          Container(
                              margin: EdgeInsets.only( left: 2, right: 2) ,
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                              ),

                              //Type selection dropdown..
                              child: FindDropdown(
                                items: category,
                                onChanged: (item) {
                                  print(item);
                                },
                                selectedItem: "Select Category",
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(hintText: "Search", border: OutlineInputBorder()),
                                backgroundColor: Colors.white,
                                titleStyle: TextStyle(color: Colors.blue),
                                validate: (String? item) {
                                  if (item == null)
                                    return "Required field";
                                  else if (item == "Brasil")
                                    return "Invalid item";
                                  else
                                    return null;
                                },
                              )
                          ),

                          // for date picker..
                          Container(
                              margin: EdgeInsets.only(left: 2, right: 2, bottom: 10) ,
                              height: MediaQuery.of(context).size.height * 0.06,
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


                          // for Category selection dropdown field..
                          Container(
                              margin: EdgeInsets.only( top: 20,left: 2, right: 2) ,
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                              ),

                              //Type selection dropdown..
                              child: FindDropdown(
                                items: brands,
                                onChanged: (item) {
                                  print(item);
                                },
                                selectedItem: "Select Brand",
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(hintText: "Search", border: OutlineInputBorder()),
                                backgroundColor: Colors.white,
                                titleStyle: TextStyle(color: Colors.blue),
                                validate: (String? item) {
                                  if (item == null)
                                    return "Required field";
                                  else if (item == "Brasil")
                                    return "Invalid item";
                                  else
                                    return null;
                                },
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