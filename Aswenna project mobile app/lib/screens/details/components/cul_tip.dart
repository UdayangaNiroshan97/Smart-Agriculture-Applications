import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Cult_tips extends StatelessWidget {
  Cult_tips({
    Key key,
    this.function,
    this.details,
    this.image,
  }) : super(key: key);
  final String function,details,image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        title: Text(function),
      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image(
                        image: AssetImage(image),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      details,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}