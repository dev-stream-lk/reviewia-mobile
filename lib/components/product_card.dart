import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/components/loading.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/screens/login_system_page.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/screens/profile_page.dart';
import 'package:reviewia/services/postView.dart';

class ProductCard extends StatefulWidget {

  final String title;
  late PostsView detail;
  late String photoUrl1;
  ProductCard({required this.title, required this.detail,required this.photoUrl1});


  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // double rate = widget.detail.rate;
  var t;
  @override
  void initState() {
    super.initState();
  }


  Future<Uint8List> LoadImage()async{
    final ByteData imageData = await NetworkAssetBundle(Uri.parse("https://www.humtechke.com/wp-content/uploads/2021/05/Samsung-Galaxy-F52-5G-600x521.jpg")).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();
    return bytes;
  }

  loading(BuildContext context, Widget child,ImageChunkEvent loadingProgress){

    var one = int.parse(loadingProgress.expectedTotalBytes.toString());
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null ?
        loadingProgress.cumulativeBytesLoaded / one : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductView( todos:widget.detail),
            ),
          );
          // Navigator.pushNamed(context, ProductView.id);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.62,
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
                          backgroundImage: AssetImage('images/User_Avatar.png'),
                          radius:
                              MediaQuery.of(context).size.width * 22.58 / 360,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child:
                              Text("Chamari Wikrmawardna", style: KPostCard)),
                      Expanded(
                          flex: 1,
                          child: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            onSelected: (item) => {print(item)},
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Text(
                                  "Report",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                  // color: Color(0xFFCCDCF3),
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       // image:Image.memory(),
                  //   image: AssetImage('images/image_one.jpg'),
                  //   //     image: Image.network("https://www.humtechke.com/wp-content/uploads/2021/05/Samsung-Galaxy-F52-5G-600x521.jpg"),
                  //   fit: BoxFit.fill,
                  // )),
                  child:DecoratedBox(
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
                            widget.title.toString(),
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
                              Text(widget.detail.rate.toString()),
                              SizedBox(
                                width: 10,
                              ),
                              RatingBar.builder(
                                initialRating: widget.detail.rate,
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
