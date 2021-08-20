import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/components/blue_painter.dart';
import 'package:reviewia/components/button_logon.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/register_page.dart';


class Login extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double h = 0;
  double w = 0;
  @override
  void initState() {
    // TODO: implement initState

    // h = MediaQuery.of(context).size.height;
    // w = MediaQuery.of(context).size.width;
    super.initState();
    print(h);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BluePainter(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(

                      child: Text(
                        "Reviewia",
                        style: KReviewiaTitle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ImageBox(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin:EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:3,
                          child: ButtonLogon(title:"Register", page:Register(),),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 5,
                          ),
                        ),
                        Expanded(
                          flex:3,
                          child: ButtonLogon(title:"Login", page: LoginSystem(),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
