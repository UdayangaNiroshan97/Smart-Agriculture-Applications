import 'dart:io';
import 'dart:ui';
import 'package:aswenna/screens/details/components/pest_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CapturePest extends StatefulWidget {
  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<CapturePest> {
  /// Variables
  File imageFile;
  bool sucess= false;
  var background_color = Colors.black;
  Map<String, dynamic> obj;
  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xFF00695C),
          title: Text("Pest Identification"),
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
            ):
            Container(
              decoration: BoxDecoration(
                color: background_color,
              ),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding / 10),
                        height: MediaQuery.of(context).size.height*0.8,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            uploadImageToServer(imageFile, context);
                          },
                          color: Color(0xFF00695C),
                          textColor: Colors.white,
                          child: Icon(
                            Icons.upload_rounded,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }

  uploadImageToServer(File imageFile, context)async
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
    background_color = Colors.white;
    print("attempting to connect to server……");
    // ignore: deprecated_member_use
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('http://10.0.2.2:5000/prediction');
    print("connection established.");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType(‘image’, ‘png’));
    request.files.add(multipartFile);
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      await FirebaseFirestore.instance.collection("pest")
          .where("id", isEqualTo: responseString)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          obj = result.data();
          print(obj);
        });
      });
      print(obj['name']);
      if (obj['name'] != ''){
        File image = imageFile;
        imageFile = null;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=> pest_details(name:obj['name'],description:obj['description'],befor_inflect:obj['befor_inflect'],
            after_inflect:obj['after_inflect'],Pesticides:obj['Pesticides'],images:image)));
      }
    }
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
