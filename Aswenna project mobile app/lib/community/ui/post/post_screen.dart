import 'package:aswenna/community/services/database.dart';
import 'package:aswenna/community/ui/post/post_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_Post.dart';
import 'comment_screen.dart';

class PostScreen extends StatelessWidget {
  final _dbService = Database();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        leading: SizedBox(),
        // On Android it's false by default
        centerTitle: true,
        title: Text("Community"),
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: size.width * 0.95,
              height: size.height * 0.77,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: FutureBuilder<QuerySnapshot>(
                  future: _dbService.getAllPost(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) => PostDetail(
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CommentScreen(
                                      userId: snapshot.data.docs[index]
                                      ['userId'],
                                      content: snapshot.data.docs[index]
                                      ['content'],
                                      likes: snapshot.data.docs[index]
                                      ['likes'],
                                      imageLink: snapshot.data
                                          .docs[index]['downloadedLink'],
                                      postDate: (snapshot
                                          .data.docs[index]['date'])
                                          .toDate(),
                                      username: snapshot.data.docs[index]
                                      ['username'],
                                      postId: snapshot.data.docs[index]
                                      ['id'],
                                    )));
                          },
                          userId: snapshot.data.docs[index]['userId'],
                          content: snapshot.data.docs[index]['content'],
                          like: snapshot.data.docs[index]['likes'],
                          imageLink: snapshot.data.docs[index]
                          ['downloadedLink'],
                          postDate:
                          (snapshot.data.docs[index]['date']).toDate(),
                          username: snapshot.data.docs[index]['username'],
                          postId: snapshot.data.docs[index]['id'],
                        ));
                  }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddPost()));
        },
        backgroundColor: Color(0xFF00695C),
        child: Icon(Icons.add, color: Colors.white),

      ),
    );
  }
}
