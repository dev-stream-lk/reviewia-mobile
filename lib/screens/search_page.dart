import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String id = 'SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int indexSelect = 0;
  late double rate = 3;
  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];
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
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                    child: Text(
                      'Filter By Section',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),textAlign:TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
                height: MediaQuery.of(context).size.height*0.075,
                child: FlutterToggleTab(
                  width:MediaQuery.of(context).size.width*0.25,
                  borderRadius: 10,
                  selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  selectedBackgroundColors: [
                    Colors.white,
                  ],
                  unSelectedBackgroundColors: [
                    Colors.yellow.shade700,
                  ],
                  labels: ["Product", "Service"],
                  icons: [Icons.ad_units, Icons.home_repair_service],
                  selectedLabelIndex: (index) {
                    setState(() {
                      indexSelect = index;
                    });
                    print("Selected Index $index");
                  },
                  selectedIndex: indexSelect,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                    child: Text(
                      'Filter By Category',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),textAlign:TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: items.isNotEmpty?items:["No Sub Categories"],
                    label: "Category List",
                    hint: "Category List",
                    // popupItemDisabled: (String s) => s.startsWith('I'),
                    // onChanged: (data){chengeTheValues(data!);},
                    onChanged: (data)=>{print(data)},
                    selectedItem: "All",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                    child: Text(
                      'Filter By SubCategory',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),textAlign:TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: items.isNotEmpty?items:["No Sub Categories"],
                  label: "Sub Category List",
                  hint: "Sub Category List",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  // onChanged: (data){chengeTheValues(data!);},
                  onChanged: (data)=>{print(data)},
                  selectedItem: "All",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                    child: Text(
                      'Filter By Brand',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),textAlign:TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: items.isNotEmpty?items:["No Sub Categories"],
                  label: "Brand List",
                  hint: "Brand List",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  // onChanged: (data){chengeTheValues(data!);},
                  onChanged: (data)=>{print(data)},
                  selectedItem: "All",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
                    child: Text(
                      'Filter By Rating',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),textAlign:TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.046),
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
                          rate=rating;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
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
                      padding:EdgeInsets.all(20),
                      color: Color(0x9AB3AFAF),
                        onPressed: ()=>{print('Hello')}, child: Text('Clear All'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    FlatButton(
                      padding:EdgeInsets.all(20),
                      color: Colors.yellow.shade700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: ()=>{print('Hello')}, child: Text('Apply Filters',style: TextStyle(color: Colors.white),),
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
