import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/text_style.dart';
import 'package:manoo/services/firebase_methods.dart';
import 'package:manoo/widgets/rounded_button.dart';

import '../constant/constants.dart';
import '../constant/utils.dart';
import '../services/storage_services.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _file;
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  var userData ={};


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

  @override
  void initState() {
    super.initState();
    getData();
    _auth;
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
            'Update Profile',
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
                maxLength: 30,
                maxLines: 2,
                cursorColor: white,
                style: const TextStyle(color: white),
                decoration: const InputDecoration(
                  suffixStyle: TextStyle(color: white),
                  hintStyle: style2,
                  counterStyle: TextStyle(color: white),
                  hintText: 'Enter your Name..',
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
                  nameController.text = value;
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
                btnText: 'Update Profile',
                onBtnPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (nameController.text.isNotEmpty) {
                    String res = "Some error occurred";
                    String? image;
                    if (_file == null) {
                      image =  null;
                    } else {
                      image =
                      await StorageService.uploadProfilePicture(_file!);
                    }

                    FireStoreMethods().updateProfile( _file, nameController.text, userData["id"], userData["profilePicture"]).whenComplete(() =>
                        Navigator.pop(context)
                    );
                    res = "success";

                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
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
}
