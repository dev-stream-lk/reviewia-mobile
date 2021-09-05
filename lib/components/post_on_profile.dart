import 'package:flutter/material.dart';
import 'package:reviewia/components/MyPost_comp.dart';
import 'package:reviewia/components/post_on_fav.dart';
import 'package:reviewia/components/post_on_profile.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/fetchMyPost.dart';
import 'package:reviewia/services/optionServices.dart';
import 'package:reviewia/structures/favouriteListStruct.dart';
import 'package:reviewia/structures/postView.dart';


class MyPost extends StatefulWidget {
  static String id = 'myPost';
  const MyPost({Key? key}) : super(key: key);

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  bool _isLoading = true;
  List<PostsView> _postView = <PostsView>[];
  List<PostsView> _postDisplayView = <PostsView>[];


  getMyPostList()async{
    _postView = await fetchMyPost();
    //var dd = await fetchMyPost();
    setState(() {
      _isLoading=false;
      _postDisplayView = [];
      _postDisplayView.addAll(_postView);
      for (var item in _postView) {
        print('${item.title} - ${item.brand} - ${item.postId}');
      }
    });
  }


  @override
  void initState() {
    setState(() {
      _isLoading=true;
      print('Hello my post');
    });
    getMyPostList();
    super.initState();
  }

  _listItemViewPosts(int index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(05),
          child: MyPostComp(detail: _postDisplayView[index],),
        ),
      ),
    );
  }
  _searchBarView(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.02,vertical: MediaQuery.of(context).size.height*0.02 ),
      child: Center(child: Text("Pull down to refresh",style: KPostCard,textAlign: TextAlign.start,)),
    );
  }
  Future getBuildingData() async {
    getMyPostList();
  }
  // fetchPostViewStep("0","2").then((value){
  //   setState(() {
  //     _loadPost.add(value[0]);
  //   });
  // });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "My Posts",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getBuildingData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 12,
              // height: MediaQuery.of(context).size.height*0.8,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (!_isLoading) {
                    return index == 0
                        ? _searchBarView()
                        : _listItemViewPosts(index - 1);
                    // return _listItem(index);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                itemCount: _postDisplayView.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
