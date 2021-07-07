import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/components/blue_painter.dart';


class LoginSystem extends StatefulWidget {
  bool _secureText = false;
  IconData icon = Icons.supervised_user_circle;
  @override
  _LoginSystemState createState() => _LoginSystemState();
}

class _LoginSystemState extends State<LoginSystem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget._secureText == false) {
      widget._secureText = true;
      widget.icon = Icons.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: CustomPaint(
        painter: BluePainter(),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.07),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white,
                      // border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.645,
                      // color: Colors.blueGrey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(05),
                              // color: Colors.cyanAccent,
                              width: double.infinity,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.033,
                                  MediaQuery.of(context).size.height *
                                      (40 / 692),
                                  MediaQuery.of(context).size.width * 0.033,
                                  MediaQuery.of(context).size.height * 0.0144),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "UserName or Email",
                                      labelText: "User Name",
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                    obscureText: false,
                                    onChanged: (val) {
                                      print(val);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (25 / 692),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          widget.icon,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget._secureText =
                                                !widget._secureText;
                                            if (widget._secureText == false) {
                                              widget.icon =
                                                  Icons.remove_red_eye_outlined;
                                            } else {
                                              widget.icon = Icons.password;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: widget._secureText,
                                    onChanged: (val) {
                                      print(val);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (25 / 692),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width *
                                      0.033),
                              child: InkWell(
                                splashColor: Colors.black,
                                child: Text(
                                  'Forget Password ?',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Kcolor,
                                  ),
                                ),
                                onTap: () {
                                  print('hello I tap');
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (15 / 692),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .5,
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*(12.5/692),horizontal:MediaQuery.of(context).size.width*(40/360)),
                                  color: Kcolor,
                                  onPressed: () {},
                                  child: Text(
                                    'Sign in',
                                    style: KbuttonSignin,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blue,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (10 / 692),
                            ),
                            Center(
                              child: Container(
                                child: Text("--------   OR REGISTER WITH   --------"),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (10 / 692),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove_red_eye_outlined),

                                Icon(Icons.remove_red_eye_outlined),

                                Icon(Icons.remove_red_eye_outlined),

                                Icon(Icons.remove_red_eye_outlined),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
