import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manoo/widgets/post_container.dart';


class AllPosts extends StatefulWidget {
  const AllPosts({Key? key, }) : super(key: key);

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: StreamBuilder(
       stream: FirebaseFirestore.instance.collection('posts').orderBy("datetime" , descending: true).snapshots(),
       builder: (context,
           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         return ListView.builder(
           itemCount: snapshot.data!.docs.length,
           itemBuilder: (ctx, index) => PostContainer(snap: snapshot.data!.docs[index], user: false,),
         );
       },
     ),
    );
  }
}
