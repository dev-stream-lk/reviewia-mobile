import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/favourite_list.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/structures/postView.dart';

class MyPostComp extends StatefulWidget {
  late PostsView detail;
  MyPostComp({required this.detail});

  @override
  _MyPostCompState createState() => _MyPostCompState();
}

class _MyPostCompState extends State<MyPostComp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductView(todos: widget.detail),
          ),
        );
        // Navigator.pushNamed(context, ProductView.id);
      },
      child: Container(
        // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
        height: MediaQuery.of(context).size.height * 150 / 659,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 15 / 360,
                  bottom: MediaQuery.of(context).size.width * 15 / 360,
                  right: MediaQuery.of(context).size.width * 15 / 360,
                  left: MediaQuery.of(context).size.width * 15 / 360,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Image.network(
                    widget.detail.imgURL.isNotEmpty
                        ? widget.detail.imgURL[0].url.toString()
                        : "https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
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
                flex: 4,
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    15 /
                                    692),
                            width: double.infinity,
                            // color: Colors.orange,
                            child: Text(
                              widget.detail.title,
                              style: KPostCard,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
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
                                itemSize: MediaQuery.of(context).size.width *
                                    10 /
                                    360,
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 3.0),
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*18/692),
                          child: Text(
                            "Created date: " +
                                widget.detail.createdAt.substring(0, 10),
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          // color: Colors.yellow,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                           margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*1/692),
                          child: Text(
                            "Sub Category: " +
                                widget.detail.subCategory.substring(0, 10),
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          // color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 2,
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (item) {
                        selectedOption(
                            item.toString(), widget.detail.postId, context);
                        print(item);

                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 3,
                          child: Text(
                            "Request to delete",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
