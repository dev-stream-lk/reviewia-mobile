import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';

class GroupCard extends StatefulWidget {
  late ChatListStruct detail;
  late String email;
  GroupCard({required this.detail, required this.email});

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {


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
        //     builder: (context) => ProductView(todos: widget.detail),
        //   ),
        // );
        // Navigator.pushNamed(context, ProductView.id);
      },
      child: Container(
        // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
        height: MediaQuery.of(context).size.height * 105 / 659,
        decoration: BoxDecoration(
          color: widget.email == widget.detail.createdBy.email?
          Colors.blue[50]:Colors.amberAccent,
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
                  child: Image.network("https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
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
                            child:widget.email == widget.detail.createdBy.email?
                            Text("Creator: You",
                              style: KPostCard,
                            ):Text("Creator: "+
                              widget.detail.createdBy.firstName+" "+widget.detail.createdBy.lastName,
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
                              Text(
                                  "Members: "+ widget.detail.users.length.toString()),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
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
                      // onSelected: (item) {
                      //   selectedOption(
                      //       item.toString(), widget.detail.postId, context);
                      //   print(item);
                      //
                      // },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 3,
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
      ),
    );
  }
}
