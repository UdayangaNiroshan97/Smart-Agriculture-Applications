import 'dart:io';
import 'package:aswenna/community/services/auth.dart';
import 'package:aswenna/community/services/database.dart';
import 'package:aswenna/community/services/storage.dart';
import 'package:aswenna/community/ui/dashboard/community_home.dart';
import 'package:aswenna/screens/home/community.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  final _storage = StorageService();
  final _dbService = Database();
  final user = AuthService().memberDetail;

  String content;
  File _imageFile;
  String _urlDownload;

  _selectImage() async {
    //check permission first
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        //dart.io File, not dart.html
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('Photos permission is denied.');
    }
  }

  _onSubmit() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try{
        if (_imageFile == null) throw 'Image cannot be empty';
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(child: CircularProgressIndicator(),);
            });
        _urlDownload = await _storage.uploadImageToFirebasePost(_imageFile);
        if (_urlDownload == null) throw 'Getting uploaded file error. Please Try again';
        final created = await _dbService.createPost(user.uid, user.displayName, content, _urlDownload);

        if (created) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Post created successfully', style: TextStyle(
              color: Colors.white,
            ),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[600],
          ));
          //Navigator.pop(context);
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PostScreen()), (route) => false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Community()));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(
            color: Colors.white,
          ),),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red[600],
        ));
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF00695C),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            iconSize: 25,
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              width: size.width,
              height: size.height * 0.3 - 27,
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Community',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(""),
                    Text(
                      'Ask a question about your crop to receive help from the community',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white,fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            ),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              transform: Matrix4.translationValues(0, -36, 1),
              height: size.height * 0.1 - 27,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ask Community',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
            ),
            Container(
              width: size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Description'),
                          maxLines: 4,
                          onChanged: (value) {
                            setState(() {
                              content = value;
                            });
                          },
                          validator: (value) => value.isEmpty ? 'Description cannot be empty' : null,
                        ),
                      ),
                    ),
                    _imageFile == null ? Container(width: 0.0, height: 0.0) : ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image(
                        width: MediaQuery.of(context).size.width*0.75,
                        height: 150.0,
                        image: FileImage(_imageFile),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xFFE57373),
                              onSurface: Colors.red,
                              shadowColor: Color(0xFFE57373),
                              minimumSize: Size(size.width*0.75, 40.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                          onPressed: () {
                            _selectImage();
                          },
                          child: Text('Select an Image to Post')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE57373),
                              onPrimary: Colors.white,
                              onSurface: Colors.red,
                              shadowColor: Color(0xFFE57373),
                              minimumSize: Size(size.width*0.75, 40.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                          onPressed: () {
                            _onSubmit();
                          },
                          child: Text('Upload')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
