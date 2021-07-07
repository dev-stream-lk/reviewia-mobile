import 'package:flutter/material.dart';
import 'package:reviewia/screens/login_page.dart';


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
      home: Login(),
    );
  }
}

