import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';

class NotificationList extends StatefulWidget {
  static String id = 'notification_list';

  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(
          "Notification List",
        ),
      ),
    );
  }
}
