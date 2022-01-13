import 'package:aswenna/screens/details/components/pest_capture.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

// ignore: camel_case_types
class pest_details extends StatelessWidget {
  pest_details({
    Key key,
    this.name,
    this.description,
    // ignore: non_constant_identifier_names
    this.befor_inflect,
    // ignore: non_constant_identifier_names
    this.after_inflect,
    // ignore: non_constant_identifier_names
    this.Pesticides,
    this.images,
  }) : super(key: key);
  // ignore: non_constant_identifier_names
  final String name,description,befor_inflect,after_inflect,Pesticides;
  final images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        title: Text("Pest Identification"),
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
                        child: Image.file(
                          images,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 12,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          name,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Before The Inflect",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        befor_inflect,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "After The Inflect",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        after_inflect,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pesticides",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Pesticides,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
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
