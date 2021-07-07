import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginImage.png'),
            fit: BoxFit.cover,
          )
      ) ,
    );
  }
}
