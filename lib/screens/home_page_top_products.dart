import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/components/selction_card.dart';
import 'package:reviewia/constrains/constrains.dart';
import 'package:search_choices/search_choices.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomePageTopProducts extends StatefulWidget {
  const HomePageTopProducts({Key? key}) : super(key: key);

  @override
  _HomePageTopProductsState createState() => _HomePageTopProductsState();
}

class _HomePageTopProductsState extends State<HomePageTopProducts> {
  List<String> locations = ["1","2","3","4","5"];
  String? selectedValueSingleDialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.015),
                  child: CupertinoSearchTextField(
                    padding: EdgeInsets.all(20),
                    placeholder: "Search Here",

                  )),
              Container(
                // margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.020),
                height: MediaQuery.of(context).size.height*0.1485,
                child: ListView(
                  padding: EdgeInsets.all(15),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SelectionCard(title: "Products"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    SelectionCard(title: "Services"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    SelectionCard(title: "Most Viewed"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                    SelectionCard(title: "My posts"),
                    Divider(
                      indent: 12,
                      thickness: 25,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.015),

                child: Text(
                  'Most Recent Posts',
                  style: KReviewiaMostTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Scrollbar(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: locations.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return ProductCard();
                    }),
              ),

              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),

            ],
          ),
        ),
      ),
    ));
  }
}

