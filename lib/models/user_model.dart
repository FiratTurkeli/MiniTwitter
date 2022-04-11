import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String? profilePicture;
  String email;
  String id;


  UserModel(
      {required this.name,
        required this.profilePicture,
        required this.email,
        required this.id
    });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot["userName"],
      email: snapshot["nickName"],
      profilePicture: snapshot["profilePicture"],
      id: snapshot['id']

    );
  }

  Map<String, dynamic> toJson() => {
    "userName": name,
    "nickName": email,
    "profilePicture": profilePicture,
    'id' : id

  };
}