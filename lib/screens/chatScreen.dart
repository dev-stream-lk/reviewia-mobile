import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reviewia/components/groupCard.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/constrains/urlConstrain.dart';
import 'package:reviewia/services/fetchChatList.dart';
import 'package:reviewia/services/userState.dart';
import 'package:reviewia/structures/chatListStruct.dart';
import 'package:http/http.dart' as http;
import 'package:reviewia/structures/selectedGroup.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';
  late ChatListStruct detail;
  late String userName;
  ChatScreen({required this.detail,required this.userName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {


  List<Messages> message= <Messages>[];
  late List list =[];
  final inputController = TextEditingController();

  Future <void> _loadChat() async {
    String id = widget.detail.id.toString();
    String token = (await UserState().getToken());
    String url = KBaseUrl + "api/user/group/"+id;

    // while(true){
    //   Timer(Duration(seconds: 1), () async {
    //     print(" This line is execute after 5 seconds");
    //
    //   });
    //}
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
          messages: data['messages']);
      if (selectedgroup.messages != null) {
        var messageList = selectedgroup.messages.map((e) => Messages.fromJson(e)).toList();
        setState(() {
          message = messageList;
        });
        for (var item in message) {
          print('${item.content} - ${item.createdBy}');
        }
      }
      else {
        print("Sub category empty....");
      }
    });
  }

  Future <void> _SendMessage(String msg) async {
    String id = widget.detail.id.toString();
    String token = (await UserState().getToken());
    String url = KBaseUrl + "api/user/chat?email="+widget.userName+"&group="+id;

    await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': token,
        },
        body: jsonEncode(<String,String>{
          "content": msg,
        })
        ).then((response) {
      if (response.statusCode==200){
        _loadChat();
        print("Message sent");
      }
      else{
        print("Message not sent");
      }
    });
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
          "My Chat",
          style: KappTitle,
        ),
      ),

      body: RefreshIndicator(
        onRefresh: getRefreshData,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: message.length,
                  // itemBuilder: (BuildContext context, int index)
                  // {
                    //return Text(message[index].content);
                    // return Row(
                    //
                    //   children: [
                    //     Text(message[index].content)
                    //   ],
                    // );
                  //},

                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (message[index].createdBy == widget.userName?Alignment.topRight:Alignment.topLeft),
                        child: (message[index].createdBy == widget.userName?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("You"+ " - "+ message[index].createdAt.substring(0, 10),
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
                            Text(message[index].createdBy+ " - "+ message[index].createdAt.substring(0, 10),
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
                    inputController.text = "";
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
