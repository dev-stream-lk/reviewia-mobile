import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';

class ProductViewCard extends StatefulWidget {
  late String createdBy;
  late String title;
  late String description;
  late double rating;
  late String photoUrl1;
  ProductViewCard({required this.createdBy,required this.title, required this.description, required this.rating,required this.photoUrl1});

  @override
  _ProductViewCardState createState() => _ProductViewCardState();
}

class _ProductViewCardState extends State<ProductViewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        // color: Colors.cyan,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFEFE),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),

              // color:Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFC494C4),
                      backgroundImage: AssetImage('images/User_Avatar.png'),
                      radius: MediaQuery.of(context).size.width * 22.58 / 360,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Text(widget.createdBy, style: KPostCard)),
                  Expanded(
                      flex: 1,
                      child: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        onSelected: (item) => {print(item)},
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text(
                              "Report",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Add Favorite",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // color: Color(0xFFCCDCF3),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage('images/product_one.jpg'),
              //   fit: BoxFit.fill,
              // )),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  widget.photoUrl1,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:
                  EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
              decoration: BoxDecoration(
                // color: Color(0xFFAAAAAA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1A6CD3),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: [
                          Text(widget.rating.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          RatingBar.builder(
                            initialRating: widget.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Kcolor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.centerLeft,
                padding:
                    EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sub Category: " + widget.title,
                    ),
                    Text(
                      "Year",
                    ),
                    Text(
                      "Description: " + widget.description,
                    ),
                    Text(
                      "Year",
                    ),
                    Text(
                      "Year",
                    ),
                    Text(
                      "Year",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
