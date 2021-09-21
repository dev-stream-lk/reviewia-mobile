import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/blue_painter.dart';
import 'package:reviewia/components/loading.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/constrains/validation.dart';
import 'package:reviewia/home_data.dart';
import 'package:reviewia/screens/home_Page.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/services/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dart_ipify/dart_ipify.dart';


import 'login_page.dart';

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
  String firstName="";
  String lastName="";
  String password ='';
  String email = '';
  bool loading = false;

  String mobileEmu = "http://10.0.2.2:8080/api/registration";
  String url = KBaseUrl+"api/registration";
  // String realDevice = "http://192.168.8.101:8080/api/registration";

  // String realDevice = "http://192.168.8.100:8080/api/registration";

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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Validation validateRegForm = new Validation();

  Future<void>  getIP()async{
    final ipv4 = await Ipify.ipv4();
    print(ipv4);
  }

  Future<void> register() async {
    // getIP();
    UserServices user = UserServices(url, email, password, firstName,lastName, '');
    var userLogin = await user.getRegister();
    // print("your user name is ="+ userName);
    // print("your user password is ="+ passWord);
    print(userLogin);

    if(userLogin == "Account is Created"){
      setState(() {
        loading = false;
      });
      Alert(
        context: context,
        type: AlertType.success,
        title: "Account Created",
        desc: "Verification link is sent to your email",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return LoginSystem();
                })),
            width: MediaQuery.of(context).size.width*100/360,
          )
        ],
      ).show();

    }else{
      print("cant Login");
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Account cannot be created",
        desc: "A similar account already exists",
        buttons: [
          DialogButton(
            color: Kcolor,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return LoginSystem();
                })),
            width: MediaQuery.of(context).size.width*100/360,
          )
        ],
      ).show();
    }

  }

  void validate(){
    if(formKey.currentState!.validate()){

      register();
    }else{
      print('Not Validate');
    }
  }




  String? validatePasswordSame(value){
    print(value.toString()+" its is passwrd"+ password);
    if(value!.isEmpty){
      return "Required Field";
    }else if(value.toString()!=password){
      return "Passwords Not match";
    }else{
      return null;
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
                  child: Form(
                    key: formKey,
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
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        labelText: "First Name",
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateRegForm.validateName,
                                      obscureText: false,
                                      onChanged: (val) {
                                        setState(() {
                                            firstName = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          (15 / 692),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Last Name",
                                        labelText: "Last Name",
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateRegForm.validateName,
                                      obscureText: false,
                                      onChanged: (val) {
                                        setState(() {
                                            lastName = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          (15 / 692),
                                    ),
                                    TextFormField(
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateRegForm.validateEmail,
                                      obscureText: false,
                                      onChanged: (val) {
                                        setState(() {
                                            email=val;
                                        });
                                      },

                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          (15 / 692),
                                    ),
                                    TextFormField(
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validateRegForm.validPasswordReg,
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
                                    TextFormField(
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
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: validatePasswordSame ,
                                      obscureText: widget._secureTextConfirm,
                                      onChanged: (val) {
                                        print("before "+ password);
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
                                      child: widget._checkBox?Text(
                                        "I Read and Agree To",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                        ),
                                      ):Text(
                                        "I Read and Agree To",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.red,
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
                              loading ? Loading():Center(
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
                                      setState(() {
                                        loading = true;
                                      });
                                      validate();
                                      // if(formKey.currentState!.validate()){
                                      //   if(widget._checkBox==true){
                                      //     Navigator.push(context,
                                      //         MaterialPageRoute(builder: (context) {
                                      //           return LoginSystem();
                                      //         }));
                                      //   }
                                      //
                                      // }else{
                                      //   print('Not Validate');
                                      // }



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
