import 'package:flutter/material.dart';

class SelectionCard extends StatefulWidget {
  String title;
  SelectionCard({required this.title});
  @override
  _SelectionCardState createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.height*0.165,
      child: Text(widget.title,style: TextStyle(color: Colors.black),),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.020),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),

    );
  }
}
