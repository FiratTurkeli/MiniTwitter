
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/constants.dart';
import 'package:manoo/constant/text_style.dart';
import 'package:manoo/screens/update_profile_screen.dart';
import '../constant/utils.dart';
import '../widgets/post_container.dart';
import 'new_post_screen.dart';

class UserPosts extends StatefulWidget {


  const UserPosts({Key? key,}) : super(key: key);


  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final TextEditingController textController = TextEditingController();
  late var userData ={};


  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();


      userData  = userSnap.data()!;


    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryLight,
        centerTitle: true,
        title:  Text(userData["userName"] ?? "Username", style: style2,),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
          }, icon: const Icon(Icons.edit)),
          CircleAvatar(foregroundImage: NetworkImage(userData["profilePicture"] ?? "https://frspros.com/images/easyblog_shared/July_2018/7-4-18/b2ap3_large_totw_network_profile_400.jpg") ,),
        ],
      ),
      backgroundColor: primary,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('datetime', descending: true).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } if (userData == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) =>
                snapshot.data!.docs[index]["authorId"].toString() == _auth.currentUser!.uid.toString() ?
                PostContainer(snap: snapshot.data!.docs[index], user: true,)
                    :const Center()
          );
        },
      ),





      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(),
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPostScreen()));
        },
        child: const Icon(Icons.post_add_sharp, color: white,),
      ),
    );
  }


}
