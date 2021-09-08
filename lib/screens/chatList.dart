import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/groupCard.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/fetchChatList.dart';
import 'package:reviewia/structures/chatListStruct.dart';

class ChatList extends StatefulWidget {
  static String id = 'ChatList';

  @override
  _ChatListState createState() => _ChatListState();
}


class _ChatListState extends State<ChatList> {
  bool _isLoading = true;
  List<dynamic> _allData = <dynamic>[];
  List<Users> _users = <Users>[];


  _loadChatList() async {
    var data = await fetchCatList();
    setState(() {
      _allData = data;
      for (var item in _allData) {
        print('${item.postId} - ${item.id}-${item.createdBy.id}');
      }
      print("Lenght of array::"+ _allData.length.toString());
      _isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading=true;
    });
    _loadChatList();
    super.initState();
  }

  _listItemViewGroups(int index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(05),
          child: GroupCard(detail: _allData[index],),
        ),
      ),
    );
  }

  Future getBuildingData() async {
    _loadChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text(
            "My Groups",
            style: KappTitle,
          ),
        ),

        body: RefreshIndicator(
          onRefresh: getBuildingData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                  "My Chats",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Expanded(
                flex: 12,
                // height: MediaQuery.of(context).size.height*0.8,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (!_isLoading) {
                      return _listItemViewGroups(index);
                      // return _listItem(index);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  itemCount: _allData.length,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
