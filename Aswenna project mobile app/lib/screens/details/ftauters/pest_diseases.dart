import 'package:aswenna/components/my_bottom_nav_bar.dart';
import 'package:aswenna/screens/details/components/pest_disease_stage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Pests_Diseases extends StatelessWidget {
  Pests_Diseases({
    Key key,
    this.crop,
  }) : super(key: key);
  final String crop;

  Map<String, dynamic> obj;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        title: Text("Pests And Diseases"),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child:Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        height: size.height*0.21,
                        width: size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 0.75),
                              blurRadius: 5,
                              color: kPrimaryColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: kBackgroundColor,
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          onPressed: () {
                            connectToServer_pest_diseases(crop,'seeding_stage',context);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.spa_outlined, color: kPrimaryColor,size: 80),
                              Spacer(),
                              Text('Seeding Stage', style: TextStyle(color:Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        height: size.height*0.21,
                        width: size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 0.75),
                              blurRadius: 5,
                              color: kPrimaryColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: kBackgroundColor,
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          onPressed: () {
                            connectToServer_pest_diseases(crop,'vegetative_stage',context);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.nature, color: kPrimaryColor,size: 80),
                              Spacer(),
                              Text('Vegetative Stage', style: TextStyle(color:Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        height: size.height*0.21,
                        width: size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 0.75),
                              blurRadius: 5,
                              color: kPrimaryColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: kBackgroundColor,
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          onPressed: () {
                            connectToServer_pest_diseases(crop,'flowering_stage',context);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.local_florist, color: kPrimaryColor,size: 80),
                              Spacer(),
                              Text('Flowering Stage', style: TextStyle(color:Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        height: size.height*0.21,
                        width: size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 0.75),
                              blurRadius: 5,
                              color: kPrimaryColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: kBackgroundColor,
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          onPressed: () {
                            connectToServer_pest_diseases(crop,'harvesting_stage',context);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.agriculture_rounded, color: kPrimaryColor,size: 80),
                              Spacer(),
                              Text('Harvesting Stage', style: TextStyle(color:Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }

  connectToServer_pest_diseases(String crop_name,String stage,context)async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    String stage_name, image;
    switch(stage){
      case "seeding_stage":  stage_name = "Seeding Stage"; image = "assets/images/Seeding.png";break;
      case "vegetative_stage":  stage_name = "Vegetative Stage"; image = "assets/images/Vegetative.png";break;
      case "flowering_stage":  stage_name = "Flowering Stage"; image = "assets/images/flowering.png";break;
      case "harvesting_stage":  stage_name = "Harvesting Stage"; image = "assets/images/harvestingdisease.png";break;
    }
    await FirebaseFirestore.instance.collection("pest_&_diseases")
        .where("crop_name", isEqualTo: crop_name)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        obj = result.data();
        print(obj);
      });
    });
    print(obj['crop_name']);
    if (obj['crop_name'] != ''){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=> pest_disease_stage(stage: stage_name,details : obj[stage], image: image, )
      ));
    }
  }
}
