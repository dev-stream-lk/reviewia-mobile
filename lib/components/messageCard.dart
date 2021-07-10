import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
class MessageCards extends StatelessWidget {
  const MessageCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.275,
      margin:
      EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      // padding:EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: KBoxDeco,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFC494C4),
                    backgroundImage: AssetImage('images/pep.jpg'),
                    radius: MediaQuery.of(context).size.width *
                        22.58 /
                        360,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text("Chamari Wikrmawardna",
                        style: KPostCard)),
                Expanded(flex: 1, child: Icon(Icons.settings))
              ],
            ),
          ),
          Container(
            child: Expanded(
                flex: 2,
                child: Container(

                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*10/360),
                  child: Text("How can I buy this product.Could you please suggest some places to buy it",style: KPostReviewCard),
                  // color: Colors.red,
                )),
          ),


        ],
      ),
    );
  }
}

