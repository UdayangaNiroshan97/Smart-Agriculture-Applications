import 'dart:async';
import 'package:aswenna/screens/details/components/cul_tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Cultivation_tips extends StatelessWidget {
  Cultivation_tips({
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
        title: Text("Cultivation Tips"),
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
                      width: size.width*0.5,
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
                          connectToServer(crop,"plant_selection",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.nature, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Plant Selection', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      height: size.height*0.21,
                      width: size.width*0.5,
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
                          connectToServer(crop,"site_selection",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.pin_drop_outlined, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Site Selection', style: TextStyle(color:Colors.black),),
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
                      width: size.width*0.5,
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
                          connectToServer(crop,"field_preparation",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.agriculture_rounded, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Field Preparation', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      height: size.height*0.21,
                      width: size.width*0.5,
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
                          connectToServer(crop,"planting",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.nature_people_outlined, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Planting', style: TextStyle(color:Colors.black),),
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
                      width: size.width*0.5,
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
                          connectToServer(crop,"weeding",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.spa_outlined, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Weeding', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      height: size.height*0.21,
                      width: size.width*0.5,
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
                          connectToServer(crop,"irrigation",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.water_damage, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Irrigation', style: TextStyle(color:Colors.black),),
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
                      width: size.width*0.5,
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
                          connectToServer(crop,"fertilization_chemical",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.sanitizer_rounded, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Fertilization Chemical', style: TextStyle(color:Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      height: size.height*0.21,
                      width: size.width*0.5,
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
                          connectToServer(crop,"harvesting",context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.local_florist_outlined, color: kPrimaryColor,size: 80),
                            Spacer(),
                            Text('Harvesting', style: TextStyle(color:Colors.black),),
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


  connectToServer(String crop_name,String function,context)async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    String function_name, image;
    switch(function){
      case "plant_selection":  function_name = "Plant Selection"; image = "assets/images/plant_selection.png"; break;
      case "site_selection":  function_name = "Site Selection"; image = "assets/images/SiteSelection.png";break;
      case "field_preparation":  function_name = "Field Preparation"; image = "assets/images/FieldPreparation.png";break;
      case "planting":  function_name = "Planting"; image = "assets/images/Planting.png";break;
      case "weeding":  function_name = "Weeding"; image = "assets/images/Weeding.png";break;
      case "irrigation":  function_name = "Irrigation"; image = "assets/images/irrigation.png";break;
      case "fertilization_chemical":  function_name = "Fertilization Chemical"; image = "assets/images/chemicalfertilizers.png";break;
      case "harvesting":  function_name = "Harvesting"; image = "assets/images/harvesting.png";break;
    }

    await FirebaseFirestore.instance.collection("cultivation_tips")
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
          builder: (context)=> Cult_tips(function: function_name,details : obj[function], image: image, )
      ));
    }
  }
}


