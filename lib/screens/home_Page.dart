import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/screens/search_page.dart';
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
  String appBarTitle = 'Reviewia';

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
      body: HomePageTopProducts(),
    );
  }
}

