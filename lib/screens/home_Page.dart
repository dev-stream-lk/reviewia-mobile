import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/constrains/constrains.dart';

import '../home_data.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;




  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as HomeData;
   print(arguments.title);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Kcolor,
        leading:Builder(
          builder:(BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },

        ) ,
        title: Text("Reviwia"),
      ) ,
      drawer: Container(
        width: MediaQuery.of(context).size.width*0.7,
        child: new Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFCCDCF3),
                ),
                child: Text('Categories',style: KdrawerTextStyle,),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      bottomNavigationBar:Container(
        height: MediaQuery.of(context).size.height*0.0825,
        color: Kcolor,
        width: double.infinity,
        child: Text('Hello'),
      ) , // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
