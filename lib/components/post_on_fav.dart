import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/structures/postView.dart';

class PostOnFav extends StatefulWidget {
  late PostsView detail;
 PostOnFav({required this.detail});

  @override
  _PostOnFavState createState() => _PostOnFavState();
}

class _PostOnFavState extends State<PostOnFav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
      height: MediaQuery.of(context).size.height * 105 / 659,
      decoration: BoxDecoration(
        color: Color(0xFFAAAAAA),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex:3,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 15 / 360,bottom:MediaQuery.of(context).size.width * 15 / 360,right: MediaQuery.of(context).size.width * 15 / 360,left:MediaQuery.of(context).size.width * 15 / 360,),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/product_one.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Colors.white,
              ) ,
            ),
          ),
          Expanded(
              flex:4,
              child: Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex:2,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 15/692),
                          width: double.infinity,
                          // color: Colors.orange,
                          child: Text(widget.detail.title,style: KPostCard,),
                        ),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        // color: Colors.white,
                        // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 25/692 ),
                        child: Row(
                          children: [
                            Text(widget.detail.rate.toString()),
                            RatingBar.builder(
                              initialRating: widget.detail.rate,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: MediaQuery.of(context).size.width*10/360,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Kcolor,
                              ),
                              onRatingUpdate: (rating) {

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*18/692),
                        child: Text("2021-07-05",style: TextStyle(
                          fontSize: 10,
                        ),textAlign:TextAlign.left,),
                        // color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  flex: 2,
                  child: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (item) => {print(item)},
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )),

            ],
          ),

        ],
      ),

    );
  }
}
