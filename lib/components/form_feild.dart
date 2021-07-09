import 'package:flutter/material.dart';
import 'package:reviewia/constrains/constrains.dart';

class FormFeild extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String name;
  final String type;

  String chageFeild(String val){
      return val;
  }
  FormFeild({required this.name, required this.type,required this.onChanged});

  bool _canEdit = false;

  @override
  _FormFeildState createState() => _FormFeildState();
}

class _FormFeildState extends State<FormFeild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 280 / 360,
      decoration: BoxDecoration(
        color: Color(0xFFC4C4C4),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height *
                        5 /
                        659,
                    left: MediaQuery.of(context).size.width *
                        10 /
                        360),
                child: Text(
                  widget.type+" :",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Kcolor,
                  ),
                ),
              )),
          Expanded(
            flex: 6,
            child: TextFormField(
              readOnly: widget._canEdit,
              decoration: InputDecoration(
                hintText: widget.name,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                prefixStyle: TextStyle(
                  fontSize: 15,
                  color: Kcolor,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      widget._canEdit = !widget._canEdit;
                    });
                  },
                ),
              ),
              onChanged: (val) {
                if(widget.type=='Name'){
                  widget.chageFeild(val);
                }
                widget.onChanged(val);
                print(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
