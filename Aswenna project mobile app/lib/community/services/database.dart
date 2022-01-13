import 'package:aswenna/community/model/comment.dart';
import 'package:aswenna/community/model/member.dart';
import 'package:aswenna/community/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  FirebaseFirestore _cloud = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Todo: Create user into database
  Future<bool> createMember(
      String uid, String username, String email) async {
    try {
      Map<String, dynamic> data =
          Member(uid, username, email).toJson();
      await _cloud.collection('Member').doc(uid).set(data);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //getUserProfile
  Future<Member> getUserProfile(String uid) async {
    try {
      DocumentSnapshot data = await _cloud.collection('Member').doc(uid).get();

      if (data.exists) {
        return Member.fromJson(data.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  //---------------------------------------Post Database--------------------------------------------------------//
  Future<bool> createPost(
      String id, String username, String content, String downloadedLink) async {
    try {
      Map<String, dynamic> data = Post(
              '${DateTime.now().toString().substring(0, 19)} $id',
              id,
              username,
              content,
              DateTime.now(),
              downloadedLink)
          .toJson();
      await _cloud
          .collection('Post')
          .doc('${DateTime.now().toString().substring(0, 19)} $id')
          .set(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //get self post
  //use Future Builder to get the data
  Future getPost() async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Post')
          .where('username', isEqualTo: _auth.currentUser.uid)
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }

  //need to get the data.
  Future<QuerySnapshot> getAllPost() async {
    try {
      QuerySnapshot result = await _cloud.collection('Post').get();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deletePost(DateTime date, String id) async {
    try {
      _cloud.collection('Post').doc('${date.toString()} $id').delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void like(String postId) {
    try {
      Map<String, dynamic> data = {
        'likes': FieldValue.increment(1),
      };
      _cloud.collection('Post').doc(postId).update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> createComment(String comment, String postId) async {
    try {
      Map<String, dynamic> data = PComment(
              '${DateTime.now().toString().substring(0, 19)} ${_auth.currentUser.uid}',
              _auth.currentUser.displayName,
              comment,
              postId,
              DateTime.now())
          .toJson();

      await _cloud
          .collection('Post')
          .doc(postId)
          .collection('Comment')
          .doc(
              '${DateTime.now().toString().substring(0, 19)} ${_auth.currentUser.displayName}')
          .set(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<QuerySnapshot> getComment(String postId) async {
    try {
      final result = await _cloud
          .collection('Post')
          .doc(postId)
          .collection('Comment')
          .get();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
