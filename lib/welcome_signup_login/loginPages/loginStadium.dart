<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
=======
import 'package:flutter/material.dart';
import 'package:welcome_signup_login/constants/constants.dart';
import 'package:welcome_signup_login/reusable_widgets/reusable_widgets.dart';
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

class Login_Stadiumonwer extends StatefulWidget {
  @override
  State<Login_Stadiumonwer> createState() => _Login_StadiumonwerState();
}

class _Login_StadiumonwerState extends State<Login_Stadiumonwer> {
  bool visiblePassword = true;
<<<<<<< HEAD

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = credential.user;

      // التحقق من أن المستخدم موجود في مجموعة "owners"
      final ownerDoc = await FirebaseFirestore.instance
          .collection('owners')
          .doc(user!.uid)
          .get();

      if (ownerDoc.exists) {
        showSnackBar(
        context,
        Provider.of<LanguageProvider>(context, listen: false).isArabic
            ? "تم تسجيل الدخول بنجاح"
            : "Done ... ");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('role', 'owners');
        Navigator.pushReplacementNamed(context, '/home_owner');
      } else {
        showSnackBar(
        context,
        Provider.of<LanguageProvider>(context, listen: false).isArabic
            ? "هذا الحساب ليس حساب مالك ملعب!"
            : "This account is not an Owner account!");
        await FirebaseAuth.instance.signOut();
      }
        } on FirebaseAuthException catch (e) {
      String errorMessage;
      final isArabic =
          Provider.of<LanguageProvider>(context, listen: false).isArabic;

      print("snackbar  ${e.code}");
      switch (e.code) {
        case 'invalid-credential':
        case 'user-not-found':
          errorMessage = isArabic ? "البريد الإلكتروني غير موجود" : "Email not found";
          break;
        case 'wrong-password':
          errorMessage = isArabic ? "كلمة المرور غير صحيحة" : "Wrong-Password";
          break;
        case 'invalid-email':
          errorMessage = isArabic ? "البريد الإلكتروني غير صالح" : 'invalid-email';
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

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
=======
  Icon unShowPassword = Icon(
    Icons.visibility,
    color: mainColor,
  );
  Icon showPassword = Icon(
    Icons.visibility_off,
    color: mainColor,
  );
  Icon showPasswordState = Icon(
    Icons.visibility,
    color: mainColor,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
          extendBodyBehindAppBar: false,
          //app bar
          appBar: AppBar(
            centerTitle: true,
<<<<<<< HEAD
            title: Text( languageProvider.isArabic ? "تسجيل الدخول" : "login",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: languageProvider.isArabic ? "Cairo" : "eras-itc-bold",
=======
            title: Text("login",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
<<<<<<< HEAD
                Navigator.pushNamed(context, '/Welcome');
=======
                Navigator.pushNamed(context, '/login_signup_stdOwner');
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
              },
              icon: Image.asset("assets/welcome_signup_login/imgs/back.png"),
              color: Color(0xff000000),
            ),
            // icon: Image.asset("aassets/welcome_signup_login/imgs/ligh back.png"),

            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
<<<<<<< HEAD
            IconButton(
              onPressed: () {
                // Toggle between English and Arabic
                final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                languageProvider.toggleLanguage();
                
                // Show a snackbar to indicate the language change
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      languageProvider.isArabic ?  'Language changed to English': 'تم تغيير اللغة إلى العربية',
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
=======
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFF000000),
                  )),
            ],
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(
                  children: [
<<<<<<< HEAD
                    //logo
                    add_logo(80.0),
=======
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    // title
                    Add_AppName(
                        font_size: 34.0,
                        align: TextAlign.center,
                        color: Colors.black),
                    //specific user
<<<<<<< HEAD
                    Consumer<LanguageProvider>(
                      builder: (context, languageProvider, child) {
                      return Text(
                        languageProvider.isArabic ? "مالك الملعب" : "stadium owner",
                        style: TextStyle(
                        color: Color.fromARGB(111, 0, 0, 0),
                        fontWeight: FontWeight.w200,
                        fontSize: 20.0,
                        fontFamily: languageProvider.isArabic ? "Cairo" : "eras-itc-light",
                        ),
                      );
                      },
                    ),
                    //just for space
                    SizedBox(
                      height: 60.0,
                    ),

                    //email address
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32.0),
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
                            hintText: Provider.of<LanguageProvider>(context).isArabic ? "البريد الإلكتروني" : "Email Address",
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
=======
                    Text("stadium owner",
                        style: TextStyle(
                          color: Color(0xB6000000),
                          // fontFamily: "eras-itc-bold",
                          fontWeight: FontWeight.w200,
                          fontSize: 20.0,
                        )),
                    //just for space
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
                    Create_Input(
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: "Email Address",
                      addPrefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: mainColor,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                      ),
                    ),
                    //just for space
                    SizedBox(
<<<<<<< HEAD
                      height: 26.0,
                    ),

                    //password
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32.0),
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
                                visiblePassword = !visiblePassword;
                              });
                            },
                            icon: visiblePassword
                                ? Icon(Icons.visibility, color: mainColor)
                                : Icon(Icons.visibility_off,
                                    color: Colors.grey),
                            color: mainColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                            hintText: Provider.of<LanguageProvider>(context).isArabic ? "كلمة المرور" : "Password",
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
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Recorve_account_STU');
                        },
                        style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.transparent),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xffffffff))),
                        child: Text(Provider.of<LanguageProvider>(context).isArabic
                            ? "هل نسيت كلمة المرور؟"
                            : "Forgot your password ?",
=======
                      height: 30.0,
                    ),

                    //password
                    Create_Input(
                      isPassword: visiblePassword,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: "Password",
                      addPrefixIcon: Icon(Icons.lock_outline, color: mainColor),
                      addSuffixIcon: IconButton(
                        icon: showPasswordState,
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                            showPasswordState =
                                showPasswordState == showPassword
                                    ? unShowPassword
                                    : showPassword;
                          });
                        },
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
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                            style: TextStyle(
                                color: Color(0xff004FFB),
                                fontFamily: "eras-itc-demi",
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w900,
                                fontSize: 12.0)),
                      ),
                    ),

                    SizedBox(
<<<<<<< HEAD
                      height: 40,
                    ),

                    //login
                    SizedBox(
                      height: 50.0,
                      child: Create_GradiantGreenButton(
                          content: Text(
                                Provider.of<LanguageProvider>(context).isArabic ? "تسجيل الدخول" : "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontFamily: 'eras-itc-bold'),
                          ),
                          onButtonPressed: () async {
                            await signIn();
                            // showSnackBar(context, "Done ... ");
                            if (!mounted) return;
                          }),
                    ),
                    SizedBox(
                      height: 26.0,
=======
                      height: 56,
                    ),

                    //login
                    Create_GradiantGreenButton(
                        title: 'Login',
                        onButtonPressed: () {
                          Navigator.pushNamed(context, '/stdWon_addNewStadium');
                        }),
                    SizedBox(
                      height: 40.0,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
<<<<<<< HEAD
                            Provider.of<LanguageProvider>(context).isArabic ? 'أو' : 'OR',
=======
                            'OR',
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                            style: TextStyle(
                                color: Color(0xff00B92E),
                                fontFamily: 'eras-itc-demi'),
                          ),
                        ),
                        Container(
                          color: Color(0xD7000000),
<<<<<<< HEAD
=======
                          // thickness: 1,
                          // indent: 16.0,
                          // endIndent: 30.0,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                          height: 1.0,
                          width: 145.0,
                        ),
                      ],
                    ),

                    SizedBox(
<<<<<<< HEAD
                      height: 20.0,
=======
                      height: 30.0,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    ),

                    //another ways to login
                    Container(
<<<<<<< HEAD
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
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                        "assets/welcome_signup_login/imgs/google.png",
                                        width: 32.0),
                                    Text( Provider.of<LanguageProvider>(context).isArabic
                                        ? 'جوجل'
                                        : 'google',
                                        style: TextStyle(
                                            color: Color(0xFFFF3D00),
                                            fontSize: 18.0)),
                                  ],
                                ),
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(2),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.0),
                          //facebook
                          Expanded(
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Wrap(
                                  children: [
                                    Image.asset(
                                      "assets/welcome_signup_login/imgs/facebook.png",
                                      width: 32.0,
                                    ),
                                    Text(Provider.of<LanguageProvider>(context).isArabic
                                      ? 'فيسبوك'
                                      : 'facebook',
                                        style: TextStyle(
                                            color: Color(0xFF0680DD),
                                            fontSize: 18.0)),
                                  ],
                                ),
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(2),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
=======
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
                              onPressed: () {},
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
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                            ),
                          ),
                        ],
                      ),
<<<<<<< HEAD
                    ),
                    SizedBox(height: 60.0),
                    //don't have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Provider.of<LanguageProvider>(context).isArabic
                            ? 'ليس لديك حساب؟ '
                            : 'don\'t have account? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/sign_up_pg1_stdowner');
                            },
                            child: Text(Provider.of<LanguageProvider>(context).isArabic
                                ? 'سجل الآن'
                                : 'sign up',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16.0,
                                )))
                      ],
=======
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
