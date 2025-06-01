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
      body: Stack(
        children: [
          backgroundImage_balls,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image Section
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: greenGradientColor,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          if (userData != null &&
                              userData!['profileImage'] != null)
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 75.0,
                              backgroundImage:
                                  NetworkImage(userData!['profileImage']),
                            )
                          else if (imgPath != null)
                            ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 150.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 75.0,
                              backgroundImage: AssetImage(
                                  "assets/welcome_signup_login/imgs/avatar.png"),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Account Information Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle, color: mainColor, size: 24),
                        SizedBox(width: 12),
                        Text(
                          isArabic ? "معلومات الحساب" : "Account Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'eras-itc-bold',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard([
                    _buildInfoRow(
                      Icons.email,
                      isArabic ? "البريد الالكتروني" : "Email",
                      user?.email ?? 'Not available',
                    ),
                    _buildDivider(),
                    _buildInfoRow(
                      Icons.calendar_today,
                      isArabic ? "تاريخ التسجيل" : "Created Date",
                      user?.metadata.creationTime != null
                          ? DateFormat('MMMM d, y')
                              .format(user!.metadata.creationTime!.toLocal())
                          : 'Not available',
                    ),
                    _buildDivider(),
                    _buildInfoRow(
                      Icons.login,
                      isArabic ? "آخر تسجيل دخول" : "Last Sign In",
                      user?.metadata.lastSignInTime != null
                          ? DateFormat('MMMM d, y')
                              .format(user!.metadata.lastSignInTime!.toLocal())
                          : 'Not available',
                    ),
                  ]),
                  SizedBox(height: 32),

                  // Personal Information Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: mainColor, size: 24),
                        SizedBox(width: 12),
                        Text(
                          isArabic ? "معلومات الشخصية" : "Personal Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'eras-itc-bold',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  if (userData != null)
                    _buildInfoCard([
                      _buildInfoRow(
                        Icons.person_outline,
                        isArabic ? "اسم المستخدم" : "Username",
                        userData!['username'] ?? 'Not available',
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        isArabic ? "الموقع" : "Location",
                        userData!['location'] ?? 'Not available',
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        Icons.cake_outlined,
                        isArabic ? "تاريخ الميلاد" : "Date of Birth",
                        userData!['dateOfBirth'] != null
                            ? _formatDate(userData!['dateOfBirth'])
                            : 'Not available',
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        Icons.phone_outlined,
                        isArabic ? "رقم الهاتف" : "Phone Number",
                        userData!['phoneNumber'] ?? 'Not available',
                      ),
                    ])
                  else
                    _buildInfoCard([
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "No user data available",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "eras-itc-bold",
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  SizedBox(height: 24),

                  // Edit Profile Button
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: mainColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Create_GradiantGreenButton(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            isArabic ? "تعديل الملف الشخصي" : "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'eras-itc-bold',
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      onButtonPressed: () async {
                        final result =
                            await Navigator.pushNamed(context, '/edit_profile');
                        if (result == true) {
                          fetchUserData();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: mainColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: mainColor, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "eras-itc-bold",
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "eras-itc-bold",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 16,
      thickness: 1,
      color: Colors.grey[200],
    );
  }
}
