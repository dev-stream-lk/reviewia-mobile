import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reviewia/components/image_box.dart';
import 'package:reviewia/constrains/constrains.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          print("Hello");
        },
        child: Container(
          height: 280,
          margin: EdgeInsets.only(bottom: 10, top: 10),
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
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),

                  // color:Colors.blueGrey,
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFC494C4),
                          backgroundImage: AssetImage('images/loginImage.png'),
                          radius: MediaQuery.of(context).size.width*20/360,
                        ),
                      ),
                      Expanded(flex: 3, child: Text("Chamari Wikrmawardna",style:KPostCard)),
                      Expanded(
                          flex: 1, child: Icon(Icons.settings))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: Color(0xFFCCDCF3),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/loginImage.png'),
                        fit: BoxFit.cover,
                      )
                  ) ,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Color(0xFFAAAAAA),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Row(


                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
