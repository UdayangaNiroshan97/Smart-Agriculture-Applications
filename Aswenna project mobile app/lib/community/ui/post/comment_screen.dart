import 'package:aswenna/community/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String username;
  final DateTime postDate;
  final String userId;
  final String content;
  final String imageLink;
  final int likes;
  final String postId;

  const CommentScreen(
      {Key key,
       this.username,
       this.postDate,
       this.userId,
       this.content,
       this.imageLink,
       this.likes,
       this.postId})
      : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final _formKey = GlobalKey<FormState>();
  final _dbService = Database();

  String comment;




  void _commentSection() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      validator: (value) => value.isEmpty ? "Comment cannot be empty" : null,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed:() {
                    _onSubmit();
                  },
                  icon: Icon(Icons.add_comment_outlined)),
            ],
          ),
        ),
      );
    });
  }

  void _onSubmit() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      try {
        final commented = await _dbService.createComment(comment, widget.postId);

        if (commented) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Comment added', style: TextStyle(
              color: Colors.white,
            ),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[600],
          ));
          Navigator.pop(context);
        } else throw 'Comment Error. Try again later';
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(
            color: Colors.white,
          ),),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red[600],
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int likes = widget.likes;

    return Scaffold(
      backgroundColor: Color(0xFF00695C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: size.height * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.username,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(widget.postDate.toString().substring(0,16),),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.content,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      SizedBox(height: 12,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            widget.imageLink,
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.9,
                            fit: BoxFit.fill,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _commentSection();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.comment_outlined,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text("Comment"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(width: size.width * 0.9, child: Divider(height: 1, color: Colors.grey[400], thickness: 1,)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<QuerySnapshot>(
                  future: _dbService.getComment(widget.postId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
                      return ListView.builder(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
                            child: ListTile(
                              title: Text(snapshot.data.docs[index]['student_name'],style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),),
                              subtitle: Text(snapshot.data.docs[index]['commentT']),
                            ),
                          );
                        },
                      );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
