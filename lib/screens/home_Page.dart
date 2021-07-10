import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/screens/contactUs.dart';
import 'package:reviewia/screens/login_page.dart';
import 'package:reviewia/screens/search_page.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/addPost_1.dart';
import 'package:reviewia/screens/add_post_page.dart';
import 'package:reviewia/screens/add_post_page2.dart';
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
      body: HomePageTopProducts(),
    );
  }
}

