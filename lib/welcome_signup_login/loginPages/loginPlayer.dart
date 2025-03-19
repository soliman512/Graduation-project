import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/google_signin.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:provider/provider.dart';

class Login_player extends StatefulWidget {
  @override
  State<Login_player> createState() => _Login_playerState();
}

class _Login_playerState extends State<Login_player> {
  // Sign in with email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showSnackBar(context, "Done ...");
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      print("snackbar  ${e.code}");
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = "Email not found";
          break;
        case 'wrong-password':
          errorMessage = "Wrong-Password";
          break;
        case 'invalid-email':
          errorMessage = 'Invalid-Email';
          break;
        default:
          errorMessage = "An unexpected error occurred.Try again.";
      }
      showSnackBar(context, errorMessage);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool visiblePassword = true;
  Icon unShowPassword = Icon(Icons.visibility);
  Icon showPassword = Icon(Icons.visibility_off);
  Icon showPasswordState = Icon(Icons.visibility);

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar
          appBar: AppBar(
            centerTitle: true,
            title: Text("login",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_signup_player');
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
          body: SingleChildScrollView(
            child: Stack(
              children: [
                backgroundImage_balls,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // title
                      Add_AppName(
                          font_size: 34.0,
                          align: TextAlign.center,
                          color: Colors.black),
                      //specific user
                      Text("player",
                          style: TextStyle(
                            color: Color(0xB6000000),
                            // fontFamily: "eras-itc-bold",
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      //logo
                      logo,
                      //just for space
                      SizedBox(
                        height: 52.0,
                      ),

                      //email address
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        color: Color(0xC7FFFFFF),
                        width: double.infinity,
                        height: 44.0,
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            focusColor: mainColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              color: mainColor,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                              color: Color(0x4F000000),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x4F000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      //just for space
                      SizedBox(
                        height: 30.0,
                      ),
                      //password
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        color: Color(0xC7FFFFFF),
                        width: double.infinity,
                        height: 44.0,
                        child: TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: visiblePassword,
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            focusColor: mainColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(
                              Icons.password_rounded,
                              color: mainColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (showPasswordState == unShowPassword) {
                                    showPasswordState = showPassword;
                                    visiblePassword = true;
                                  } else {
                                    showPasswordState = unShowPassword;
                                    visiblePassword = false;
                                  }
                                });
                              },
                              icon: showPasswordState,
                              color: mainColor,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Color(0x4F000000),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x4F000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      //forgot
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(23, 20, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Recorve_account');
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xffffffff))),
                          child: Text("Forgot your password ?",
                              style: TextStyle(
                                  color: Color(0xff004FFB),
                                  fontFamily: "eras-itc-demi",
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12.0)),
                        ),
                      ),

                      SizedBox(
                        height: 56,
                      ),
//login
                      Container(
                        width: 300.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff005706),
                              Color(0xff007211),
                              Color(0xff00911E),
                              Color(0xff00B92E),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await signIn();
                            if (!mounted) return;
                          },
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontFamily: "eras-itc-bold",
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xFFFFFFFF)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      // or line
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Color(0xD7000000),
                            // thickness: 1,
                            // indent: 16.0,
                            // endIndent: 30.0,
                            height: 1.0,
                            width: 145.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                  color: Color(0xff00B92E),
                                  fontFamily: 'eras-itc-demi'),
                            ),
                          ),
                          Container(
                            color: Color(0xD7000000),
                            // thickness: 1,
                            // indent: 16.0,
                            // endIndent: 30.0,
                            height: 1.0,
                            width: 145.0,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 30.0,
                      ),

                      //another ways to login
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // spacing: ,
                          children: [
                            //google
                            Container(
                              width: 100.0,
                              // margin: EdgeInsets.only(left: 20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFFF0000),
                                  width: 2,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  googleSignInProvider.googleLogin();
                                },
                                child: Image.asset(
                                  "assets/welcome_signup_login/imgs/google.png",
                                ),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    foregroundColor: MaterialStateProperty.all(
                                        Color(0xffffffff))),
                              ),
                            ),

                            //twitter
                            Container(
                              width: 80.0,
                              // margin: EdgeInsets.only(left: 20.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF000000),
                                  width: 2,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Image.asset(
                                  "assets/welcome_signup_login/imgs/icons8-twitter-100.png",
                                ),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    foregroundColor: MaterialStateProperty.all(
                                        Color(0xffffffff))),
                              ),
                            ),

                            //facebook
                            Container(
                              width: 100.0,
                              // margin: EdgeInsets.only(left: 20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF0077FF),
                                  width: 2,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Image.asset(
                                  "assets/welcome_signup_login/imgs/facebook.png",
                                ),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    foregroundColor: MaterialStateProperty.all(
                                        Color(0xffffffff))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
