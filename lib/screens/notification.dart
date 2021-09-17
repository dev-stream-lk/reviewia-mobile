import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/postView.dart';

import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/notificationStruct.dart';

class NotificationList extends StatefulWidget {
  static String id = 'notification_list';

  const NotificationList({Key? key}) : super(key: key);



  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  // List<PostsView> _postView = <PostsView>[];
  bool isLoading = true;
  late PostsView detail;

  List<NotificationStruct> notificationList = [];
  List<NotificationStruct> notificationListDisplay = [];
  _listItem(indexNumber) {
    int index = notificationListDisplay.length - (indexNumber as int) - 1;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: !notificationListDisplay[index].markAsRead
            ? Color(0xFF273C6C)
            : Colors.blueGrey.shade300,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:Icon(notificationListDisplay[index].content ==
                    'Someone liked your review'
                    ? FontAwesomeIcons.solidThumbsUp
                    : notificationListDisplay[index].content ==
                    'Someone disliked your review'
                    ? FontAwesomeIcons.solidThumbsDown
                    : notificationListDisplay[index].content ==
                    'A user created a chat group with you'
                    ? FontAwesomeIcons.comments
                    : notificationListDisplay[index].content ==
                    'You have a new message'
                    ? FontAwesomeIcons.comment
                    : notificationListDisplay[index].content ==
                    'Someone added a new review for your post'
                    ? FontAwesomeIcons.commentAlt
                    : FontAwesomeIcons.fileCsv , color: Colors.white,),
                title:Text(
                  notificationListDisplay[index].content,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.038,
                    color: Colors.white
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notificationListDisplay[index].createdAt.substring(0,10),style: TextStyle(color: Colors.white),),
                    Text(notificationListDisplay[index].type,style: TextStyle(color: Colors.white),)
                  ],
                ),
                hoverColor: Colors.white,
                onTap:(){
                  selectionNotification(notificationListDisplay[index].type,notificationListDisplay[index].targetId.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getNotification() async {
    fetchNotification().then((value) {
      setState(() {
        notificationList = <NotificationStruct>[];
        notificationListDisplay = <NotificationStruct>[];
        notificationList.addAll(value);
        notificationListDisplay.addAll(notificationList.reversed);
        isLoading=false;
      });
    });
  }

  Future loadPost(String id)async{
    print(id);
    var data = await fetchPostViewByIdInNotification(id);
    print(data);
    setState(() {
      detail = data;
    });
  }

  Future loadReview(String id)async{

  }


  selectionNotification(String type,String id) async{

    if(type=='POST'){
      await loadPost(id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductView(todos:detail),
        ),
      );
    }else if(type=='REVIEW'){
      // await loadReview(id);
      print('Still not configure');
    }




  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "Notification List",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(bottom:100),
          child: isLoading? Center(
            child: CircularProgressIndicator(),
          ) :ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _listItem(index);
            },
            itemCount: notificationListDisplay.length,
          ),
        ),
      ),
    );
  }


}
