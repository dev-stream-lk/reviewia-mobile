import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reviewia/components/product_card.dart';
import 'package:reviewia/constrains/constrains.dart';

class HomePageTopProducts extends StatefulWidget {
  const HomePageTopProducts({Key? key}) : super(key: key);

  @override
  _HomePageTopProductsState createState() => _HomePageTopProductsState();
}

class _HomePageTopProductsState extends State<HomePageTopProducts> {
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
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015),
                    child: Text(
                      'Most Viewed',
                      style: KReviewiaMostTitle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                ],
              ),
            ),
          ),
        ));
      }
    }
