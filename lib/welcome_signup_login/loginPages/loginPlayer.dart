import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/google_signin.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

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
      final user = credential.user;

      final playerDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (playerDoc.exists) {
        showSnackBar(
            context,
            Provider.of<LanguageProvider>(context, listen: false).isArabic
                ? "تم تسجيل الدخول بنجاح"
                : "Done ... ");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('role', 'users');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showSnackBar(
            context,
            Provider.of<LanguageProvider>(context, listen: false).isArabic
                ? "هذا الحساب ليس حساب لاعب!"
                : "This account is not a Player account!");
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      print("snackbar  ${e.code}");
      final isArabic =
          Provider.of<LanguageProvider>(context, listen: false).isArabic;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage =
              isArabic ? "البريد الإلكتروني غير موجود" : "Email not found";
          break;
        case 'wrong-password':
          errorMessage = isArabic ? "كلمة المرور خاطئة" : "Wrong-Password";
          break;
        case 'invalid-email':
          errorMessage =
              isArabic ? "البريد الإلكتروني غير صالح" : 'Invalid-Email';
          break;
        default:
          errorMessage = isArabic
              ? "حدث خطأ غير متوقع. حاول مرة أخرى."
              : "An unexpected error occurred.Try again.";
      }
      showSnackBar(context, errorMessage);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool visiblePassword = true;

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
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          //app bar
          appBar: AppBar(
            
            centerTitle: true,
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return Text(
                  languageProvider.isArabic ? "تسجيل الدخول" : "login",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily:
                        languageProvider.isArabic ? "Cairo" : "eras-itc-light",
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                );
              },
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Welcome');
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
                onPressed: () {
                  // Toggle between English and Arabic
                  final languageProvider =
                      Provider.of<LanguageProvider>(context, listen: false);
                  languageProvider.toggleLanguage();

                  // Show a snackbar to indicate the language change
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        languageProvider.isArabic
                            ? 'Language changed to English'
                            : 'تم تغيير اللغة إلى العربية',
                        style: TextStyle(fontFamily: 'eras-itc-bold'),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: mainColor,
                    ),
                  );
                },
                icon: Icon(Icons.language, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(
                  children: [
                    //logo
                    add_logo(80.0),
                    // title
                    Add_AppName(
                        font_size: 24.0,
                        align: TextAlign.center,
                        color: Colors.black),
                    //specific user
                    Consumer<LanguageProvider>(
                      builder: (context, languageProvider, child) {
                        return Text(
                          languageProvider.isArabic ? "لاعب" : "player",
                          style: TextStyle(
                            color: Color(0xB6000000),
                            fontFamily: languageProvider.isArabic
                                ? "Cairo"
                                : "eras-itc-light",
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                          ),
                        );
                      },
                    ),
                    //just for space
                    SizedBox(
                      height: 120.0,
                    ),

                    //email address
                    Create_Input(
                      controller: emailController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: Provider.of<LanguageProvider>(context).isArabic
                          ? "البريد الإلكتروني"
                          : "Email Address",
                      addPrefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: mainColor,
                      ),
                    ),
                    //just for space
                    SizedBox(
                      height: 26.0,
                    ),
                    //password
                    Create_Input(
                      controller: passwordController,
                      isPassword: visiblePassword,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: Provider.of<LanguageProvider>(context).isArabic
                          ? "كلمة المرور"
                          : "Password",
                      addPrefixIcon: Icon(
                        Icons.password_rounded,
                        color: mainColor,
                      ),
                      addSuffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        },
                        icon: visiblePassword
                            ? Icon(Icons.visibility, color: mainColor)
                            : Icon(Icons.visibility_off, color: Colors.grey),
                        color: mainColor,
                      ),
                    ),

                    //forgot
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Recorve_account');
                        },
                        style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.transparent),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xffffffff))),
                        child: Text(
                            Provider.of<LanguageProvider>(context).isArabic
                                ? "هل نسيت كلمة المرور؟"
                                : "Forgot your password ?",
                            style: TextStyle(
                                color: Color(0xff004FFB),
                                fontFamily: "eras-itc-demi",
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w900,
                                fontSize: 12.0)),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
//login
                    SizedBox(
                      height: 50.0,
                      child: Create_GradiantGreenButton(
                        content: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                Provider.of<LanguageProvider>(context).isArabic
                                    ? "تسجيل الدخول"
                                    : "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontFamily: "eras-itc-bold",
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                        onButtonPressed: () async {
                          await signIn();
                          if (!mounted) return;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 26.0,
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
                            Provider.of<LanguageProvider>(context).isArabic
                                ? 'أو'
                                : 'OR',
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
                      margin: EdgeInsets.symmetric(horizontal: 34.0),
                      width: double.infinity,
                      // alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // spacing: ,
                        children: [
                          //google
                          Expanded(
                            child: SizedBox(
                              height: 40.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await googleSignInProvider.googleLogin();
                                  final user = FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    final playerDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                                    if (!playerDoc.exists) {
                                      // أول مرة يدخل - أنشئ بيانات اللاعب تلقائيًا
                                      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                                        'email': user.email,
                                        'username': user.displayName ?? user.email?.split('@')[0] ?? '',
                                        'profileImage': user.photoURL ?? '',
                                        'phoneNumber': '',
                                        'location': '',
                                        'dateOfBirth': '',
                                      });
                                    }
                                    Navigator.pushReplacementNamed(context, '/home');
                                  }
                                },
                                child: Image.asset(
                                    "assets/welcome_signup_login/imgs/google.png",
                                    width: 32.0),
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(2),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    //don't have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Provider.of<LanguageProvider>(context).isArabic
                              ? 'ليس لديك حساب؟ '
                              : 'don\'t have account? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_up_pg1_player');
                          },
                          child: Text(
                            Provider.of<LanguageProvider>(context).isArabic
                                ? 'سجل الآن'
                                : 'sign up',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
