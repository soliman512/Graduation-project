// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/home_loves_tickets_top/home/Home.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';

class VerifyEmailPage extends StatefulWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        // when we click on the link that existed on yahoo
        await FirebaseAuth.instance.currentUser!.reload();

        // is email verified or not (clicked on the link or not) (true or false)
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });

        if (isEmailVerified) {
          timer.cancel();
        }
      });
    }
  }

  sendVerificationEmail() async {
    try {
      // sent email to the user
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showSnackBar(context, "ERROR => ${e.toString()}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? Home()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Verify Email",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  )),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login_stadium');
                },
                icon: Image.asset("assets/welcome_signup_login/imgs/back.png"),
                color: Color(0xff000000),
              ),
              // icon: Image.asset("aassets/welcome_signup_login/imgs/ligh back.png"),
              toolbarHeight: 80.0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.language,
                      color: Color(0xFF000000),
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A verification email has been sent to your email",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      canResendEmail ? sendVerificationEmail() : null;
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xff00911E)),
                      padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Resent Email",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    // style: ButtonStyle(
                    //   backgroundColor:
                    //       MaterialStateProperty.all(Color(0xffffffff)),
                    //   padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8))),
                    // ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
