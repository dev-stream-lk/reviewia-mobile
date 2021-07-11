import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/components/blue_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/validation.dart';
import 'package:reviewia/home_data.dart';
import 'package:reviewia/screens/fogotPassword.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/register_page.dart';
import 'package:reviewia/services/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginSystem extends StatefulWidget {
  static String id  = 'login_system_page';
  bool _secureText = false;
  IconData icon =Icons.password;
  @override
  _LoginSystemState createState() => _LoginSystemState();
}

class _LoginSystemState extends State<LoginSystem> {
  String userName='' ;
  String passWord='';
  String mobileEmu = "http://10.0.2.2:8080/api/login";
  String realDevice = "http://192.168.8.102:8080/api/login";
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  Validation validateForm = new Validation();


  Future<void> login() async {
    UserServices user = UserServices(realDevice, userName, passWord, "","");
    var userLogin = await user.getLogin();
    // print("your user name is ="+ userName);
    // print("your user password is ="+ passWord);
    print(userLogin);
    if(userLogin == "Can Login"){
      Navigator.pushNamed(context, HomePage.id,arguments:HomeData(userName));
    }else{
      print("cant Login");
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Problem in Login",
        desc: "Username or Password is incorrect",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: MediaQuery.of(context).size.width*100/360,
          )
        ],
      ).show();


    }

  }



  void validate(){
    if(formKey.currentState!.validate()){

      login();



    }else{
      print('Not Validate');
    }
  }

  // String? validateUserName(value){
  //   if(value!.isEmpty){
  //     return "Required Field";
  //   }else{
  //     return null;
  //   }
  // }

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
                              // padding: EdgeInsets.all(05),
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
                            Form(
                              key: formKey,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.033,
                                    MediaQuery.of(context).size.height *
                                        (30 / 692),
                                    MediaQuery.of(context).size.width * 0.033,
                                    MediaQuery.of(context).size.height * 0.0144),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateForm.validateUserName,
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
                                          Icons.supervised_user_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                      obscureText: false,
                                      onChanged: (val) {
                                        setState(() {
                                          userName=val.toString();
                                        });
                                        print(val);
                                      },

                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          (15 / 692),
                                    ),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateForm.validatePassword,
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
                                        setState(() {
                                          passWord=val.toString();
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          (15 / 692),
                                    ),
                                  ],
                                ),
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
                                  Navigator.pushNamed(context, ForgotPassword.id);
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
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              (12.5 / 692),
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              (40 / 360)),
                                  color: Kcolor,
                                  onPressed: validate ,
                                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                                    //   return HomePage();
                                    // } ));
                                    // print(formKey.currentState.toString());


                                    // Navigator.pushNamed(context, HomePage.id,arguments:HomeData('damish'));


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
                                child: Text(
                                    "-----------------   OR REGISTER WITH   -----------------",style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                ),),
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
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.facebookF,color: Kcolor,),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.google,color: Kcolor,),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.twitter,color: Kcolor,),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.linkedin,color: Kcolor,),
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
                                      "Don't Have a An Account?",style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                    ),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width *
                                            0.033),
                                    child: InkWell(
                                      splashColor: Colors.black,
                                      child: Text(
                                        'Register',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Kcolor,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return Register();
                                        } ));
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
