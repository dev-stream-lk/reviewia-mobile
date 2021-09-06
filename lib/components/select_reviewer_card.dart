import 'package:flutter/material.dart';
class SelectReviewerCard extends StatefulWidget {
  late String reviewerName;
  late String reviewerEmail;
  late bool isSelected;
  SelectReviewerCard({required this.reviewerName,required this.reviewerEmail,required this.isSelected});

  @override
  _SelectReviewerCardState createState() => _SelectReviewerCardState();
}

class _SelectReviewerCardState extends State<SelectReviewerCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget.reviewerName,
        ),
    );
  }
}
