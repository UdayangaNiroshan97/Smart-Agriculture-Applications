import 'package:flutter/material.dart';
import 'package:aswenna/community/services/database.dart';

class PostDetail extends StatefulWidget {
  final VoidCallback onPress;
  final String username;
  final DateTime postDate;
  final String userId;
  final String content;
  final String imageLink;
  final int like;
  final String postId;

  const PostDetail(
      {Key key,
       this.onPress,
       this.userId,
       this.username,
       this.postDate,
       this.content,
       this.imageLink,
       this.like,
       this.postId,})
      : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final _dbService = Database();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    int likes = widget.like;

    return Card(
      elevation: 1.0,
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
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
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: widget.onPress,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.comment_outlined,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
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
          )),
    );
  }
}
