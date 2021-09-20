import 'package:flutter/material.dart';
import 'package:reviewia/components/groupCard.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/fetchChatList.dart';
import 'package:reviewia/services/userState.dart';

class ChatList extends StatefulWidget {
  static String id = 'ChatList';

  @override
  _ChatListState createState() => _ChatListState();
}


class _ChatListState extends State<ChatList> {
  bool _isLoading = true;
  List<dynamic> _allData = <dynamic>[];
  List<dynamic> _deactivated = <dynamic>[];
  late String email;


  _loadChatList() async {
    var data = await fetchCatList();
    email = await UserState().getUserName();
    setState(() {
      _allData = data.where((element) {
        String isActive = '${element.active}';
        return isActive== "true";
      }).toList();
      _deactivated = data.where((element) {
        String isActive = '${element.active}';
        String creator = '${element.createdBy.email}';
        return isActive== "false" && creator == email;
      }).toList();
      _allData.addAll(_deactivated);
       //_allData = data;
      for (var item in _allData) {
        print('${item.postId} - ${item.id}-${item.createdBy.id}-${item.active}');

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
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(05),
          child: GroupCard(detail: _allData[index],email:email),
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
          child: !_isLoading?Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text(
                      "My Chats",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              _allData.isNotEmpty?Expanded(
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
              ):Center(
                child: Text("No groups available..",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ): Center(child: CircularProgressIndicator()),
        ),
    );
  }
}
