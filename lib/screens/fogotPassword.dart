import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/components/blue_painter.dart';
import 'package:reviewia/components/button_logon.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/register_page.dart';
import 'package:reviewia/services/user.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/constrains/validation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'ForgotPassword';
  Color buttonPressed = Kcolor;
  bool _checkBox = false;
  bool _secureText = false;
  IconData icon = Icons.password;
  bool _secureTextConfirm = false;
  IconData iconConfirm = Icons.password;
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  double h = 0;
  double w = 0;
  String password = "";

  @override
  void initState() {
    // TODO: implement initState
    // h = MediaQuery.of(context).size.height;
    // w = MediaQuery.of(context).size.width;
    if (widget._secureText == false) {
      widget._secureText = true;
      widget.icon = Icons.password;
    }
    if (widget._secureTextConfirm == false) {
      widget._secureTextConfirm = true;
      widget.iconConfirm = Icons.password;
    }

    print(h);
  }
  Validation validateResetPassword = new Validation();

  buildLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }

  _resetPassword() async {
    buildLoading(context);
    String uN = await UserState().getUserName();
    String url = KBaseUrl + "api/registration/reset";
    var userDetails =await UserServices(url, uN.toString() ,password, "firstName", "lastName").passwordReset();
    print(userDetails.toString());
    if(userDetails == 500){
      int count = 0;
      Alert(
        context: context,
        type: AlertType.success,
        title: "Password Rest Success",
        desc: "Please Check your emails and confirm the password.",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okey",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).popUntil((_) => count++ >= 3);
            },
            width: MediaQuery.of(context).size.width * 100 / 360,
          ),
        ],
      ).show();
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
                  flex: 5,
                  child: Center(
                    child: ImageBox(),
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
                      height: MediaQuery.of(context).size.height * 0.4,
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
                                "Forgot Password?",
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
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (15 / 692),
                                  ),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //     hintText: "Email",
                                  //     labelText: "Email",
                                  //     labelStyle: TextStyle(
                                  //       fontSize: 12,
                                  //       color: Colors.black,
                                  //     ),
                                  //     hintStyle: TextStyle(
                                  //       fontSize: 15,
                                  //       color: Colors.black,
                                  //     ),
                                  //     border: OutlineInputBorder(),
                                  //     suffixIcon: Icon(
                                  //       FontAwesomeIcons.envelope,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ),
                                  //   obscureText: false,
                                  //   onChanged: (val) {
                                  //     print(val);
                                  //   },
                                  // ),

                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Type Your New Password to Reset",
                                      helperStyle: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.grey[100],
                                      ),
                                      labelText: "Reset Password",
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: validateResetPassword.validPasswordReg,
                                    obscureText: widget._secureText,
                                    onChanged: (val) {
                                      print("before "+ password);
                                      setState(() {
                                        password=val;
                                      });
                                      // print(val);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (15 / 692),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (15 / 692),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (0.25 / 692),
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
                                width: MediaQuery.of(context).size.width * .6,
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
                                    var result = validateResetPassword.validPasswordReg(password);
                                    if(result == null){
                                      _resetPassword();
                                    }
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return LoginSystem();
                                    //     }));
                                  },
                                  child: Text(
                                    'RESET PASSWORD',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
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
                                      "Back to ",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
