import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/chatScreen.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:reviewia/structures/postView.dart';

class ChatScreenPostCard extends StatefulWidget {
  late PostsView detail;
  ChatScreenPostCard({required this.detail});

  @override
  _ChatScreenPostCardState createState() => _ChatScreenPostCardState();
}

class _ChatScreenPostCardState extends State<ChatScreenPostCard> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ChatScreen(detail: widget.detail,userName:widget.email),
        //   ),
        // );
        print( widget.detail.createdBy);
      },
      child: Container(
       padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        height: MediaQuery.of(context).size.height * 105 / 659,
        width: MediaQuery.of(context).size.width * (700 / 765),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Image.network(
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
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.detail.title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 6,),
                          Row(
                            children: [
                              Text("Rating: "+widget.detail.rate.toString()),
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
                          SizedBox(height: 6,),
                          Text(
                            "Creator: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          SizedBox(height: 6,),
                          Text(
                            widget.detail.createdBy,
                          ),
                         // Text("Created date: "+widget.detail.createdAt.substring(0, 10),
                           // style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}
