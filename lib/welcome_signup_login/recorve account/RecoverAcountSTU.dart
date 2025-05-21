import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/loginPages/loginStadium.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:provider/provider.dart';

class Recorve_Account_STU extends StatefulWidget {
  @override
  State<Recorve_Account_STU> createState() => _Recorve_AccountState();
}

class _Recorve_AccountState extends State<Recorve_Account_STU> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Reset password
  resetpaswword() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login_Stadiumonwer()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context,
       Provider.of<LanguageProvider>(context, listen: false).isArabic
        ? "خطأ: ${e.code}"
        : "Error: ${e.code}",
      );
    }
    if (!mounted) return;
showSnackBar(
      context,
      Provider.of<LanguageProvider>(context, listen: false).isArabic
        ? "تم: يرجى التحقق من بريدك الإلكتروني"
        : "Done: Please check your email",
    );  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final isArabic = Provider.of<LanguageProvider>(context).isArabic;

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar language
          appBar: AppBar(
            centerTitle: true,
            title: Text(isArabic ? "استعادة الحساب" : "Recorve account",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Welcome');
                  },
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // title
                        Add_AppName(
                            font_size: 34.0,
                            align: TextAlign.center,
                            color: Colors.black),
                        SizedBox(
                          height: 10.0,
                        ),
                        //logo
                        logo,

                        //please check:
                        Container(
                            margin: EdgeInsets.only(top: 29.0),
                            child: Text(
 isArabic
                                  ? "يرجى التحقق من بريدك الإلكتروني"
                                  : "Please check your email",                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: "eras-itc-bold"),
                            )),

                        Container(
                            margin: EdgeInsets.only(top: 6.0),
                            child: Text(
 isArabic
                                  ? "لقد أرسلنا رمزًا إلى helloworld@gmail.com"
                                  : "We’ve sent a code to helloworld@gmail.com",                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            )),
                        //enter your email
                        Container(
                          child: Text(
 isArabic
                                ? "أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور."
                                : "Enter your email to reset your password.",                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        // email
                        Container(
                          width: 330.0,
                          height: 44,
                          margin: EdgeInsets.only(top: 40.0),
                          child: TextFormField(
                            validator: (email) {
                              return email!.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                  ? null
                                  : (isArabic ? "أدخل بريدًا إلكترونيًا صحيحًا" : "Enter a valid email");
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailController,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                               hintText: Provider.of<LanguageProvider>(context).isArabic
                                  ? "البريد الإلكتروني"
                                  : "Email",
                              hintStyle: TextStyle(
                                  color: Color(0x4F000000),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x4F000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),

                        //text Fields

                        Container(
                          // width: double.infinity,
                          margin: EdgeInsets.only(right: 15),
                          // alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // inputs

                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     color: Color(0xA8FFFFFF),
                                //   ),
                                //   height: 60.0,
                                //   width: 60.0,
                                //   margin:
                                //       EdgeInsets.only(top: 81.0, left: 20.0),
                                //   child: TextField(
                                //     focusNode: FocusNode(),
                                //     // cursorHeight: 30.0,
                                //     showCursor: false,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         fontSize: 30,
                                //         fontWeight: FontWeight.w300),
                                //     textInputAction: TextInputAction.next,
                                //     maxLength: 1,
                                //     autofocus: true,
                                //     keyboardType: TextInputType.number,
                                //     onChanged: (value) {
                                //       if (value.length == 1) {
                                //         FocusScope.of(context).nextFocus();
                                //       }
                                //     },
                                //     decoration: InputDecoration(
                                //         focusColor: mainColor,
                                //         focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: mainColor, width: 2.0),
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         counterText: "",
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           borderSide: BorderSide(
                                //             color: Color(0x28000000),
                                //             width: 1.0,
                                //           ),
                                //         )),
                                //   ),
                                // ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     color: Color(0xA8FFFFFF),
                                //   ),
                                //   height: 60.0,
                                //   width: 60.0,
                                //   margin:
                                //       EdgeInsets.only(top: 81.0, left: 20.0),
                                //   child: TextField(
                                //     onChanged: (value) {
                                //       if (value.length == 1) {
                                //         FocusScope.of(context).nextFocus();
                                //       }
                                //       if (value.length == 0) {
                                //         FocusScope.of(context).previousFocus();
                                //       }
                                //     },
                                //     showCursor: false,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         fontSize: 30,
                                //         fontWeight: FontWeight.w300),
                                //     textInputAction: TextInputAction.next,
                                //     maxLength: 1,
                                //     autofocus: true,
                                //     keyboardType: TextInputType.number,
                                //     decoration: InputDecoration(
                                //         focusColor: mainColor,
                                //         focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: mainColor, width: 2.0),
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         counterText: "",
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           borderSide: BorderSide(
                                //             color: Color(0x28000000),
                                //             width: 1.0,
                                //           ),
                                //         )),
                                //   ),
                                // ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     color: Color(0xA8FFFFFF),
                                //   ),
                                //   height: 60.0,
                                //   width: 60.0,
                                //   margin:
                                //       EdgeInsets.only(top: 81.0, left: 20.0),
                                //   child: TextField(
                                //     // cursorHeight: 30.0,
                                //     showCursor: false,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         fontSize: 30,
                                //         fontWeight: FontWeight.w300),
                                //     textInputAction: TextInputAction.next,
                                //     maxLength: 1,
                                //     autofocus: true,
                                //     keyboardType: TextInputType.number,
                                //     onChanged: (value) {
                                //       if (value.length == 1) {
                                //         FocusScope.of(context).nextFocus();
                                //       }
                                //       if (value.length == 0) {
                                //         FocusScope.of(context).previousFocus();
                                //       }
                                //     },
                                //     decoration: InputDecoration(
                                //         focusColor: mainColor,
                                //         focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: mainColor, width: 2.0),
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         counterText: "",
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           borderSide: BorderSide(
                                //             color: Color(0x28000000),
                                //             width: 1.0,
                                //           ),
                                //         )),
                                //   ),
                                // ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     color: Color(0xA8FFFFFF),
                                //   ),
                                //   height: 60.0,
                                //   width: 60.0,
                                //   margin:
                                //       EdgeInsets.only(top: 81.0, left: 20.0),
                                //   child: TextField(
                                //     // cursorHeight: 30.0,
                                //     showCursor: false,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         fontSize: 30,
                                //         fontWeight: FontWeight.w300),
                                //     textInputAction: TextInputAction.done,
                                //     maxLength: 1,
                                //     autofocus: true,
                                //     keyboardType: TextInputType.number,
                                //     onChanged: (value) {
                                //       if (value.length == 0) {
                                //         FocusScope.of(context).previousFocus();
                                //       }
                                //     },
                                //     decoration: InputDecoration(
                                //         focusColor: mainColor,
                                //         focusedBorder: OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: mainColor, width: 2.0),
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         counterText: "",
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           borderSide: BorderSide(
                                //             color: Color(0x28000000),
                                //             width: 1.0,
                                //           ),
                                //         )),
                                //   ),
                                // ),
                              ]),
                        ),

                        SizedBox(
                          height: 100,
                        ),
                        //login
                        Container(
                          width: 300.0,
                          height: 40.0,
                          // bottom: 192.0,
                          // left: 30,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff005706),
                                  Color(0xff007211),
                                  Color(0xff00911E),
                                  Color(0xff00B92E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ElevatedButton(
                            // Reset Password Function
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                resetpaswword();
                              } else {
                                showSnackBar(context, "ERROR");
                              }
                            },
                            style: ButtonStyle(
                              // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(15))),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  WidgetStateProperty.all(Color(0xFFFFFFFF)),
                              shadowColor:
                                  WidgetStateProperty.all(Colors.transparent),

                              // padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                            ),
                            child: Text(
                              "Reset Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Color(0xffffffff),
                                fontFamily: "eras-itc-bold",
                                fontSize: 24.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
