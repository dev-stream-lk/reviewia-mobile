
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/add_post_page2.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

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

  //for type selection..
  final typeSelected = TextEditingController();
  String selectType = "";

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

                // Button next....
                Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    margin: EdgeInsets.only(top: 20 ,left: 2, right: 2, bottom: 10),

                    child: RaisedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPost2()),
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
        ),
      ),
    );



  }
}
