import 'package:flutter/material.dart';
import 'package:aswenna/screens/details/details_screen.dart';

import '../../../constants.dart';

class FieldCrops extends StatelessWidget {
  const FieldCrops({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          FieldCropsCard(
            image: "assets/images/corn.png",
            title: "Corn",
            scin_name: "Zea mays",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(crop: "Corn"),
                ),
              );
            },
          ),
          FieldCropsCard(
            image: "assets/images/tomato.png",
            title: "Tomato",
            scin_name: "Solanum lycopersicum",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(crop: "Tomato"),
                ),
              );
            },
          ),
          FieldCropsCard(
            image: "assets/images/potato.png",
            title: "Potato ",
            scin_name: "Solanum tuberosum",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(crop: "Potato"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FieldCropsCard extends StatelessWidget {
  const FieldCropsCard({
    Key key,
    this.image,
    this.title,
    this.scin_name,
    this.press,
  }) : super(key: key);

  final String image, title, scin_name;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,

      ),
      width: size.width * 0.43,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$scin_name".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
