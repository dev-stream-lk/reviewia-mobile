import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/structures/categoryView.dart';
import 'package:reviewia/structures/selectedCatergory.dart';

enum SingingCharacter { product, service }

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String id = 'SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int indexSelect = 0;
  bool loading = true;
  late double rate = 3;
  String selectedType = "";
  String selectedCategoryName = "";
  String selectedSubCategoryName = "";
  String selectedBrand = "";
  List<CategoryView> _catView = <CategoryView>[];
  List<CategoryView> _catDisplayView = <CategoryView>[];
  List<String> itemList = <String>[];
  List<String> itemListCategory = <String>[];
  List<String> itemListSubCategory = <String>[];
  SingingCharacter? _character = SingingCharacter.product;
  List<SubCategoryList> _subCate = <SubCategoryList>[];
  String state = 'All';
  bool isLoading = true;
  bool isLoadingSubCat = false;
  late int catId;

  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  getTheCategoryOptions(String type) async {
    print(type);
    fetchCategoryView().then((val) {
      setState(() {
        itemList = <String>[];
        _catView = <CategoryView>[];
        _catDisplayView = <CategoryView>[];
        _subCate=[];
        itemListSubCategory=[];
        _catView.addAll(val);
        print(_catView);
        _catDisplayView = _catView.where((element) {
          var catType = element.type.toLowerCase();
          return catType.contains(type);
        }).toList();
        if (_catDisplayView.isNotEmpty) {
          itemList.add("All");
          itemListSubCategory.add("All");
          for (int i = 0; i < _catDisplayView.length; i++) {
            itemList.add(_catDisplayView[i].categoryName);
          }
        } else {
          itemList.add("All");
          itemListSubCategory.add("All");
        }
        loading = false;
        isLoadingSubCat=false;
      });
    });
    return itemList;
  }

  selectTheOption(int type) async {
    var typeOfOption;
    if (type == 1) {
      typeOfOption = "p";
    } else {
      typeOfOption = "s";
    }
    print(typeOfOption);
    var dd = getTheCategoryOptions(typeOfOption.toString());
    print("The cat list is :" + dd.toString());
    return dd;
  }

  selectTheCategory(String data) async {
    print("selected category" + data);

    if (data != 'All') {
      for (int i = 0; i < _catView.length; i++) {
        if (_catView[i].categoryName == data) {
          setState(() {
            catId = _catView[i].categoryId;
            // fetchSelectedCatergory(catId.toString());
          });
          break;
        }
      }
      print("category id is:" + catId.toString());
      var dd = await fetchSelectedCatergory(catId.toString());
      setState(() {
        itemListSubCategory = [];
        _subCate=[];
        itemListSubCategory.add("All");
        if (dd.subCategoryList.length != 0) {
          print("category is " + dd.subCategoryList.length.toString());
          var posts = dd.subCategoryList
              .map((e) => SubCategoryList.fromJson(e))
              .toList();
          _subCate.addAll(posts);

          for (int i = 0; i < _subCate.length; i++) {
            itemListSubCategory.add(_subCate[i].subCategoryName);
            print(itemListSubCategory[i]);
          }
        } else {
          _subCate = [];
        }
        isLoadingSubCat = false;
        // print(_subCate[0].subCategoryName.toString());
      });
    }else if(data=="All"){
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          itemListSubCategory = [];
          _subCate=[];
          isLoadingSubCat = false;
          itemListSubCategory.add("All");
        });
        // Do something
      });

    }
  }

  @override
  void initState() {
    // setState((){
    //   getTheCategoryOptions('p');
    // });
    selectTheOption(1);
    setState(() {
      isLoadingSubCat = false;
      itemList.add('All');
      itemListSubCategory.add("All");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        backgroundColor: Kcolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.046),
                    child: Text(
                      'Filter By Section',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
              //   height: MediaQuery.of(context).size.height*0.075,
              //   child: FlutterToggleTab(
              //     width:MediaQuery.of(context).size.width*0.25,
              //     borderRadius: 10,
              //     selectedTextStyle: TextStyle(
              //         color: Colors.black,
              //         fontSize: 18,
              //         fontWeight: FontWeight.w600),
              //     unSelectedTextStyle: TextStyle(
              //         color: Colors.white,
              //         fontSize: 18,
              //         fontWeight: FontWeight.w600),
              //     selectedBackgroundColors: [
              //       Colors.white,
              //     ],
              //     unSelectedBackgroundColors: [
              //       Colors.yellow.shade700,
              //     ],
              //     labels: ["Product", "Service"],
              //     icons: [Icons.ad_units, Icons.home_repair_service],
              //     selectedLabelIndex: (index) async {
              //       setState(() {
              //         indexSelect = index;
              //         var s = selectTheOption(indexSelect);
              //         print(s.toString());
              //       });
              //       print("Selected Index $index");
              //     },
              //     selectedIndex: indexSelect,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005),
                // height: MediaQuery.of(context).size.height*0.095,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Prodcut'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.product,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          print('sss');
                          setState(() {
                            loading = true;
                            isLoadingSubCat=true;
                            _character = value;
                            // var s = selectTheOption(1);
                            //         print(s.toString());
                          });
                          var s = selectTheOption(1);
                          print(s.toString());
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Services'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.service,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) async {
                          print('sss-2');
                          setState(() {
                            loading = true;
                            isLoadingSubCat=true;
                            _character = value;
                          });
                          var s = await selectTheOption(0);
                          print(s.toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.046),
                    child: Text(
                      'Filter By Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              loading
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: CupertinoActivityIndicator())
                  : Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.046),
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: itemList.isNotEmpty
                            ? itemList
                            : ["No Sub Categories"],
                        label: "Category List",
                        hint: "Category List",
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        // onChanged: (data){chengeTheValues(data!);},
                        onChanged: (data) {
                          setState(() {
                            isLoadingSubCat = true;
                          });
                          selectTheCategory(data!);
                        },
                        selectedItem: itemList[0],
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.046),
                    child: Text(
                      'Filter By SubCategory',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              isLoadingSubCat
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: CupertinoActivityIndicator())
                  : Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.046),
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItem: true,
                        items: itemListSubCategory.isNotEmpty
                            ? itemListSubCategory
                            : ["No Sub Categories"],
                        label: "Sub Category List",
                        hint: "Sub Category List",
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        // onChanged: (data){chengeTheValues(data!);},
                        onChanged: (data) => {print(data)},
                        selectedItem: itemListSubCategory[0],
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.046),
                    child: Text(
                      'Filter By Brand',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.046),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: items.isNotEmpty ? items : ["No Sub Categories"],
                  label: "Brand List",
                  hint: "Brand List",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  // onChanged: (data){chengeTheValues(data!);},
                  onChanged: (data) => {print(data)},
                  selectedItem: "All",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.046),
                    child: Text(
                      'Filter By Rating',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.046),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 35,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Kcolor,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(rate.toString()),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.all(20),
                      color: Color(0x9AB3AFAF),
                      onPressed: () => {print('Hello')},
                      child: Text('Clear All'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.yellow.shade700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () => {print('Hello')},
                      child: Text(
                        'Apply Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Scaffold(
// resizeToAvoidBottomInset: false,
// body: Stack(
// fit: StackFit.expand,
// children: [
// searchBarUI(),
// ],
// ),
// );
//
// Widget searchBarUI(){
//
//   return FloatingSearchBar(
//     hint: 'Search.....',
//     openAxisAlignment: 0.0,
//     width: 600,
//     axisAlignment:0.0,
//     scrollPadding: EdgeInsets.only(top: 16,bottom: 20),
//     elevation: 4.0,
//     physics: BouncingScrollPhysics(),
//     onQueryChanged: (query){
//       //Your methods will be here
//     },
//     transitionCurve: Curves.easeInOut,
//     transitionDuration: Duration(milliseconds: 500),
//     transition: CircularFloatingSearchBarTransition(),
//     debounceDelay: Duration(milliseconds: 500),
//     actions: [
//       FloatingSearchBarAction(
//         showIfOpened: false,
//         child: CircularButton(icon: Icon(Icons.search),
//           onPressed: (){
//             print('Last Searched');
//           },),
//       ),
//       FloatingSearchBarAction.searchToClear(
//         showIfClosed: false,
//       ),
//     ],
//     builder: (context, transition){
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8.0),
//         child: Material(
//           color: Colors.white,
//           child: Container(
//             height: 200.0,
//             color: Colors.white,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text('Searched Products'),
//                   subtitle: Text('more info here........'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//
//   );
// }
