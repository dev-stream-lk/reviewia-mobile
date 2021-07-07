import 'package:flutter/material.dart';


class ButtonLogon extends StatefulWidget {
  final String title;
  final Widget page;
  ButtonLogon({required this.title,required this.page});
  @override
  _ButtonLogonState createState() => _ButtonLogonState();
}

class _ButtonLogonState extends State<ButtonLogon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.70,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return widget.page;
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF1A6CD3),
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
        ),
        child: Text(widget.title,style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),),
      ),
    );
  }
}
