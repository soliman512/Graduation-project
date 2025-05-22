import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';


class ProfilePlayer extends StatefulWidget {
  ProfilePlayer({Key? key}) : super(key: key);

  @override
  State<ProfilePlayer> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePlayer> {
  File? imgPath;
  User? user;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      fetchUserData();
    }
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          userData = docSnapshot.data();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('User document does not exist');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

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
  
  // Format date string to display properly
  String _formatDate(String dateString) {
    try {
      // Try to parse the date string directly
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      // If direct parsing fails, try different formats
      try {
        // Check if it's already in a readable format
        if (dateString.contains('-') || dateString.contains('/')) {
          return dateString;
        }
        
        // Try to handle timestamp format (if it's stored as milliseconds)
        if (dateString.length >= 10 && int.tryParse(dateString) != null) {
          int timestamp = int.parse(dateString);
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          return DateFormat('dd-MM-yyyy').format(dateTime);
        }
        
        // If all else fails, return the original string
        return dateString;
      } catch (e) {
        print("Error formatting date: $e");
        return dateString;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      final isArabic = context.watch<LanguageProvider>().isArabic;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isArabic ? "لا يوجد مستخدم مسجل" : "No user logged in",
                style: TextStyle(fontSize: 18, fontFamily: 'eras-itc-bold'),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: Create_GradiantGreenButton(
                  content: Text(
                    isArabic ? "اذهب للتسجيل" : "Go to Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'eras-itc-bold',
                        fontSize: 18.0),
                  ),
                  onButtonPressed: () {
                    Navigator.pushReplacementNamed(context, '/login_player');
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      final isArabic = context.watch<LanguageProvider>().isArabic;
      return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isArabic ? "الملف " : "Pro",
              style: TextStyle(
                fontSize: 23,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 122, 0),
              ),
            ),
            Text(
              isArabic ? "الشخصي" : "file",
              style: TextStyle(
                fontSize: 23,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/welcome_signup_login/imgs/back.png",
            color: Color(0xFF000000),
           
          ),
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Color(0x00),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login_player');
            },
            
            label: Text(
              isArabic ? "تسجيل الخروج" : "Logout",
              style: TextStyle(
                fontSize: 13,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: const Color.fromARGB(255, 212, 1, 1),
            ),
          )
        ],
      ),
       
      );
    }

      final isArabic = context.watch<LanguageProvider>().isArabic;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isArabic ? "الملف " : "Pro",
              style: TextStyle(
                fontSize: 23,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 122, 0),
              ),
            ),
            Text(
              isArabic ? "الشخصي" : "file",
              style: TextStyle(
                fontSize: 23,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/welcome_signup_login/imgs/back.png",
            color: Color(0xFF000000),
           
          ),
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Color(0x00),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login_player');
            },
            
            label: Text(
              isArabic ? "تسجيل الخروج" : "Logout",
              style: TextStyle(
                fontSize: 13,
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: const Color.fromARGB(255, 212, 1, 1),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage_balls,
        Padding(
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
                        width: 2.5,
                      )),
                  child: Stack(
                    children: [
                      if (userData != null && userData!['profileImage'] != null)
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 225, 225, 225),
                          radius: 77.0,
                          backgroundImage:
                              NetworkImage(userData!['profileImage']),
                        )
                      else if (imgPath != null)
                        ClipOval(
                          child: Image.file(imgPath!,
                              width: 154.0, height: 154.0, fit: BoxFit.cover),
                        )
                      else
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 225, 225, 225),
                          radius: 77.0,
                          backgroundImage: AssetImage(
                              "assets/welcome_signup_login/imgs/avatar.png"),
                        ),
                      // u0644u0627 u0646u0639u0631u0636 u0632u0631 u062au063au064au064au0631 u0627u0644u0635u0648u0631u0629 u0641u064a u0635u0641u062du0629 u0639u0631u0636 u0627u0644u0645u0644u0641 u0627u0644u0634u062eu0635u064a
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: greenGradientColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      isArabic ? "معلومات الحساب" : "Account Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'eras-itc-bold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email, color: mainColor),
                            SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: isArabic ? "البريد الالكتروني: " : "Email: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
                                        color: mainColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${user?.email ?? 'Not available'}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
                                        color: const Color.fromARGB(255, 0, 0, 0)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,color: mainColor),
                            SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: isArabic ? "تاريخ التسجيل: " : "Created date: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
                                       color: mainColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${user?.metadata.creationTime != null ? DateFormat('MMMM d, y').format(user!.metadata.creationTime!.toLocal()) : 'Not available'}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
color: const Color.fromARGB(255, 0, 0, 0)                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.login, color: mainColor),
                            SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: isArabic ? "آخر تسجيل دخول: " : "Last Signed In: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
                                        color: mainColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${user?.metadata.lastSignInTime != null ? DateFormat('MMMM d, y').format(user!.metadata.lastSignInTime!.toLocal()) : 'Not available'}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "eras-itc-bold",
color: const Color.fromARGB(255, 0, 0, 0)                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: greenGradientColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      isArabic ? "معلومات الشخصية" : "Personal Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'eras-itc-bold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (userData != null)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: mainColor),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: isArabic ? "اسم المستخدم: " : "Username: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: mainColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${userData!['username'] ?? 'Not available'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: mainColor),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: isArabic ? "الموقع: " : "Location: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: mainColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${userData!['location'] ?? 'Not available'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.cake, color: mainColor),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: isArabic ? "تاريخ الميلاد: " :  "Date of Birth: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: mainColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${userData!['dateOfBirth'] != null ? _formatDate(userData!['dateOfBirth']) : 'Not available'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.phone, color: mainColor),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: isArabic ? "رقم الهاتف: " : "Phone Number: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: mainColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${userData!['phoneNumber'] ?? 'Not available'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "eras-itc-bold",
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("No user data available",
                          style: TextStyle(
                              fontSize: 16, fontFamily: "eras-itc-bold")),
                    ),
                  ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: Create_GradiantGreenButton(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          isArabic ? "تعديل الملف الشخصي" : "Edit Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'eras-itc-bold',
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    onButtonPressed: () async {
                      // Navigate to edit profile and wait for result
                      final result = await Navigator.pushNamed(context, '/edit_profile');
                      // If profile was updated (result is true), refresh the data
                      if (result == true) {
                        fetchUserData();
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
