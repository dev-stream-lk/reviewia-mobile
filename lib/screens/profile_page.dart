import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/components/form_feild.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/contactUs.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/login_page.dart';
import 'package:reviewia/screens/search_page.dart';
import 'package:reviewia/services/user.dart';
import 'package:reviewia/services/userState.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../home_data.dart';

class ProfilePage extends StatefulWidget {
  bool _canEdit = true;

  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  // UserState userState = new UserState();
  String email = '';

  String realDevice = "http://192.168.8.101:8080/api/user?email=";
  String realDeviceUpdateProfile = "http://192.168.8.101:8080/api/registration/update?email=";
  String mobileEmu = "http://10.0.2.2:8080/api/user?email=";
  String emuDeviceUpdateProfile ="http://10.0.2.2:8080/api/registration/update?email=";
  String url = KBaseUrl+"api/user?email=";
  String urlUpdate = KBaseUrl+"api/registration/update?email=";

  String firstName = '';
  String lasteName ='';
  String urlReal ='';
  String urlEmu='';
  // String updateProfileUrl=realDeviceUpdateProfile;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) =>getUser();
    // getUser ();
    SchedulerBinding.instance!.addPostFrameCallback((_) => getUser());

  }
  void getUser () async {
    String emailit = (await UserState().getUserName());
    print("your email is = "+ emailit.toString());
    urlReal = realDevice+emailit;
    urlEmu =mobileEmu+emailit;
    url = url+emailit;

    var userDetails =await UserServices(url, "email"," password", "firstName", "lastName").getUserDetails();
    String  _firstName = userDetails['firstName'];
    String  _lastName = userDetails['lastName'];
    String displayName = await UserState().setStateDisplayName(_firstName+" "+_lastName);
    print(displayName);
    // print("userDetails:  "+ n);
    setState(() {
      email = emailit;
      firstName=_firstName;
      lasteName =_lastName;
    });


    // UserServices us = UserServices("http://localhost:8080/api/user?email=d@gmail.com", "email"," password", "firstName", "lastName");

  }

  void getValueName(String va) {
    firstName = va;
  }

  void getValuePassword(String va) {

     }

  void getLastName(String va){
    lasteName= va;
  }

  @override
  Widget build(BuildContext context) {
    // getUser ();
    print("build it ");
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Kcolor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Profile",
          style: KappTitle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.id);
              },
              icon: Icon(Icons.search)),
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: new Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,

                child: DrawerHeader(

                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: Column(

                        children: [
                          Text('Search for..',
                            style: TextStyle(
                              color: Kcolor,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),

                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          FindDropdown(
                            items: type,
                            onChanged: (item) {
                              print(item);
                            },
                            selectedItem: "Select type",
                            showSearchBox: false,
                            searchBoxDecoration: InputDecoration(
                                hintText: "Search",
                                border: OutlineInputBorder()),
                            backgroundColor: Colors.white,
                            validate: (String? item) {
                              if (item == null)
                                return "Required field";
                              else if (item == "Brasil")
                                return "Invalid item";
                              else
                                return null;
                            },
                          ),
                          FindDropdown(
                            items: category,
                            onChanged: (item) {
                              print(item);
                            },
                            selectedItem: "Select category",
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                                hintText: "Search",
                                border: OutlineInputBorder()),
                            backgroundColor: Colors.white,
                            validate: (String? item) {
                              if (item == null)
                                return "Required field";
                              else if (item == "Brasil")
                                return "Invalid item";
                              else
                                return null;
                            },
                          ),
                          FindDropdown(
                            items: brands,
                            onChanged: (item) {
                              print(item);
                            },
                            selectedItem: "Select brand",
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                                hintText: "Search",
                                border: OutlineInputBorder()),
                            backgroundColor: Colors.white,
                            validate: (String? item) {
                              if (item == null)
                                return "Required field";
                              else if (item == "Brasil")
                                return "Invalid item";
                              else
                                return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFCCDCF3),
                    ),
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0)
                ),
              ),

              Divider(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Kcolor,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),

                ),
                onTap: () {
                  Navigator.pushNamed(context, ContactUs.id);
                },
              ),
              Divider(height: MediaQuery.of(context).size.height * 0.02),

              ListTile(
                title: Text(
                  'My Groups',
                  style: TextStyle(
                    color: Kcolor,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),

                ),
                onTap: () {
                  Navigator.pushNamed(context, ChatList.id);
                },
              ),
              Divider(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Kcolor,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),

                ),
                onTap: () {
                  Navigator.pushNamed(context, Login.id);
                },
              ),
              Divider(height: MediaQuery.of(context).size.height * 0.02),

            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          margin: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            // color: Colors.cyan,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 200 / 659,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFC494C4),
                      backgroundImage: AssetImage('images/profile.png'),
                      radius: MediaQuery.of(context).size.width * 79 / 360,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 200 / 659,
                  // color: Colors.blue,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FormFeild(
                            name: firstName,
                            type: "First Name",
                            onChanged: getValueName),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 10 / 659,
                        ),
                        FormFeild(
                            name: lasteName,
                            type: "Last Name",
                            onChanged: getLastName ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 10 / 659,
                        ),
                        // FormFeild(
                        //     name: "********",
                        //     type: "Password",
                        //     onChanged: getValuePassword),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 10 / 659,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            var updatedUrlReal = realDeviceUpdateProfile+email+"&first="+firstName+"&last="+lasteName;
                            var updatedUrlEmu = emuDeviceUpdateProfile+email+"&first="+firstName+"&last="+lasteName;
                            var updatedUrl = urlUpdate+email+"&first="+firstName+"&last="+lasteName;
                            print(updatedUrlReal);
                             print(updatedUrlEmu);
                            var userDetails =await UserServices(updatedUrl, "email"," ", firstName, lasteName).updatedProfile();
                            if(userDetails.toString()=="Updated completd"){
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Profile is Updated",
                                desc: "First Name and Last Name Updated",
                                buttons: [
                                  DialogButton(
                                    color: Kcolor,
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pushNamed(context, HomePage.id,arguments:HomeData(email)),
                                    width: MediaQuery.of(context).size.width*100/360,
                                  )
                                ],
                              ).show();
                            }else{
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Problem in Updating",
                                buttons: [
                                  DialogButton(
                                    color: Kcolor,
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: MediaQuery.of(context).size.width*100/360,
                                  )
                                ],
                              ).show();
                            }



                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) => super.widget));
                            // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ProfilePage()));
                            // Navigator.pushNamed(context, HomePage.id,arguments:HomeData(email.toString()));
                          },
                          color: Kcolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child:Container(
                            width: MediaQuery.of(context).size.width*80/360,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'update',
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
                            ),
                          ) ,

                        )


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



String onChanged(val) {
  print(val);
  return (val);
}
