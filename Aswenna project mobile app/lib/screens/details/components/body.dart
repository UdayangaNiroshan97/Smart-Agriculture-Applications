import 'package:aswenna/screens/details/components/leaf_capture.dart';
import 'package:aswenna/screens/details/components/pest_capture.dart';
import 'package:flutter/material.dart';
import 'package:aswenna/constants.dart';

import 'image_and_icons.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    this.crop,
  }): super(key: key);
  final String crop;

  var crop_image;
  String cover_image(){
    switch(crop){
      case "grape":{crop_image= "assets/images/grape_details.png";break; }
      case "mango":{crop_image= "assets/images/mango_details.png";break; }
      case "Citrus":{crop_image= "assets/images/citrus_details.png";break; }
      case "Corn":{crop_image= "assets/images/corn_details.png";break; }
      case "Tomato":{crop_image= "assets/images/tomato_details.png";break; }
      case "Potato":{crop_image= "assets/images/potato_details.png";break; }
    }
    return crop_image;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size,crop: crop, crop_image : cover_image()),
          SizedBox(height: kDefaultPadding),
          Row(
            children: <Widget>[
              Container(
                width: size.width,
                height:size.height / 10,
                padding: EdgeInsets.only(
                  left: 2.5,
                  right: 2.5,
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CapturePest(),
                    ),
                    );
                  },
                  child: Text(
                    "Take a pest Picture",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
