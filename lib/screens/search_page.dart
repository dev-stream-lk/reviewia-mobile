import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String id = 'SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          searchBarUI(),
        ],
      ),
    );
  }

  Widget searchBarUI(){

    return FloatingSearchBar(
      hint: 'Search.....',
      openAxisAlignment: 0.0,
      width: 600,
      axisAlignment:0.0,
      scrollPadding: EdgeInsets.only(top: 16,bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query){
        //Your methods will be here
      },
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(icon: Icon(Icons.search),
            onPressed: (){
              print('Last Searched');
            },),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition){
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 200.0,
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Serached Products'),
                    subtitle: Text('more info here........'),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}



// Widget buildFloatingSearchBar(BuildContext context) {
//   final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//
//   return ;
// }