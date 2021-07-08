import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'add_post_page.dart';
import 'home_Page.dart';
import 'home_page_top_products.dart';

class ScreenSelector extends StatefulWidget {
  static const String id = 'screen_selector';

  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  int _currentIndex = 0;
  List<Widget> _screenContainer = [
    HomePage(),
    AddPost(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.home,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.note_add,
                    color: Colors.white,
                  ),
                  label: "Add Post"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                  label: "Profile"),
            ],
            backgroundColor: Kcolor,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
          body: IndexedStack(index: _currentIndex, children: _screenContainer)),
    );
  }
}