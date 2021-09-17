import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/screens/testPage.dart';

const Kcolor = Color(0xFF15317E);
const KBoxColor =Colors.grey;
const KReviewiaTitle = TextStyle(
  fontFamily: "Roboto",
  fontSize: 48,
  fontWeight: FontWeight.w800,
  color: Color(0xFFFFFFFF),
);
const KReviewiaMostTitle = TextStyle(
  fontFamily: "Roboto",
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);
const  KPostCard = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  color: Colors.black,
);
const  KPostReviewCard = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w300,
  fontFamily: 'Roboto',
  color: Colors.black,
);


const  KbuttonSignin = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  color: Colors.white,
);

const KdrawerTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontFamily: 'Roboto',
  color: Colors.black,
);

const KappTitle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  fontFamily: 'Roboto',
  color: Colors.white,
);

const KbottomNav = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  fontFamily: 'Roboto',
  color: Colors.white,
);

const KBoxDeco = BoxDecoration(
  // color: Colors.cyan,
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(5)),
  boxShadow: [
    KBoxShadow
  ],
);

const KBoxShadow = BoxShadow(
  color: KBoxColor,
  spreadRadius: 5,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);

List<Widget> KscreenContainer = [
  HomePage(),
  TestAddPost(),
  ProfilePage(),
];
const Color KDetailColor = Color(0xFF020902);
const double KOpacityOnDetail = 0.5;
var kNotificationNumber=0;

const Color KSelectedFeedback = Color(0xFFE3F2FD);
