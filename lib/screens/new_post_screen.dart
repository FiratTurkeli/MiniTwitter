import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/constants.dart';
import 'package:manoo/constant/text_style.dart';
import 'package:manoo/models/post_model.dart';
import 'package:manoo/screens/tabs_page.dart';
import 'package:manoo/services/auth_methods.dart';
import 'package:manoo/services/storage_services.dart';
import 'package:manoo/widgets/rounded_button.dart';
import 'package:uuid/uuid.dart';
import '../constant/utils.dart';

class NewPostScreen extends StatefulWidget {

  const NewPostScreen({ Key? key,}) : super(key: key);
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _file;
  bool isLoading = false;
  final TextEditingController textController = TextEditingController();
  var userData ={};

  @override
  void initState() {
    super.initState();
    getData();
    _auth;
  }

  getData() async {
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






  handleImageFromGallery() async {
    try {
      final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      File file = File(imageFile!.path);
      if (imageFile != null) {
        setState(() {
          _file = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Post',
          style: style1
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                maxLength: 280,
                maxLines: 7,
                cursorColor: white,
                style: const TextStyle(color: white),
                decoration: const InputDecoration(
                  suffixStyle: TextStyle(color: white),
                  hintStyle: style2,
                  counterStyle: TextStyle(color: white),
                  hintText: 'Enter your Post..',
                  fillColor: white,
                  focusColor: white,
                  hoverColor: white,
                  iconColor: white,
                  prefixIconColor: white,
                  suffixIconColor: white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary)
                  ),
                ),
                onChanged: (value) {
                  textController.text = value;
                },
              ),
              const SizedBox(height: 10),
              _file == null
                  ? const SizedBox.shrink()
                  :
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: primaryLight,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(_file!),
                        )),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              GestureDetector(
                onTap: handleImageFromGallery,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white,
                    border: Border.all(
                      color: white,
                      width: 2,
                    ),

                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                btnText: 'New Post',
                onBtnPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (textController.text.isNotEmpty) {
                    String res = "Some error occurred";
                    String? image;
                    if (_file == null) {
                      image =  null;
                    } else {
                      image =
                      await StorageService.uploadTweetPicture(_file!);
                    }
                    String postId = const Uuid().v1();



                    Post post = Post(
                        authorId: _auth.currentUser!.uid,
                        id: postId,
                        text: textController.text,
                        image: image,
                        datetime: DateTime.now(),
                      profilePicture: userData["profilePicture"],
                      nickName: userData["nickName"],
                      userName: userData["userName"]
                    );

                    postsRef.doc(postId).set(post.toJson());
                    res = "success";
                    Navigator.pop(context);

                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              const SizedBox(height: 20),
              isLoading ? const CircularProgressIndicator() : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("User: ${userData["userName"]}" , style: style1,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChangeUser("Fırat", "firattest@social.com", "123456"),
                  ChangeUser("Manoo", "manoo@social.net", "123456"),
                  ChangeUser("Shakira", "ert@gmail.com", "123456"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget ChangeUser(String name, String email, String password){
    return GestureDetector(
      onTap:() async {
        await AuthMethods().signOut().whenComplete(() => AuthMethods().loginUser(email: email, password: password) );
        setState(() {
          getData();
          Navigator.pop(context);
        });
       ;
      },
      child: Column(
        children:  [
          const Icon(Icons.person, color: white, size: 50,),
          Text(name , style: style2,)
        ],
      ),
    );
  }
}