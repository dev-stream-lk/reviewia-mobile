import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reviewia/Constrains/constrains.dart';
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
    if(widget._secureText==false){
      widget._secureText=true;
      widget.icon = Icons.password;
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
                      padding:EdgeInsets.all(MediaQuery.of(context).size.width*0.07),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20) ),
                        color: Colors.white,
                          // border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.645,
                        // color: Colors.blueGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(05),
                              // color: Colors.cyanAccent,
                              width: double.infinity,
                              child: Text("Sign In",style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "User Name",
                                      labelText: "User Name",
                                      labelStyle: TextStyle(
                                        fontSize: 12,color:Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15,color:Colors.black,
                                      ),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.supervised_user_circle,color: Colors.black,),
                                    ),
                                    obscureText: false,
                                    onChanged: (val){
                                      print(val);
                                      },
                                  ),
                                  SizedBox(
                                    height: 25 ,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        fontSize: 12,color:Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15,color:Colors.black,
                                      ),
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(widget.icon), onPressed: () {
                                          setState(() {
                                            widget._secureText = ! widget._secureText;
                                            if(widget._secureText==false){
                                              widget.icon = Icons.remove_red_eye_outlined;
                                            }else{
                                              widget.icon = Icons.password;
                                            }

                                          });
                                      },
                                      ),
                                    ),
                                    obscureText: widget._secureText,
                                    onChanged: (val){
                                      print(val);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
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
