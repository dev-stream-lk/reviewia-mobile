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
  int id = 0;
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
