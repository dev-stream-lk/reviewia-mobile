import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';

class PostsOnProfile extends StatelessWidget {
  const PostsOnProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
      height: MediaQuery.of(context).size.height * 95 / 659,
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
                          child: Text("Prdouct-01",style: KPostCard,),
                        ),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        // color: Colors.white,
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 25/692 ),
                        child: Row(
                          children: [
                            Text('3.5'),
                            RatingBar.builder(
                              initialRating: 4.5,
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
                  ],
                ),
              )
          ),
          Expanded(
            flex:2,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*18/692),
              child: Text("2021-07-05",style: TextStyle(
                fontSize: 10,
              ),),
              // color: Colors.yellow,
            ),
          ),
        ],
      ),

    );
  }
}