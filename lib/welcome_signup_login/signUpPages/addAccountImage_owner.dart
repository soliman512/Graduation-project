import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
// import 'package:graduation_project_main/welcome_signup_login/signUpPages/signup_pg2_player.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:provider/provider.dart';

class addAccountImage_owner extends StatefulWidget {
  @override
  State<addAccountImage_owner> createState() => _addAccountImage_ownerState();
}

class _addAccountImage_ownerState extends State<addAccountImage_owner> {
  File? imgPath;
  String? imageUrl; // URL of the uploaded image
  bool isImageSelected = false;
  bool isUploading = false;

  // choose image from camera or gallery and upload to Supabase
  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          isUploading = true;
        });

        // Upload to Supabase
        await uploadImageToSupabase(File(pickedImg.path));
      } else {
        print("No image selected");
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      print("Error => $e");
    }
  }

  // Upload image to Supabase and get public URL
  Future<void> uploadImageToSupabase(File imageFile) async {
    try {
      final SupabaseClient supabase = Supabase.instance.client;
      // Generate a unique filename using UUID
      final String uniqueFileName = '${Uuid().v4()}.png';

      // Upload the image to Supabase storage
      final String fullPath = await supabase.storage.from('photo').upload(
            'public/$uniqueFileName',
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      // Get the public URL of the uploaded image with cache-busting parameter
      String url =
          supabase.storage.from('photo').getPublicUrl('public/$uniqueFileName');
      // Add a timestamp parameter to prevent caching issues
      url = '$url?t=${DateTime.now().millisecondsSinceEpoch}';

      print('Image uploaded successfully. URL: $url');

      setState(() {
        imageUrl = url;
        isImageSelected = true;
        isUploading = false;
      });
    } catch (e) {
      print('Error uploading image to Supabase: $e');
      setState(() {
        isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Provider.of<LanguageProvider>(context, listen: false).isArabic
                ? 'خطأ في تحميل الصورة: $e'
                : 'Error uploading image: $e',
            style: TextStyle(fontFamily: 'eras-itc-bold'),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // show image source action sheet
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
                  Provider.of<LanguageProvider>(context).isArabic
                      ? 'مكتبة الصور'
                      : 'Photo Library',
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
                  Provider.of<LanguageProvider>(context).isArabic
                      ? 'الكاميرا'
                      : 'Camera',
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
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isArabic ? 'صورة الحساب' : 'Account Picture',
            style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign_up_pg1_stdowner');
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
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      // Profile Image Container
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Main Circle Container
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: mainColor,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: mainColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: imgPath == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.account_circle,
                                            size: 80,
                                            color: mainColor.withOpacity(0.5),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            isArabic
                                                ? 'اضغط لإضافة صورة'
                                                : 'Tap to add photo',
                                            style: TextStyle(
                                              color: mainColor.withOpacity(0.7),
                                              fontSize: 12,
                                              fontFamily: isArabic
                                                  ? 'Cairo'
                                                  : 'eras-itc-light',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Image.file(
                                      imgPath!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          // Add Photo Button (Bottom Right)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: greenGradientColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: mainColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () =>
                                      showImageSourceActionSheet(context),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Upload Progress Indicator
                          if (isUploading)
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 40),
                      // Next Button
                      SizedBox(
                        height: 50.0,
                        child: Create_GradiantGreenButton(
                          content: Text(
                            isArabic ? 'التالي' : 'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "eras-itc-bold",
                              fontSize: 24.0,
                            ),
                          ),
                          onButtonPressed: () {
                            if (isUploading) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isArabic
                                        ? 'جاري تحميل الصورة، يرجى الانتظار...'
                                        : 'Image is uploading, please wait...',
                                    style:
                                        TextStyle(fontFamily: 'eras-itc-bold'),
                                  ),
                                  backgroundColor: Colors.orange,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (isImageSelected && imageUrl != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup_pg2_StdOwner(
                                      profileImage: imageUrl),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isArabic
                                        ? 'الرجاء اختيار صورة للملف الشخصي'
                                        : 'Please select a profile image',
                                    style:
                                        TextStyle(fontFamily: 'eras-itc-bold'),
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
