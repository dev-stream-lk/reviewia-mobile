import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/structures/allCategory.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/postView.dart';
import 'package:reviewia/structures/selectedCatergory.dart';
import 'package:reviewia/structures/subCate.dart';



class SubCatergoryList extends StatefulWidget {
  String catId;
  String catName;
  SubCatergoryList({required this.catId, required this.catName});

  @override
  _SubCatergoryListtState createState() => _SubCatergoryListtState();
}

class _SubCatergoryListtState extends State<SubCatergoryList> {
  List<SubCategoryList> _subCate = <SubCategoryList>[];
  List<SelectedCatergory> _postDisplay = <SelectedCatergory>[];
  List <PostsView> _postView = <PostsView>[];
  List <PostsView> _postViewDisplay = <PostsView>[];

  List<String>itemList= <String>[];
  String dropdownvalue = 'mobile';
  late String subCatergoryId ;
  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];

  bool _isLoading =true;

  _listItem(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: (){
          // subCateFind(_postDisplay[index].subCategoryList);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index.toString(),
                ),
                Text(
                  _subCate[index].subCategoryName.toString(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _listItemViewProductCards(index) {
    // index = _postDisplayView.length - index - 1;
    print("created by " + _postViewDisplay[index].createdBy);
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.040),
        child: ProductCard(
          id: _postViewDisplay[index].postId,
          title: _postViewDisplay[index].title,
          detail: _postViewDisplay[index],
          photoUrl1: _postViewDisplay[index].imgURL.isNotEmpty
              ? _postViewDisplay[index].imgURL[0].url.toString()
              : "https://cdn.abplive.com/onecms/images/product/fb29564520ae25da9418d044f23db734.jpg?impolicy=abp_cdn&imwidth=300",
        ));
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          if (text.isNotEmpty) {
            setState(() {
              _postViewDisplay = _postView.where((element) {
                var postTi = element.title.toLowerCase();
                return postTi.contains(text);
              }).toList();
            });
          }
          if (text.isEmpty) {
            setState(() {
              _postViewDisplay = _postView;
            });
          }
        },
      ),
    );
  }


  getValue()async{
    var dd = await fetchSelectedCatergory(widget.catId);
    setState(() {
      if(dd.subCategoryList.length!=0){
        print("category is "+ dd.subCategoryList.length.toString());
        var posts =  dd.subCategoryList.map((e) => SubCategoryList.fromJson(e)).toList();
        _subCate.addAll(posts);
        for(int i = 0 ; i < _subCate.length;i++){
          itemList.add(_subCate[i].subCategoryName);
          print(itemList[i]);
        }
      }else{
        _subCate =[];
      }

      // print(_subCate[0].subCategoryName.toString());
    });
  }
  chengeTheValues(String data){
    setState(() {
      _isLoading=true;
    });
    for(int i=0;i<_subCate.length;i++){
      if(_subCate[i].subCategoryName==data){
        setState(() {
          subCatergoryId =_subCate[i].subCategoryId.toString();
        });
      }
    }
    print(subCatergoryId);
    getAllSubCategoryPosts(subCatergoryId).then((val) {
      setState(() {
        _postView = <PostsView>[];
        _postViewDisplay = <PostsView>[];
        _isLoading = false;
        _postView.addAll(val);
        _postViewDisplay =_postView;
      });
    });
  }

  setFunction(){
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
        _postView = [];
        _postViewDisplay =[];
        print("hee");
      });
    });

  }

  getPosts(){
    getAllCategoryPosts(widget.catId).then((val) {
      print(val);
      setState(() {
          _isLoading = false;
          _postView.addAll(val);
          _postViewDisplay =_postView;
        });
      },onError: setFunction());
  }


  @override
  void initState() {

    // fetchSelectedCatergory().then((val) {
    //   setState(() {
    //     _isLoading = false;
    //     _post.addAll(val);
    //     _postDisplay =_post;
    //   });
    // });
    setState(() {
      _isLoading=true;
    });
    getValue();
    getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Kcolor,
        title: Text(
          widget.catName,
        ),),
      // body:ListView.builder(
      //   itemBuilder: (context, index) {
      //     return _listItem(index);
      //   },
      //   itemCount: _subCate.length,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DropdownButton(
          //   value: dropdownvalue,
          //   icon: Icon(Icons.keyboard_arrow_down),
          //   items:itemList.map((String items) {
          //     return DropdownMenuItem(
          //         value: items,
          //         child: Text(items)
          //     );
          //   }
          //   ).toList(),
          // ),
          Expanded(
            flex: 2,
            child: Container(
                margin:EdgeInsets.symmetric(vertical: 12,horizontal: 20),
              child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: itemList.isNotEmpty?itemList:["No Sub Categories"],
                  label: "Sub Category List",
                  hint: "Sub Category List",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (data){chengeTheValues(data!);},
                  selectedItem: "All"
              ),
            ),
          ),
          Expanded(
            flex: 12,
              child: Container(

                child:ListView.builder(
                  itemBuilder: (context, index) {
                    if (!_isLoading) {
                      return index == 0
                          ? _searchBar()
                          : _listItemViewProductCards(index - 1);
                      // return _listItem(index);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  itemCount: _postViewDisplay.length + 1,
                ),
          ))
        ],
      ),
    );
  }
}
