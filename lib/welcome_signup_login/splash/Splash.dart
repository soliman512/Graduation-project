import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project_main/welcome_signup_login/Welcome.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/home_loves_tickets_top/home/Home.dart';
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() => isStart = true);
    });

    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final role = prefs.getString('role');

      if (isLoggedIn && role != null) {
        if (role == 'users') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        } else if (role == 'owners') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Owner()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
        }
      } else {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
        } else {
          final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          final firestoreRole = userDoc.data()?['role'];

          if (firestoreRole != null) {
      
            await prefs.setBool('isLoggedIn', true);
            await prefs.setString('role', firestoreRole);

            if (firestoreRole == 'users') {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            } else if (firestoreRole == 'owners') {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Owner()));
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
            }
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/splashBackground.png')),
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            color: Colors.white,
            width: double.infinity,
            height: isStart ? 0 : MediaQuery.of(context).size.height,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: isStart ? 0.0 : 100.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 140.0,
                  child: add_logo(115.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Add_AppName(
                    font_size: 30.0,
                    align: TextAlign.center,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
