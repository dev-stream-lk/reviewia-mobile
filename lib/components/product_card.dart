import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/screens/profile_page.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double rate = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
            Navigator.pushNamed(context, ProductView.id);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: EdgeInsets.only(bottom: 10, top: 10),
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
                          backgroundImage: AssetImage('images/pep.jpg'),
                          radius: MediaQuery.of(context).size.width * 22.58 / 360,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child:
                              Text("Chamari Wikrmawardna", style: KPostCard)),
                      Expanded(flex: 1, child: Icon(Icons.settings))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: Color(0xFFCCDCF3),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/product_one.jpg'),
                    fit: BoxFit.fill,
                  )),
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
                            "Product-1",
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
                              Text(rate.toString()),
                              SizedBox(
                                width: 10,
                              ),
                              RatingBar.builder(
                                initialRating: rate,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Kcolor,
                                ),
                                onRatingUpdate: (rating) {
                                 setState(() {
                                   rate= rating;
                                 });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
