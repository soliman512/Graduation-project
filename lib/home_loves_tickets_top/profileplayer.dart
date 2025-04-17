import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/data_from_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePlayer extends StatefulWidget {
  ProfilePlayer({Key? key}) : super(key: key);

  @override
  State<ProfilePlayer> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePlayer> {
  File? imgPath;
  final credential = FirebaseAuth.instance.currentUser;

  // upload image
  uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff005706),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login_player');
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: mainColor,
                      width: 1.5,
                    )),
                child: Stack(
                  children: [
                    imgPath == null
                        ? CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 225, 225, 225),
                            radius: 77.0,
                            backgroundImage: AssetImage(
                                "assets/welcome_signup_login/imgs/avatar.png"),
                          )
                        : ClipOval(
                            child: Image.file(imgPath!,
                                width: 154.0, height: 154.0, fit: BoxFit.cover),
                          ),
                    Positioned(
                      bottom: -6,
                      right: -1,
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: mainColor,
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            uploadImage2Screen();
                          },
                          icon: Icon(Icons.add_a_photo),
                          iconSize: 20,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 11,
                  ),
                  Text("Email: ${credential!.email}",
                      style:
                          TextStyle(fontSize: 15, fontFamily: "eras-itc-bold")),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                      "Created date: ${DateFormat('MMMM-d-y').format(credential!.metadata.creationTime!.toLocal())}",
                      style:
                          TextStyle(fontSize: 15, fontFamily: "eras-itc-bold")),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                      "Last Signed In: ${DateFormat('MMMM-d-y').format(credential!.metadata.lastSignInTime!.toLocal())}",
                      style:
                          TextStyle(fontSize: 15, fontFamily: "eras-itc-bold")),
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Center(
                  child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              GetDataFromFirestore(documentId: credential!.uid),
            ],
          ),
        ),
      ),
    );
  }
}
