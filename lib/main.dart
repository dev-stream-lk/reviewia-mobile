// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:reviewia/screens/add_post_page2.dart';
import 'package:reviewia/screens/add_post_page3.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/contactUs.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/screens/fogotPassword.dart';
import 'package:reviewia/screens/groupChat.dart';
import 'package:reviewia/screens/product_list.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/screens/search_page.dart';
import 'package:reviewia/screens/addPost_1.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/login_page.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/register_page.dart';
import 'package:reviewia/screens/screen_selector.dart';
import 'package:reviewia/screens/service_list.dart';
import 'package:reviewia/screens/servicesList.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        accentColor: Color(0xFFFFFFFF),
        appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF1A6CD3)
        )
      ),
      // home: Login(),
      initialRoute: Login.id,
      routes:{
        Login.id:(context)=> Login(),
        Register.id:(context)=> Register(),
        LoginSystem.id:(context)=> LoginSystem(),
        SearchPage.id:(context)=>SearchPage(),
        HomePage.id :(context)=>ScreenSelector(),
        AddPost2.id :(context)=>AddPost2(),
        AddPost3.id :(context)=>AddPost3(),
        ProductView.id:(context)=>ProductView(),
        ServiceList.id:(context)=>ServiceList(),
        ContactUs.id :(context)=> ContactUs(),
        ForgotPassword.id :(context)=> ForgotPassword(),
        ChatList.id :(context)=> ChatList(),
        GroupChat.id :(context)=> GroupChat(),
        ProductList.id:(context)=> ProductList(),
        ServicesList.id:(context)=> ServicesList(),
        FavouriteList.id:(context)=> FavouriteList(),
      },

    );
  }
}

