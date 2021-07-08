import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/addPost_1.dart';
import 'package:reviewia/screens/add_post_page.dart';
import 'package:reviewia/screens/home_page_top_products.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/register_page.dart';

import '../home_data.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  int _currntIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as HomeData;
    print(arguments.title);
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
          "Reveiwia",
          style: KappTitle,
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: new Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFCCDCF3),
                ),
                child: Text(
                  'Categories',
                  style: KdrawerTextStyle,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
// height: MediaQuery.of(context).size.height * 0.0925,
// color: Kcolor,
// width: double.infinity,
// child: Row(
// children: [
// Expanded(
// flex: 1,
// child: Container(
// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// IconButton(
// color: Colors.white,
// iconSize: 20,
// padding: EdgeInsets.all(2),
// icon:Icon(FontAwesomeIcons.home),
// onPressed: () {  } ,
// ),
// Text("Home",style: TextStyle(
// fontSize: 12,
// color: Colors.white,
// ),)
// ],
// ),
// ),
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.yellow,
// ),
// ),
// Expanded(
// flex: 1,
// child: Container(
// color: Colors.blueGrey,
// child: IconButton(
// icon:Icon(FontAwesomeIcons.home),
// onPressed: () {  } ,
// ),
// ),
// )
// ],
// ),
// ),
