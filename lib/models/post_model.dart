import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String authorId;
  String text;
  String? image;
  DateTime datetime;
  String profilePicture;
  String userName;
  String nickName;


  Post(
      {required this.id,
        required this.authorId,
        required this.text,
        required this.image,
        required this.datetime,
        required this.profilePicture,
        required this.userName,
        required this.nickName,

      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        id: snapshot["uid"],
        authorId: snapshot["authorId"],
        text: snapshot["text"],
        image: snapshot['text'],
        datetime: snapshot['datetime'],
      profilePicture: snapshot["profilePicture"],
      userName: snapshot["userName"],
      nickName: snapshot["nickName"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "authorId": authorId,
    "text": text,
    "image": image,
    "datetime": datetime,
    "profilePicture": profilePicture,
    "userName": userName,
    "nickName": nickName
  };
}