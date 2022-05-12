import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/text_style.dart';

import '../constant/utils.dart';
import '../screens/tabs_page.dart';



class PostContainer extends StatefulWidget {

  DocumentSnapshot snap;
  bool? user;

  PostContainer({Key? key, required this.snap, required this.user})
      : super(key: key);
  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {

  bool isLoading = false;
  var userData ={};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.snap["authorId"])
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


    return buildPostContainer(
        userData["profilePicture"] ?? "https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png",
        userData["userName"] ?? "Username",
        userData["nickName"]  ?? "Nickname"
    );
  }

  Container buildPostContainer(String profilePicture, String userName, String nickName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                NetworkImage(profilePicture),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Text(
                      userName,
                      style: style2
                  ),
                  Text(
                    "  @${nickName}",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),

                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
                widget.snap['text'].toString(),
                style: style3
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                widget.snap['image'] == null ?
                const Center()
                    : Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.snap['image'].toString()),
                      )),
                )


              ],
            ),
          ),
          const SizedBox(height: 15),
          widget.user == true ?
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: IconButton(onPressed: (){
              widget.snap.reference.delete().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TabsPage())));
            }
                , icon: const Icon(Icons.delete_rounded, color:  Colors.white,)),
          ):
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    );
  }


}








