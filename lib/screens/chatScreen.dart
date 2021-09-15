import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reviewia/components/chatScreen_post.dart';
import 'package:reviewia/components/groupCard.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/fetchChatList.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/selectedGroup.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';
  late ChatListStruct detail;
  late String userName;
  late  PostsView post;
  ChatScreen({required this.detail,required this.userName, required this.post});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {

  bool _loadingPost = true;
  List<Messages> message= <Messages>[];
  List<Users> userList= <Users>[];
  late List list =[];
  final inputController = TextEditingController();

  Future <void> _loadChat() async {
    String id = widget.detail.id.toString();
    String token = (await UserState().getToken());
    String url = KBaseUrl + "api/user/group/"+id;

    await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': token,
        }).then((response) {
      late SlectedGroup selectedgroup;
      var data = json.decode(response.body);
      selectedgroup = new SlectedGroup(
          id: data['id'],
          createdAt: data['createdAt'],
          postId: data['postId'],
          active: data['active'],
          messages: data['messages'],
          users: data['users']);
      var members = selectedgroup.users.map((e) => Users.fromJson(e)).toList();
      setState(() {
        userList = members;
      });
      if (selectedgroup.messages != null) {
        var messageList = selectedgroup.messages.map((e) => Messages.fromJson(e)).toList();
        setState(() {
          message = messageList;
          //_fetchPost();
        });
        for (var item in message) {
          print('${item.createdBy} - ${item.content}');
        }
        for (var item in userList) {
          print('${item.firstName} - ${item.lastName}');
        }
      }
      else {
        print("Sub category empty....");
      }
    });
  }


  Future <void> _SendMessage(String msg) async {
    print("Function: "+ msg);
    String id = widget.detail.id.toString();
    String token = (await UserState().getToken());
    String url = KBaseUrl + 'api/user/chat?email='+widget.userName+'&group='+id;
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "content": msg
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      print("Sent");
      msg = "";
      inputController.text = "";
      _loadChat();
    }
    else {
      print(response.statusCode);
      print("not sent");
    }
  }
  @override
  void initState() {
    _loadChat();
    super.initState();
    //connectToSocket();
  }

  Future getRefreshData() async {
    _loadChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          widget.post.title,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        actions: [
          PopupMenuButton(
                icon: Icon(Icons.more_vert,),
                onSelected: (item) {
                 // selectedOption(item.toString(),widget.id,context);
                  print(item);},
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Group Info",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      "Add Members",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text(
                      "Remove Members",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  PopupMenuItem(
                    value: widget.userName == widget.detail.createdBy.email? 4:5,
                    child: widget.userName == widget.detail.createdBy.email?
                    Text(
                      "Delete chat",
                      style: TextStyle(color: Colors.black),
                    ):
                    Text(
                      "Leave Group",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: getRefreshData,
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 30,right: 30, top: 10),
            child: Column(
              children: [
                ChatScreenPostCard(detail: widget.post),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: message.length,

                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                        child: Align(
                          alignment: (message[index].createdBy == widget.userName?Alignment.topRight:Alignment.topLeft),
                          child: (message[index].createdBy == widget.userName?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                int.parse(message[index].createdAt.substring(11, 13)) > 12 ?
                                "You"+ " - "+ message[index].createdAt.substring(0, 10)+" "+message[index].createdAt.substring(11, 16) +"pm":
                                "You"+ " - "+ message[index].createdAt.substring(0, 10)+" "+message[index].createdAt.substring(11, 16)+"am",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[100],
                                ),

                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: (message[index].createdBy == widget.userName?Colors.blue[200]:Colors.grey.shade200),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(message[index].content, style: TextStyle(fontSize: 15),),
                              ),
                            ],
                          ):Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                int.parse(message[index].createdAt.substring(11, 13)) > 12 ?
                                message[index].fullName+ " - "+ message[index].createdAt.substring(0, 10)+" "+message[index].createdAt.substring(11, 16) +"pm":
                                message[index].fullName+ " - "+ message[index].createdAt.substring(0, 10)+" "+message[index].createdAt.substring(11, 16)+"am",

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[100],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: (message[index].createdBy == widget.userName?Colors.blue[200]:Colors.grey.shade200),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(message[index].content, style: TextStyle(fontSize: 15),),
                              ),
                            ],
                          )
                          ),
                        ),
                      );
                    },

                  )
                ),
                _bottomChatArea()
              ],
            ),
          ),
      ),
    );
  }

  _bottomChatArea(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          _chatTextArea(),
          IconButton(
              onPressed: (){
                  if(inputController.text.isNotEmpty){
                    print(inputController.text);

                    setState(() {
                      _SendMessage(inputController.text);
                    });
                   // inputController.text = "";
                  }
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  _chatTextArea(){
    return Expanded(
        child: TextFormField(
          controller: inputController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10),
              hintText: "Type message"
          ),
        ) );
  }
}
