import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/product_view_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/profile_page.dart';

import 'add_post_page.dart';
import 'home_Page.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);
  static String id = "ProductView";

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text("Prodict View"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductViewCard(),
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}


