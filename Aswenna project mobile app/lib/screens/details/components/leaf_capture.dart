import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class CaptureLeaf extends StatefulWidget {
  @override
  _CaptureState createState() => _CaptureState();
}
class _CaptureState extends State<CaptureLeaf> {
  /// Variables
  File imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xFF00695C),
          title: Text("Take a Leaf Picture"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    height: 100,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image(image: AssetImage("assets/images/capture2.png"),),
                        ),
                        Container(
                            child: Text("   Take a picture", style: TextStyle(fontSize: 20.0),)
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    height: 100,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image(image: AssetImage("assets/images/capture1.png"),),
                        ),
                        Container(
                            child: Text("   See diagnosis", style: TextStyle(fontSize: 20.0),)
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    height: 100,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image(image: AssetImage("assets/images/capture3.png"),),
                        ),
                        Container(
                            child: Text("   Get medicine", style: TextStyle(fontSize: 20.0),)
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40.0,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height:MediaQuery.of(context).size.width * 0.1,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft:Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text(
                            "Pick from gallery",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/ 2,
                        height:MediaQuery.of(context).size.width/ 10,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft:Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: Text(
                            "Pick from camera",
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
            ): Container(
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            )));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}