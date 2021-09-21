// @dart = 2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/chatList.dart';
import 'package:reviewia/screens/chatScreen.dart';
import 'package:reviewia/screens/contactUs.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/screens/fogotPassword.dart';
import 'package:reviewia/screens/groupChat.dart';
import 'package:reviewia/screens/previewPage.dart';
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
import 'package:reviewia/screens/notification.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/services/userState.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int number=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reviewia',
      debugShowCheckedModeBanner: false,
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
        ProductView.id:(context)=>ProductView(),
        ServiceList.id:(context)=>ServiceList(),
        ContactUs.id :(context)=> ContactUs(),
        ForgotPassword.id :(context)=> ForgotPassword(),
        ChatList.id :(context)=> ChatList(),
        GroupChat.id :(context)=> GroupChat(),
        ProductList.id:(context)=> ProductList(),
        ServicesList.id:(context)=> ServicesList(),
        FavouriteList.id:(context)=> FavouriteList(),
        MyPost.id:(context)=> MyPost(),
        PreviewPost.id:(context)=> PreviewPost(),
        ChatScreen.id:(context)=> ChatScreen(),
        NotificationList.id:(context)=>NotificationList(),
      },

    );
  }
}


