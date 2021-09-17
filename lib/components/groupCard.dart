import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/chatScreen.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:reviewia/structures/postView.dart';

class GroupCard extends StatefulWidget {
  late ChatListStruct detail;
  late String email;
  GroupCard({required this.detail, required this.email});

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {

  late PostsView post;
  String PostTitle = "";
  Future _fetchPost() async {
    String id = widget.detail.postId.toString();
    var postData = await fetchPostViewById(id);
    setState(() {
      post = postData;
      PostTitle = post.title;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPost().whenComplete((){});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String creator = widget.detail.createdBy.firstName+" "+widget.detail.createdBy.lastName;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(detail: widget.detail,userName:widget.email,post:post,creator:creator),
          ),
        );
      },
      // child: Container(
      //   // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
      //   height: MediaQuery.of(context).size.height * 105 / 659,

      //   ),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         flex: 3,
      //         child: Container(
      //           margin: EdgeInsets.only(
      //             top: MediaQuery.of(context).size.width * 15 / 360,
      //             bottom: MediaQuery.of(context).size.width * 15 / 360,
      //             right: MediaQuery.of(context).size.width * 15 / 360,
      //             left: MediaQuery.of(context).size.width * 15 / 360,
      //           ),
      //           child: DecoratedBox(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(15),
      //                   topRight: Radius.circular(15),
      //                   bottomLeft: Radius.circular(15),
      //                   bottomRight: Radius.circular(15)),
      //               color: Colors.white,
      //             ),
      //             // child: Image.network("https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
      //             //   fit: BoxFit.cover,
      //             //   loadingBuilder: (BuildContext context, Widget child,
      //             //       ImageChunkEvent? loadingProgress) {
      //             //     if (loadingProgress == null) {
      //             //       return child;
      //             //     }
      //             //     return Center(
      //             //       child: CircularProgressIndicator(
      //             //         value: loadingProgress.expectedTotalBytes != null
      //             //             ? loadingProgress.cumulativeBytesLoaded /
      //             //             loadingProgress.expectedTotalBytes!
      //             //             : null,
      //             //       ),
      //             //     );
      //             //   },
      //             // ),
      //             child: Icon(
      //               Icons.group,
      //               color: Kcolor,
      //               size: 50,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //           flex: 4,
      //           child: Container(
      //             // color: Colors.red,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Expanded(
      //                   flex: 2,
      //                   child: Center(
      //                     child: Container(
      //                       margin: EdgeInsets.only(
      //                           top: MediaQuery.of(context).size.height *
      //                               15 /
      //                               692),
      //                       width: double.infinity,
      //                       // color: Colors.orange,
      //                       child:widget.email == widget.detail.createdBy.email?
      //                       Text("Creator: You",
      //                         style: KPostCard,
      //                       ):Text("Creator: "+
      //                         widget.detail.createdBy.firstName+" "+widget.detail.createdBy.lastName,
      //                         style: KPostCard,
      //                       ),
      //
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   flex: 2,
      //                   child: Container(
      //                     // color: Colors.white,
      //                     // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 25/692 ),
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                             "Members: "+ widget.detail.users.length.toString()),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   flex: 2,
      //                   child: Container(
      //                     // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*18/692),
      //                     child: Text(
      //                       "Created date: " +
      //                           widget.detail.createdAt.substring(0, 10),
      //                       style: TextStyle(
      //                         fontSize: 10,
      //                       ),
      //                       textAlign: TextAlign.left,
      //                     ),
      //                     // color: Colors.yellow,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           )),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Expanded(
      //               flex: 2,
      //               child: PopupMenuButton(
      //                 icon: Icon(Icons.more_vert),
      //                 // onSelected: (item) {
      //                 //   selectedOption(
      //                 //       item.toString(), widget.detail.postId, context);
      //                 //   print(item);
      //                 //
      //                 // },
      //                 itemBuilder: (context) => [
      //                   PopupMenuItem(
      //                     value: 3,
      //                     child: Text(
      //                       "Remove",
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                 ],
      //               )),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        decoration: BoxDecoration(
          color: widget.email == widget.detail.createdBy.email?
          Colors.blue[50]:Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(widget.imageUrl),
                  //   maxRadius: 30,
                  // ),
                  Icon(
                    Icons.group_rounded,
                    color: Kcolor,
                    size: 50,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(PostTitle,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          Text("Creator: "+
                            widget.detail.createdBy.firstName+" "+widget.detail.createdBy.lastName,
                            style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight:FontWeight.normal),),
                          SizedBox(height: 6,),
                          Text("Created date: "+widget.detail.createdAt.substring(0, 10),
                            style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight:FontWeight.normal),),
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
