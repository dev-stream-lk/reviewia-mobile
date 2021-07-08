import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePageTopProducts extends StatefulWidget {
  const HomePageTopProducts({Key? key}) : super(key: key);

  @override
  _HomePageTopProductsState createState() => _HomePageTopProductsState();
}

class _HomePageTopProductsState extends State<HomePageTopProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     Expanded(
      //       flex: 1,
      //       child: Column(
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               color: Colors.red,
      //             ),
      //           ),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               color: Colors.yellow,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //
      //     searchBarUI(),
      //
      //   ],
      // ),
      body:Container(
        child: SingleChildScrollView(
          child: Container(
            height: 1200,
            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  // height: 45,
                  height: MediaQuery.of(context).size.height*55/692,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*5/692),
                        topRight: Radius.circular(MediaQuery.of(context).size.height*5/692),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*5/692),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*5/692)
                  ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                ),
                  child: Text("Most Viewed"),

                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }


}

// Widget searchBarUI() {
//   return FloatingSearchBar(
//     hint: 'Search.....',
//     openAxisAlignment: 0.0,
//     width: MediaQuery.of(context).size.width * 0.8,
//     axisAlignment: 0.0,
//     scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
//     elevation: 4.0,
//     physics: BouncingScrollPhysics(),
//     onQueryChanged: (query) {
//       //Your methods will be here
//     },
//     transitionCurve: Curves.easeInOut,
//     transitionDuration: Duration(milliseconds: 500),
//     transition: CircularFloatingSearchBarTransition(),
//     debounceDelay: Duration(milliseconds: 500),
//     actions: [
//       FloatingSearchBarAction(
//         showIfOpened: false,
//         child: CircularButton(
//           icon: Icon(Icons.search),
//           onPressed: () {
//             print('Places Pressed');
//           },
//         ),
//       ),
//       FloatingSearchBarAction.searchToClear(
//         showIfClosed: false,
//       ),
//     ],
//     builder: (context, transition) {
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
//                   title: Text('Category and Product'),
//                   subtitle: Text('more info here........'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

