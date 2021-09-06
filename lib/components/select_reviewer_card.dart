import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/structures/reviewStruct.dart';
class SelectReviewerCard extends StatefulWidget {
  late String reviewerName;
  late String reviewerEmail;
  late bool isSelected;
  final ValueChanged onSelectedReviewer;
  SelectReviewerCard({required this.reviewerName,required this.reviewerEmail,required this.isSelected, required this.onSelectedReviewer});

  @override
  _SelectReviewerCardState createState() => _SelectReviewerCardState();
}

class _SelectReviewerCardState extends State<SelectReviewerCard> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap:()=> widget.onSelectedReviewer(widget.reviewerEmail),
        title: Text(
          widget.reviewerName,
          style: widget.isSelected? TextStyle(
            fontWeight: FontWeight.bold,
            color: Kcolor,
          ):TextStyle(fontWeight: FontWeight.normal),
        ),
      trailing: widget.isSelected?Icon(Icons.check,color: Kcolor):null ,
    );
  }
}
