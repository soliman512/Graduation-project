import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Signup_pg2_StdOwner extends StatefulWidget {
  final String? profileImage;
  Signup_pg2_StdOwner({this.profileImage});
  @override
  State<Signup_pg2_StdOwner> createState() => _Signup_pg2_StdOwnerState();
}

class _Signup_pg2_StdOwnerState extends State<Signup_pg2_StdOwner> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Variables to store the loaded data
  String username = "";
  String phoneNumber = "";
  String dateOfBirth = "";
  String location = "";

  bool visiblePassword = true;
  bool confirm_passwordVisible = true;

  bool ispassword8char = false;
  bool ispassword1number = false;
  bool ispassworduppercase = false;
  bool ispasswordlowercase = false;
  bool ispasswordspecialchar = false;

  bool termsChecked = false;

  // Add validation state variables
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "";
      phoneNumber = prefs.getString('phoneNumber') ?? "";
      dateOfBirth = prefs.getString('dateOfBirth') ?? "";
      location = prefs.getString('location') ?? "";
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Validate email format before attempting registration
      if (!emailController.text.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message:
              Provider.of<LanguageProvider>(context, listen: false).isArabic
                  ? "البريد الإلكتروني غير صالح"
                  : "Invalid email format",
        );
      }

      // Validate password strength before attempting registration
      if (!isPasswordValid) {
        throw FirebaseAuthException(
          code: 'weak-password',
          message:
              Provider.of<LanguageProvider>(context, listen: false).isArabic
                  ? "كلمة المرور ضعيفة جداً"
                  : "Password is too weak",
        );
      }

      // Create account using Firebase Authentication
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final String uid = credential.user!.uid;

      // Store additional user information in Firestore
      String? profileImageUrl;

      if (widget.profileImage != null && widget.profileImage!.isNotEmpty) {
        try {
          if (widget.profileImage!.startsWith('http')) {
            profileImageUrl = widget.profileImage;
          } else {
            final File file = File(widget.profileImage!);
            final SupabaseClient supabase = Supabase.instance.client;
            final String uniqueFileName = '$uid.png';
            final String fullPath = await supabase.storage.from('photo').upload(
                  'public/$uniqueFileName',
                  file,
                  fileOptions:
                      const FileOptions(cacheControl: '3600', upsert: false),
                );
            profileImageUrl =
                await supabase.storage.from('photo').getPublicUrl(fullPath);
          }

          // Store user data in Firestore
          await FirebaseFirestore.instance.collection('owners').doc(uid).set({
            'username': username,
            'phoneNumber': phoneNumber,
            'dateOfBirth': dateOfBirth,
            'location': location,
            'profileImage': profileImageUrl,
            'createdAt': FieldValue.serverTimestamp(),
            'lastLogin': FieldValue.serverTimestamp(),
          });

          final languageProvider =
              Provider.of<LanguageProvider>(context, listen: false);
          bool isArabic = languageProvider.isArabic;

          showCustomTopSnackBar(
              context,
              isArabic
                  ? "تم إنشاء حسابك بنجاح! يمكنك الآن تسجيل الدخول"
                  : "Account created successfully! You can now log in",
              false);

          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/login_stadium');
        } catch (e) {
          print('Error uploading image: $e');
          throw FirebaseAuthException(
            code: 'image-upload-failed',
            message:
                Provider.of<LanguageProvider>(context, listen: false).isArabic
                    ? "فشل في رفع الصورة الشخصية، يرجى المحاولة مرة أخرى"
                    : "Failed to upload profile image, please try again",
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      final languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);
      bool isArabic = languageProvider.isArabic;

      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = isArabic
              ? "كلمة المرور ضعيفة جداً. يجب أن تحتوي على 8 أحرف على الأقل، حرف كبير، حرف صغير، رقم، ورمز خاص"
              : "The password is too weak. It must be at least 8 characters long and include uppercase, lowercase, number, and special character";
          break;
        case 'email-already-in-use':
          errorMessage = isArabic
              ? "هذا البريد الإلكتروني مسجل بالفعل. يرجى استخدام بريد إلكتروني آخر أو تسجيل الدخول"
              : "This email is already registered. Please use a different email or log in";
          break;
        case 'invalid-email':
          errorMessage = isArabic
              ? "البريد الإلكتروني غير صالح. يرجى إدخال بريد إلكتروني صحيح"
              : "Invalid email format. Please enter a valid email address";
          break;
        case 'image-upload-failed':
          errorMessage = e.message ??
              (isArabic
                  ? "فشل في رفع الصورة الشخصية"
                  : "Failed to upload profile image");
          break;
        default:
          errorMessage = isArabic
              ? "حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة مرة أخرى"
              : "An error occurred while creating your account. Please try again";
      }

      showCustomTopSnackBar(context, errorMessage, true);
    } catch (error) {
      final languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);
      bool isArabic = languageProvider.isArabic;

      String errorMessage = isArabic
          ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى أو التواصل مع الدعم الفني"
          : "An unexpected error occurred. Please try again or contact support";

      if (error is String) {
        errorMessage = isArabic ? "خطأ: $error" : "Error: $error";
      }

      showCustomTopSnackBar(context, errorMessage, true);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void onpasswordchange(String password) {
    setState(() {
      ispassword8char = password.length >= 8;
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

  // Enhanced email validation with more descriptive messages
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "البريد الإلكتروني مطلوب لإكمال التسجيل"
          : "Email is required to complete registration";
    }
    if (!value.contains(RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "يرجى إدخال بريد إلكتروني صحيح (مثال: example@email.com)"
          : "Please enter a valid email (e.g., example@email.com)";
    }
    return null;
  }

  // Enhanced password validation with more descriptive messages
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "كلمة المرور مطلوبة لحماية حسابك"
          : "Password is required to secure your account";
    }
    if (value.length < 8) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل"
          : "Password must be at least 8 characters long";
    }
    if (!ispassword8char ||
        !ispassword1number ||
        !ispassworduppercase ||
        !ispasswordlowercase ||
        !ispasswordspecialchar) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "كلمة المرور يجب أن تحتوي على حرف كبير، حرف صغير، رقم، ورمز خاص"
          : "Password must include uppercase, lowercase, number, and special character";
    }
    return null;
  }

  // Enhanced confirm password validation with more descriptive messages
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "يرجى تأكيد كلمة المرور للتأكد من صحتها"
          : "Please confirm your password to ensure it's correct";
    }
    if (value != passwordController.text) {
      return Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "كلمتا المرور غير متطابقتين، يرجى التحقق مرة أخرى"
          : "Passwords do not match, please check again";
    }
    return null;
  }

  // Email field onChanged handler
  void onEmailChanged(String value) {
    setState(() {
      isEmailValid = value.isNotEmpty &&
          value.contains(RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
    });
  }

  // Password field onChanged handler
  void onPasswordChanged(String value) {
    onpasswordchange(value);
    onpasswordnumber(value);
    onpassworduppercase(value);
    onpasswordlowercase(value);
    onpasswordspecialchar(value);

    setState(() {
      isPasswordValid = value.length >= 8 &&
          ispassword8char &&
          ispassword1number &&
          ispassworduppercase &&
          ispasswordlowercase &&
          ispasswordspecialchar;
    });
  }

  // Confirm password field onChanged handler
  void onConfirmPasswordChanged(String value) {
    setState(() {
      isConfirmPasswordValid =
          value.isNotEmpty && value == passwordController.text;
    });
  }

  // Enhanced form validation with detailed feedback
  void validateAndSubmit() async {
    if (!_formKey.currentState!.validate()) {
      final isArabic =
          Provider.of<LanguageProvider>(context, listen: false).isArabic;
      String message = isArabic
          ? "يرجى تصحيح الأخطاء التالية:"
          : "Please correct the following:";

      if (!isEmailValid) {
        message += isArabic
            ? "\n- إدخال بريد إلكتروني صحيح (مثال: example@email.com)"
            : "\n- Enter a valid email (e.g., example@email.com)";
      }
      if (!isPasswordValid) {
        message += isArabic
            ? "\n- إدخال كلمة مرور قوية (8 أحرف على الأقل، حرف كبير، حرف صغير، رقم، ورمز خاص)"
            : "\n- Enter a strong password (at least 8 characters, uppercase, lowercase, number, and special character)";
      }
      if (!isConfirmPasswordValid) {
        message += isArabic
            ? "\n- تأكيد كلمة المرور بشكل صحيح"
            : "\n- Confirm your password correctly";
      }
      if (!termsChecked) {
        message += isArabic
            ? "\n- الموافقة على الشروط والأحكام"
            : "\n- Agree to the terms and conditions";
      }

      showCustomTopSnackBar(context, message, true);
      return;
    }

    if (!termsChecked) {
      final isArabic =
          Provider.of<LanguageProvider>(context, listen: false).isArabic;
      showCustomTopSnackBar(
          context,
          isArabic
              ? "يجب الموافقة على الشروط والأحكام للمتابعة"
              : "You must agree to the terms and conditions to continue",
          true);
      return;
    }

    await register();
  }

  // Helper method for password requirements
  Widget _buildPasswordRequirement(bool isMet, String text) {
    return Row(
      children: [
        Container(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 15,
          ),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isMet ? Colors.green : Colors.white,
            border: Border.all(color: Color.fromARGB(255, 189, 189, 189)),
          ),
        ),
        SizedBox(width: 12.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'eras-itc-light',
          ),
        ),
      ],
    );
  }

  // Helper method to show top snackbar
  void showCustomTopSnackBar(
      BuildContext context, String message, bool isError) {
    final snackBar = CustomSnackBar.info(
      message: message,
      backgroundColor: isError ? Colors.red : mainColor,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
    );

    showTopSnackBar(
      Overlay.of(context),
      snackBar,
      persistent: false,
      animationDuration: Duration(milliseconds: 500),
      reverseAnimationDuration: Duration(milliseconds: 500),
      displayDuration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    bool isArabic = languageProvider.isArabic;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isArabic ? "إنشاء حساب" : "sign up",
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
          actions: [
            IconButton(
              onPressed: () {
                final languageProvider =
                    Provider.of<LanguageProvider>(context, listen: false);
                languageProvider.toggleLanguage();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      languageProvider.isArabic
                          ? 'تم تغيير اللغة إلى العربية'
                          : 'Language changed to English',
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30.0),
                      //logo
                      add_logo(80.0),
                      SizedBox(height: 15.0),
                      // title
                      Add_AppName(
                        font_size: 34.0,
                        align: TextAlign.center,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.0),
                      //specific user
                      Text(
                        isArabic ? "مالك الملعب" : "stadium owner",
                        style: TextStyle(
                          color: Color.fromARGB(111, 0, 0, 0),
                          fontWeight: FontWeight.w200,
                          fontSize: 20.0,
                          fontFamily: 'eras-itc-light',
                        ),
                      ),
                      SizedBox(height: 40.0),

                      //inputs:

                      //Email
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        color: Color(0xC7FFFFFF),
                        width: double.infinity,
                        height: 60.0,
                        child: TextFormField(
                          validator: validateEmail,
                          onChanged: onEmailChanged,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: isArabic ? "البريد الإلكتروني" : "Email",
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
                      SizedBox(height: 15.0),

                      //password
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        color: Color(0xC7FFFFFF),
                        width: double.infinity,
                        height: 60.0,
                        child: TextFormField(
                          validator: validatePassword,
                          onChanged: onPasswordChanged,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: isArabic ? "كلمة المرور" : "Password",
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
                      SizedBox(height: 15.0),

                      //confirm password
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        color: Color(0xC7FFFFFF),
                        width: double.infinity,
                        height: 60.0,
                        child: TextFormField(
                          validator: validateConfirmPassword,
                          onChanged: onConfirmPasswordChanged,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: confirmPasswordController,
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
                            hintText: isArabic
                                ? "تأكيد كلمة المرور"
                                : "Confirm Password",
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
                      SizedBox(height: 25.0),

                      // Password requirements
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            _buildPasswordRequirement(
                              ispassword8char,
                              isArabic
                                  ? "8 أحرف على الأقل"
                                  : "At least 8 characters",
                            ),
                            SizedBox(height: 12.0),
                            _buildPasswordRequirement(
                              ispassword1number,
                              isArabic
                                  ? "رقم واحد على الأقل"
                                  : "At least 1 number",
                            ),
                            SizedBox(height: 12.0),
                            _buildPasswordRequirement(
                              ispassworduppercase,
                              isArabic ? "حرف كبير" : "Has Uppercase",
                            ),
                            SizedBox(height: 12.0),
                            _buildPasswordRequirement(
                              ispasswordlowercase,
                              isArabic ? "حرف صغير" : "Has Lowercase",
                            ),
                            SizedBox(height: 12.0),
                            _buildPasswordRequirement(
                              ispasswordspecialchar,
                              isArabic ? "رمز خاص" : "Has Special Character",
                            ),
                          ],
                        ),
                      ),

                      //check terms
                      Container(
                        margin: EdgeInsets.only(top: 25.0, left: 30.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  termsChecked = !termsChecked;
                                });
                              },
                              icon: termsChecked
                                  ? Icon(Icons.check_box_rounded,
                                      color: mainColor)
                                  : Icon(Icons.check_box_outline_blank_rounded,
                                      color: Colors.grey),
                            ),
                            Text(isArabic ? "أوافق على" : "Agree to"),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      isArabic
                                          ? "الشروط والأحكام"
                                          : "Terms and Conditions",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'eras-itc-demi',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Container(
                                      height: 300.0,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          isArabic
                                              ? "١. المقدمة\nمرحبًا بك في تطبيق Vámonos (\"التطبيق\"). تحكم هذه الشروط والأحكام استخدامك للتطبيق المقدم من Vámonos. باستخدامك للتطبيق، فإنك توافق على الالتزام بهذه الشروط. إذا لم توافق، يجب ألا تستخدم التطبيق.\n\n٢. تعريف الخدمة\nيقدم تطبيق Vámonos منصة لمالكي المنشآت الرياضية لإدراج ملاعبهم والسماح للمستخدمين بحجزها ودفع ثمنها عبر الإنترنت. تتم جميع المعاملات المالية من خلال نظام الدفع داخل التطبيق.\n\n٣. تسجيل الحساب\nلإتمام الحجز أو إدراج ملعبك، يجب عليك إنشاء حساب شخصي. أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور، وعن جميع الأنشطة التي تحدث ضمن حسابك.\n\n٤. مسؤوليات المستخدم\nللمستخدمين (حجز الملاعب):\nأنت مسؤول عن إدخال معلومات الحجز بدقة (مثل تاريخ الحجز، الوقت، وتفاصيل الدفع).\nيجب التأكد من أن جميع المدفوعات تتم من خلال قنوات الدفع المعتمدة داخل التطبيق.\n\nلأصحاب المنشآت:\nيجب على مالكي المنشآت تقديم معلومات دقيقة وكاملة عن ملاعبهم (مثل الحجم، الموقع، التسعير، والمرافق المتاحة).\nيجب عليك تحديث قوائمك باستمرار لضمان الدقة.\nيجب على مالكي المنشآت إدارة جميع الحجوزات والمدفوعات عبر نظام الدفع داخل التطبيق.\n\n٥. الدفع عبر الإنترنت\nتتم جميع المدفوعات من خلال نظام الدفع المدمج في التطبيق. أنت توافق على أن رسوم الحجز سيتم خصمها من حسابك عبر طرق الدفع المعتمدة داخل التطبيق.\n\n٦. سياسة الخصوصية\nنحن نقدر خصوصيتك. سيتم جمع بياناتك الشخصية واستخدامها وفقًا لسياسة الخصوصية الخاصة بنا، والتي تشرح كيفية التعامل مع معلوماتك وحمايتها. باستخدامك للتطبيق، فإنك توافق على جمع واستخدام بياناتك كما هو موضح في سياسة الخصوصية.\n\n٧. القيود القانونية\nلا يجوز لك استخدام التطبيق لأي أنشطة غير قانونية أو سلوك احتيالي.\nيجب عليك الامتثال للقوانين المحلية عند استخدام التطبيق أو التفاعل مع مستخدمين آخرين على المنصة.\n\n٨. تحديد المسؤولية\nيتم توفير التطبيق \"كما هو\" و\"كما هو متاح\". لا تضمن Vámonos أن التطبيق سيكون خاليًا من الأخطاء أو متاحًا باستمرار.\nنحن غير مسؤولين عن أي خسائر أو أضرار تنشأ عن استخدامك للتطبيق، بما في ذلك، على سبيل المثال لا الحصر، أخطاء الحجز أو فشل المعاملات المالية.\n\n٩. إنهاء الحساب\nنحتفظ بالحق في تعليق أو إنهاء حسابك إذا انتهكت هذه الشروط أو شاركت في أي أنشطة غير قانونية أو غير مصرح بها أثناء استخدام التطبيق.\n\n١٠. تعديلات على الشروط\nتحتفظ Vámonos بالحق في تحديث أو تعديل هذه الشروط في أي وقت. تسري التغييرات فور نشرها على التطبيق أو موقعنا الإلكتروني.\n\n١١. القانون الحاكم\nتخضع هذه الشروط وتفسر وفقًا لقوانين مصر. أي نزاعات تنشأ عن هذه الشروط ستكون خاضعة للاختصاص الحصري لمحاكم مصر.\n\n١٢. اتصل بنا\nإذا كان لديك أي أسئلة أو استفسارات حول هذه الشروط والأحكام، يرجى التواصل معنا عبر [معلومات الاتصال — سيتم تحديثها].\n\n"
                                              : "1. Introduction\nWelcome to the Vámonos app (the \"App\"). These Terms and Conditions govern your use of the App, provided by Vámonos. By accessing or using the App, you agree to comply with these Terms. If you do not agree, you should not use the App.\n\n2. Service Definition\nThe Vámonos app provides a platform for sports facility owners to list their fields and allow users to book and pay for them online. All financial transactions are handled via the in-app payment system.\n\n3. Account Registration\nTo complete a booking or list your field, you must create a personal account. You are responsible for maintaining the confidentiality of your account information and password, as well as for all activities that occur under your account.\n\n4. User Responsibilities\nFor Users (Booking the Fields):\nYou are responsible for entering accurate booking information (such as booking date, time, and payment details).\nYou must ensure that all payments are made through the approved payment channels within the app.\nFor Facility Owners:\nFacility owners must provide accurate and complete information about their fields (such as size, location, pricing, and available amenities).\nYou must keep your listings updated to ensure accuracy.\nFacility owners must handle all bookings and payments via the in-app payment system.\n\n5. Online Payment\nAll payments are processed through the app's integrated payment system. You agree that charges for bookings will be deducted from your account through the approved payment methods within the app.\n\n6. Privacy Policy\nWe value your privacy. Your personal data will be collected and used in accordance with our [Privacy Policy], which explains how we handle and protect your information. By using the App, you consent to the collection and use of your data as described in the Privacy Policy.\n\n7. Legal Restrictions\nYou may not use the app for any unlawful activities or fraudulent behavior.\nYou must comply with local laws when using the app or interacting with other users on the platform.\n\n8. Limitation of Liability\nThe app is provided \"as is\" and \"as available.\" Vámonos does not guarantee that the app will be error-free or continuously available.\nWe are not responsible for any losses or damages that arise from your use of the app, including, but not limited to, booking errors or failed payment transactions.\n\n9. Account Termination\nWe reserve the right to suspend or terminate your account if you violate these Terms or engage in any illegal or unauthorized activities while using the app.\n\n10. Modifications to Terms\nVámonos reserves the right to update or modify these Terms at any time. Changes will take effect immediately once posted on the app or our website.\n\n11. Governing Law\nThese Terms are governed by and construed in accordance with the laws of Egypt. Any disputes arising from these Terms will be subject to the exclusive jurisdiction of the courts in Egypt.\n\n12. Contact Us\nIf you have any questions or concerns about these Terms and Conditions, please contact us at [Contact Information — to be updated].\n\n",
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(isArabic ? "حسنًا" : "OK"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                isArabic
                                    ? 'الشروط والأحكام'
                                    : 'terms and conditions',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),

                      //sign up
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.0),
                        height: 50.0,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: validateAndSubmit,
                          content: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  isArabic ? 'إنشاء حساب' : 'sign up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "eras-itc-bold",
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
