import 'dart:io';
import 'package:manoo/services/storage_services.dart';

import '../models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String text,
      File file,
      String uid,
      String username,
      String profImage,
      String userName,
      String nickName,
      ) async {

    String res = "Some error occurred";
    try {
      String photoUrl = await StorageService.uploadTweetPicture(file);
      String postId = const Uuid().v1();
      Post post = Post(
          id: postId,
          authorId: uid,
          text: text,
          image: photoUrl,
          datetime: DateTime.now(),
        profilePicture: profImage,
        userName: userName,
        nickName: nickName
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


}