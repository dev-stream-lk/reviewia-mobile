import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/blue_painter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/home_data.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/login_system_page.dart';

class Register extends StatefulWidget {
  static String id = 'register_page';
  Color buttonPressed = Kcolor;
  bool _checkBox = false;
  bool _secureText = false;
  IconData icon = Icons.password;

  bool _secureTextConfirm = false;
  IconData iconConfirm = Icons.password;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget._secureText == false) {
      widget._secureText = true;
      widget.icon = Icons.password;
    }
    if (widget._secureTextConfirm == false) {
      widget._secureTextConfirm = true;
      widget.iconConfirm = Icons.password;
    }
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
                              // padding: EdgeInsets.all(05),
                              // color: Colors.cyanAccent,
                              width: double.infinity,
                              child: Text(
                                "Create New Account",
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
                                      (20 / 692),
                                  MediaQuery.of(context).size.width * 0.033,
                                  MediaQuery.of(context).size.height * 0.0144),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      labelText: "Name",
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
                                        FontAwesomeIcons.user,
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
                                        (15 / 692),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      labelText: "Email",
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
                                        FontAwesomeIcons.envelope,
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
                                        (15 / 692),
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
                                        (15 / 692),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      labelText: "Confirm Password",
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
                                          widget.iconConfirm,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget._secureTextConfirm =
                                                !widget._secureTextConfirm;
                                            if (widget._secureTextConfirm ==
                                                false) {
                                              widget.iconConfirm =
                                                  Icons.remove_red_eye_outlined;
                                            } else {
                                              widget.iconConfirm =
                                                  Icons.password;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: widget._secureTextConfirm,
                                    onChanged: (val) {
                                      print(val);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (0.25 / 692),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: widget._checkBox,
                                      onChanged: (value) {
                                        setState(() {
                                          widget._checkBox = value!;
                                          print(widget._checkBox);
                                        });
                                      },checkColor: Colors.white,
                                    activeColor:Kcolor,
                                  ),
                                  Container(
                                    child: Text(
                                      "I Read and Agree To",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right:
                                        MediaQuery.of(context).size.width *
                                            0.033),
                                    child: InkWell(
                                      splashColor: Colors.black,
                                      child: Text(
                                        'Terms & Conditions',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Kcolor,
                                        ),
                                      ),
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                                        //   return Register();
                                        // } ));
                                        Navigator.pushNamed(
                                            context, HomePage.id,arguments: HomeData('damish'));
                                      },
                                    ),
                                  ),
                                ],
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
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              (12.5 / 692),
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              (40 / 360)),
                                  color: Kcolor,
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginSystem();
                                    }));
                                  },
                                  child: Text(
                                    'Register',
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
                                child: Text(
                                  "-----------------   OR REGISTER WITH   -----------------",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (10 / 692),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.buttonPressed = Colors.black;
                                    });
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: widget.buttonPressed,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.google,
                                    color: Kcolor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.twitter,
                                    color: Kcolor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.linkedin,
                                    color: Kcolor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (10 / 692),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "Do you Have a An Account?",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.033),
                                    child: InkWell(
                                      splashColor: Colors.black,
                                      child: Text(
                                        'Sign In',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Kcolor,
                                        ),
                                      ),
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                                        //   return Register();
                                        // } ));
                                        Navigator.pushNamed(
                                            context, LoginSystem.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
