import 'package:aswenna/screens/details/ftauters/cultivation_tips.dart';
import 'package:aswenna/screens/details/ftauters/fertilizer.dart';
import 'package:aswenna/screens/details/ftauters/pest_diseases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

class ImageAndIcons extends StatelessWidget {
  ImageAndIcons({
    Key key,
    this.crop,
    this.crop_image,
    @required this.size,
  }) : super(key: key);
  final String crop,crop_image;
  final Size size;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: SizedBox(
        height: size.height * 0.8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 3),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: size.width*0.2,
                      width: size.width*0.35,
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 15),
                            blurRadius: 10,
                            color: kPrimaryColor.withOpacity(0.22),
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        color: kBackgroundColor,
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> Cultivation_tips(crop: crop)
                          ));
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.agriculture_outlined, color: kPrimaryColor,size: 40),
                            Spacer(),
                            Text('Cultivation Tips ', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.width*0.2,
                      width: size.width*0.35,
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 15),
                            blurRadius: 10,
                            color: kPrimaryColor.withOpacity(0.22),
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        color: kBackgroundColor,
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> Pests_Diseases(crop: crop)
                          ));
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.pest_control_outlined, color: kPrimaryColor,size: 40),
                            Spacer(),
                            Text('Pests & Diseases ', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.8,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(63),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: kPrimaryColor.withOpacity(0.29),
                  ),
                ],
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                  image: AssetImage(crop_image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
