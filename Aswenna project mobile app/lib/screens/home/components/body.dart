import 'package:aswenna/screens/home/components/EconomicCrops.dart';
import 'package:aswenna/screens/home/components/FieldCrops.dart';
import 'package:flutter/material.dart';
import 'package:aswenna/constants.dart';

import 'header_with_seachbox.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "Field Crops", press: () {}),
          FieldCrops(),
          TitleWithMoreBtn(title: "Economic Crops", press: () {}),
          EconomicCrops(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
