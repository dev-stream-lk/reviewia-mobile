import 'package:flutter/material.dart';
import 'package:reviewia/components/form_feild.dart';
import 'package:reviewia/constrains/constrains.dart';

class ProfilePage extends StatefulWidget {
  bool _canEdit = true;
  String Nameval = '';
  String NamePass = '';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void getValueName(String va) {
    widget.Nameval = va;
    print("Your Name" + widget.Nameval);
  }

  void getValuePassword(String va) {
    widget.NamePass = va;
    print("Your Password" + widget.NamePass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "User Profile",
          style: KappTitle,
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: new Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFCCDCF3),
                ),
                child: Text(
                  'Categories',
                  style: KdrawerTextStyle,
                ),
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
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        margin: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          // color: Colors.cyan,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 200 / 659,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFC494C4),
                    backgroundImage: AssetImage('images/pep.jpg'),
                    radius: MediaQuery.of(context).size.width * 75 / 360,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 200 / 659,
                // color: Colors.blue,
                child: Column(
                  children: [
                    FormFeild(
                        name: "darsha Damayanthi",
                        type: "Name",
                        onChanged: getValueName),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 10 / 659,
                    ),
                    FormFeild(
                        name: "********",
                        type: "Password",
                        onChanged: getValuePassword),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 10 / 659,
                    ),
                    FormFeild(
                        name: "darsha@gmail.com",
                        type: "Email",
                        onChanged: getValueName),
                  ],
                ),
              ),
              Container(
                // width: double.infinity,
                // padding: EdgeInsets.only(left:MediaQuery.of(context).),
                // color: Colors.blueGrey,
                  child: Text(
                "Your posts",
                textAlign: TextAlign.left,
                    style: KPostCard,
              )),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 15 / 659,),
                height: MediaQuery.of(context).size.height * 150 / 659,
                color: Color(0xFF39667F),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 11 / 659,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 15 / 360,right:MediaQuery.of(context).size.width * 15 / 360,),
                        height: MediaQuery.of(context).size.height * 110 / 659,
                        decoration: BoxDecoration(
                          color: Color(0xFFAAAAAA),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color:Colors.blueGrey,
                            )
                          ],
                        ),

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 11 / 659,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 110 / 659,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String onChanged(val) {
  print(val);
  return (val);
}
