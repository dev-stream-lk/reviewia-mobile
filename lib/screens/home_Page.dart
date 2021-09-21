import 'dart:async';

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/contactUs.dart';
import 'package:reviewia/screens/login_page.dart';
import 'package:reviewia/screens/notification.dart';
import 'package:reviewia/screens/search_page.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/home_page_top_products.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/register_page.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/services/user.dart';
import 'package:reviewia/services/userState.dart';
import 'package:badges/badges.dart';

import '../home_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  int _currntIndex = 0;
  String appBarTitle = 'Reviewia';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserState userState = new UserState();
  String userName = '';
  String k = '';
  String displayname = '';
  String avatar = '';

  void settheUserProfile(String s, String t) async {
    k = await userState.setStateUserName(s, t);
    print(k);
  }

  _getUserData() async {
    String emailit = (await UserState().getUserName());
    String url = KBaseUrl+"api/user?email="+emailit;
    var uN = await UserState().getUserName();
    var displayName = await UserState().getDisplayName();
    var userDetails =await UserServices(url, "email"," password", "firstName", "lastName","avatar").getUserDetails();
    String _avatar = userDetails['avatar'];
    setState(() {
      userName = uN.toString();
      displayname = displayName.toString();
      avatar = _avatar;
    });

  }


  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as HomeData;
    print("user name is saved " + arguments.title);
    print("user name is now get" + userState.getUserName().toString());

    // setState(() {
    //   settheUserProfile(arguments.title.toString());
    // });
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
          "Reviewia",
          style: KappTitle,
        ),
        actions: [
          NotificationBell(),
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
                height: MediaQuery.of(context).size.height * 0.25,
                child: UserAccountsDrawerHeader(
                  accountName: Text(""),
                  accountEmail: Text(userName,style: TextStyle(fontSize: 20),),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        avatar,
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 120.0,
                      ),
                    ),
                  ),
                ),
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
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, ChatList.id);
                },
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
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
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
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                  settheUserProfile('', '');
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

class NotificationBell extends StatefulWidget {
  const NotificationBell({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationBellState createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10), (Timer t) => getNewNotification());
  }

  getNewNotification() async {
    String userName = await UserState().getUserName();
    if (userName.isNotEmpty) {
      var dd = await getNumberOfNotification(userName);
      setState(() {
        kNotificationNumber = int.parse(dd.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, NotificationList.id);
      },
      icon: Badge(
        shape: BadgeShape.circle,
        borderRadius: BorderRadius.circular(50),
        child: Icon(Icons.notifications_active),
        badgeContent: Container(
          child: Text(
            kNotificationNumber.toString(),
            style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 8.5,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
