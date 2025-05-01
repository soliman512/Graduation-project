import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';

class Signup_pg2_StdOwner extends StatefulWidget {
  final String username;
  final String phoneNumber;
  final String dateOfBirth;
  final String location;

   Signup_pg2_StdOwner({
    Key? key,
    required this.username,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.location,
  }) ;

  @override
  State<Signup_pg2_StdOwner> createState() => _Signup_pg2_StdOwnerState();
}

class _Signup_pg2_StdOwnerState extends State<Signup_pg2_StdOwner> {
  bool checkBox_checkTerms = false;
  bool visiblePassword = true;
  bool confirm_passwordVisible = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Password checks
  bool ispassword8char = false;
  bool ispassword1number = false;
  bool ispassworduppercase = false;
  bool ispasswordlowercase = false;
  bool ispasswordspecialchar = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onpasswordchange(String password) {
    setState(() {
      ispassword8char = password.length >= 8;
      ispassword1number = password.contains(RegExp(r'[0-9]'));
      ispassworduppercase = password.contains(RegExp(r'[A-Z]'));
      ispasswordlowercase = password.contains(RegExp(r'[a-z]'));
      ispasswordspecialchar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final uid = credential.user!.uid;

      await FirebaseFirestore.instance.collection('owners').doc(uid).set({
        'username': widget.username,
        'phoneNumber': widget.phoneNumber,
        'dateOfBirth': widget.dateOfBirth,
        'location': widget.location,
        'email': emailController.text.trim(),
      });

      showSnackBar(context, "Account created...");
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login_stadium');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, "The email address is not valid.");
      } else {
        showSnackBar(context, "An error occurred. Please try again.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  

  void onpasswordnumber(String password) {
    setState(() {
      ispassword1number = password.contains(RegExp(r'[0-9]'));
    });
  }

  void onpassworduppercase(String password) {
    setState(() {
      ispassworduppercase = password.contains(RegExp(r'[A-Z]'));
    });
  }

  void onpasswordlowercase(String password) {
    setState(() {
      ispasswordlowercase = password.contains(RegExp(r'[a-z]'));
    });
  }

  void onpasswordspecialchar(String password) {
    setState(() {
      ispasswordspecialchar =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          //app bar
          appBar: AppBar(
            centerTitle: true,
            title: Text("sign up",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up_pg1_stdowner');
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
              // ic
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFF000000),
                  )),
            ],
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Form(
                    key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 44.0,
                      ),
                  
                      //logo
                      add_logo(80.0),
                      // title
                      Add_AppName(
                          font_size: 34.0,
                          align: TextAlign.center,
                          color: Colors.black),
                      //specific user
                      Text("stadium owner",
                          style: TextStyle(
                              color: Color.fromARGB(111, 0, 0, 0),
                              fontWeight: FontWeight.w200,
                              fontSize: 20.0,
                              fontFamily: 'eras-itc-light')),
                      //just for space
                      SizedBox(
                        height: 60.0,
                      ),
                  
                      //inputs:
                      //email
                      Container(
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            color: Color(0xC7FFFFFF),
                            width: double.infinity,
                            height: 60.0,
                            child: TextFormField(
                              validator: (email) {
                                return email!.contains(RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                    ? null
                                    : "Enter a valid email";
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                hintText: "Email",
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
                      SizedBox(
                        height: 20.0,
                      ),
                      //password
                      Container(
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            color: Color(0xC7FFFFFF),
                            width: double.infinity,
                            height: 60.0,
                            child: TextFormField(
                              // change password
                              onChanged: (password) {
                                onpasswordchange(password);
                                onpasswordnumber(password);
                                onpassworduppercase(password);
                                onpasswordlowercase(password);
                                onpasswordspecialchar(password);
                              },
                              validator: (value) {
                                return value!.length < 8
                                    ? "Enter at least 8 characters"
                                    : null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
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
                              
                      SizedBox(
                        height: 20.0,
                      ),
                  
                      //confirm password
                      
                             Container(
                            margin: EdgeInsets.symmetric(horizontal: 18.0),
                            color: Color(0xC7FFFFFF),
                            width: double.infinity,
                            height: 60.0,
                            child: TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: confirm_passwordVisible,
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
                                  Icons.check_circle_outlined,
                                  color: mainColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      confirm_passwordVisible =
                                          !confirm_passwordVisible;
                                    });
                                  },
                                  icon: confirm_passwordVisible
                                      ? Icon(Icons.visibility, color: mainColor)
                                      : Icon(Icons.visibility_off,
                                          color: Colors.grey),
                                  color: mainColor,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                                hintText: "Confirm Password",
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



                          SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              margin: EdgeInsets.only(left: 45.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ispassword8char
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("At least 8 characters")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              margin: EdgeInsets.only(left: 45.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ispassword1number
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("At least 1 number")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              margin: EdgeInsets.only(left: 45.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ispassworduppercase
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Has Uppercase")
                          ],
                        ),
                  SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              margin: EdgeInsets.only(left: 45.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ispasswordlowercase
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Has Lowercase")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              margin: EdgeInsets.only(left: 45.0),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ispasswordspecialchar
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Has Special Character"),
                          ],
                        ),
                      //check terms
                      Container(
                        margin: EdgeInsets.only(top: 10.0, left: 30.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  checkBox_checkTerms = !checkBox_checkTerms;
                                });
                              },
                              icon: checkBox_checkTerms
                                  ? Icon(Icons.check_box_rounded,
                                      color: mainColor)
                                  : Icon(Icons.check_box_outline_blank_rounded,
                                      color: Colors.grey),
                            ),
                            Text("Agree to"),
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        "Terms and Conditions",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'eras-itc-demi',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Container(
                                        height: 300.0,
                                        child: SingleChildScrollView(
                                          child: Text("1. Introduction\n"
                                              "Welcome to the Vámonos app (the \"App\"). These Terms and Conditions govern your use of the App, provided by Vámonos. By accessing or using the App, you agree to comply with these Terms. If you do not agree, you should not use the App.\n\n"
                                              "2. Service Definition\n"
                                              "The Vámonos app provides a platform for sports facility owners to list their fields and allow users to book and pay for them online. All financial transactions are handled via the in-app payment system.\n\n"
                                              "3. Account Registration\n"
                                              "To complete a booking or list your field, you must create a personal account. You are responsible for maintaining the confidentiality of your account information and password, as well as for all activities that occur under your account.\n\n"
                                              "4. User Responsibilities\n"
                                              "For Users (Booking the Fields):\n\n"
                                              "You are responsible for entering accurate booking information (such as booking date, time, and payment details).\n\n"
                                              "You must ensure that all payments are made through the approved payment channels within the app.\n\n"
                                              "For Facility Owners:\n\n"
                                              "Facility owners must provide accurate and complete information about their fields (such as size, location, pricing, and available amenities).\n\n"
                                              "You must keep your listings updated to ensure accuracy.\n\n"
                                              "Facility owners must handle all bookings and payments via the in-app payment system.\n\n"
                                              "5. Online Payment\n"
                                              "All payments are processed through the app's integrated payment system. You agree that charges for bookings will be deducted from your account through the approved payment methods within the app.\n\n"
                                              "6. Privacy Policy\n"
                                              "We value your privacy. Your personal data will be collected and used in accordance with our [Privacy Policy], which explains how we handle and protect your information. By using the App, you consent to the collection and use of your data as described in the Privacy Policy.\n\n"
                                              "7. Legal Restrictions\n"
                                              "You may not use the app for any unlawful activities or fraudulent behavior.\n\n"
                                              "You must comply with local laws when using the app or interacting with other users on the platform.\n\n"
                                              "8. Limitation of Liability\n"
                                              "The app is provided \"as is\" and \"as available.\" Vámonos does not guarantee that the app will be error-free or continuously available.\n\n"
                                              "We are not responsible for any losses or damages that arise from your use of the app, including, but not limited to, booking errors or failed payment transactions.\n\n"
                                              "9. Account Termination\n"
                                              "We reserve the right to suspend or terminate your account if you violate these Terms or engage in any illegal or unauthorized activities while using the app.\n\n"
                                              "10. Modifications to Terms\n"
                                              "Vámonos reserves the right to update or modify these Terms at any time. Changes will take effect immediately once posted on the app or our website.\n\n"
                                              "11. Governing Law\n"
                                              "These Terms are governed by and construed in accordance with the laws of Egypt. Any disputes arising from these Terms will be subject to the exclusive jurisdiction of the courts in Egypt.\n\n"
                                              "12. Contact Us\n"
                                              "If you have any questions or concerns about these Terms and Conditions, please contact us at [Contact Information — to be updated].\n\n"),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text('terms and conditions',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline)))
                          ],
                        ),
                      ),
                      //just for spacing
                      SizedBox(
                        height: 40.0,
                      ),
                      //sign up
                      SizedBox(
                        height: 50.0,
                        child: Create_GradiantGreenButton(
                          content: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                            'sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontFamily: 'eras-itc-bold'),
                          ),
                          onButtonPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await register();
                              } else {
                                showSnackBar(context, "ERROR");
                              }
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
