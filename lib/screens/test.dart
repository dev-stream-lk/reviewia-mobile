import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:reviewia/services/allCategory.dart';
import 'package:reviewia/services/network.dart';
import 'package:reviewia/services/selectedCatergory.dart';



class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<SelectedCatergory> _post = <SelectedCatergory>[];
  List<SelectedCatergory> _postDisplay = <SelectedCatergory>[];
  bool _isLoading =true;

  @override
  void initState() {
    fetchSelectedCatergory().then((val) {
      setState(() {
        _isLoading = false;
        _post.addAll(val);
        _postDisplay =_post;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Kcolor,
        title: Text(
          "Test",
        ),),
      body: Container(
        child: Text(
          _postDisplay.toString()
        ),
      ),
    );
  }
}
