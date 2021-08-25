import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/allCategory.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/selectedCatergory.dart';
import 'package:reviewia/services/subCate.dart';



class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<SubCategoryList> _subCate = <SubCategoryList>[];
  List<SelectedCatergory> _postDisplay = <SelectedCatergory>[];
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

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoSearchTextField(
        placeholder: "Search",
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {

          });
        },
      ),
    );
  }


  getValue()async{
    var dd = await fetchSelectedCatergory();
    setState(() {
      print("category is "+ dd.subCategoryList.length.toString());
      var posts =  dd.subCategoryList.map((e) => SubCategoryList.fromJson(e)).toList();
      _subCate.addAll(posts);
      for(int i = 0 ; i < _subCate.length;i++){
        itemList.add(_subCate[i].subCategoryName);
        print(itemList[i]);
      }
      print(_subCate[0].subCategoryName.toString());
    });
  }
  chengeTheValues(String data){
    for(int i=0;i<_subCate.length;i++){
      if(_subCate[i].subCategoryName==data){
        setState(() {
          subCatergoryId =_subCate[i].subCategoryId.toString();
        });
      }
    }
    print(subCatergoryId);
  }

  getPosts(){

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

    getValue();
    getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Kcolor,
        title: Text(
          "Test",
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
                  items: itemList,
                  label: "Menu mode",
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

            color: Colors.grey,
          ))
        ],
      ),
    );
  }
}
