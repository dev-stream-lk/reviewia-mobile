import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/screens/product_view.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/postView.dart';

import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/notificationStruct.dart';
import 'package:reviewia/structures/reviewStruct.dart';
import 'package:reviewia/structures/selectedGroup.dart';

import 'chatScreen.dart';

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
  late ReviewStruct reviewStruct;
  late ReviewStruct reviewCards ;
  late ChatListStruct chatListStruct;
  bool click = false;

  List<NotificationStruct> notificationList = [];
  List<NotificationStruct> notificationListDisplay = [];
  _listItem(indexNumber) {
    int index = notificationListDisplay.length - (indexNumber as int) - 1;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: ((!notificationListDisplay[index].markAsRead))?KNotClickedColor:KClickedColor,
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
                    ? FontAwesomeIcons.users
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
                  setState(() {
                    click=true;
                  });
                  selectionNotification(notificationListDisplay[index].id,notificationListDisplay[index].type,notificationListDisplay[index].targetId.toString());
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
    print("post id: "+id);
    var data = await fetchPostViewByIdInNotification(id);
    print(data);
    setState(() {
      detail = data;
    });
  }

  Future loadReview(String id)async{
    print("Review id: "+id);
    var data = await fetchReviewOfNotification(id);
    print(data.postId.toString());
    await loadPost(data.postId.toString());
  }

  Future loadGroup(String id)async{
    print("Group id: "+id);
    var data =await getInstantGroupforNotification(id) as ChatListStruct ;
    setState(() {
      chatListStruct =data;
    });
    print(data.postId.toString());
    await loadPost(data.postId.toString());
  }
  Future setMarkedAsNotification(int nId)async{
    var data = setMarkedOfNotification(nId.toString());
    print(data);
  }

  selectionNotification(int nId,String type,String id) async{
    String email =await  UserState().getUserName();

    setState(() {
      click=true;
    });
    await setMarkedAsNotification(nId);

    if(type=='POST'){
      await loadPost(id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductView(todos:detail,reviewId:0),
        ),
      );
    }else if(type=='REVIEW'){
      var rID =id;
      await loadReview(id);
      print('Still not configure');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductView(todos:detail,reviewId:int.parse(rID)),
        ),
      );
    }else if(type=='GROUP'){
      var gID = id ;
      await loadGroup(id);
      String creator = chatListStruct.createdBy.firstName+" "+chatListStruct.createdBy.lastName;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(detail:chatListStruct,userName:email,post:detail, creator:creator,),
        ),
      );
    }




  }

  @override
  void initState() {
    getNotification();
    setState(() {
      click = false;
    });
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
