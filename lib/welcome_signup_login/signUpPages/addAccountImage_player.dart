import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class addAccountImage_player extends StatefulWidget {
  @override
  State<addAccountImage_player> createState() => _addAccountImage_playerState();
}

class _addAccountImage_playerState extends State<addAccountImage_player> {
  File? imgPath;
  String? profileImage;

  Future<void> uploadImage(String filePath) async {
    final File file = File(filePath);
    final storage = Supabase.instance.client.storage.from('photo');
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    try {
      final Uint8List fileBytes = await file.readAsBytes();
      final response = await storage.uploadBinary(fileName, fileBytes);

      if (response.isNotEmpty) {
        print('✅ Image uploaded successfully');
        setState(() {
          profileImage = storage.getPublicUrl(fileName);
        });
      } else {
        print('Upload image failed: Empty response');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
        await uploadImage(pickedImg.path);
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Photo Library',
                  style: TextStyle(fontFamily: "eras-itc-bold", fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  uploadImage2Screen(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  'Camera',
                  style: TextStyle(fontFamily: "eras-itc-bold", fontSize: 15),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await uploadImage2Screen(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("account picture",
              style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              )),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login_signup_player');
            },
            icon: Image.asset(
              "assets/welcome_signup_login/imgs/back.png",
              color: Color(0xFF000000),
            ),
          ),
          toolbarHeight: 80.0,
          elevation: 0,
          backgroundColor: Color(0x00),
        ),
        body: Stack(
          children: [
            backgroundImage_balls,
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Center(
                    child: Container(
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
                                  backgroundColor:
                                      Color.fromARGB(255, 225, 225, 225),
                                  radius: 77.0,
                                  backgroundImage: AssetImage(
                                      "assets/welcome_signup_login/imgs/avatar.png"),
                                )
                              : ClipOval(
                                  child: Image.file(imgPath!,
                                      width: 154.0,
                                      height: 154.0,
                                      fit: BoxFit.cover),
                                ),
                          Positioned(
                            bottom: -6,
                            right: -1,
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: mainColor,
                                ),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showImageSourceActionSheet(context);
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
                  ),
                  SizedBox(height: 164.0),
                  SizedBox(
                    height: 50.0,
                    child: Create_GradiantGreenButton(
                      content: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontFamily: "eras-itc-bold", fontSize: 24.0),
                      ),
                      onButtonPressed: () {
                        if (imgPath != null) {
                          Navigator.pushNamed(context, '/sign_up_pg2_player');
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Incomplete Information'),
                                content: Text('Please upload an image.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
