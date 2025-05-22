import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/addAccountImage_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
 
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:supabase_flutter/supabase_flutter.dart';

class Signup_pg1_player extends StatefulWidget {
  @override
  State<Signup_pg1_player> createState() => _Signup_pg1_playerState();
}

class _Signup_pg1_playerState extends State<Signup_pg1_player> {


  //text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? location;
  DateTime? dateOfBirth;

  // Variable to store the date of birth value

  Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('phoneNumber', phoneNumberController.text);
    await prefs.setString('dateOfBirth', dateOfBirth.toString());
    await prefs.setString('location', location ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    bool isArabic = languageProvider.isArabic;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              isArabic ? "إنشاء حساب" : "Sign Up",
              style: TextStyle(
                color: Color(0xFF000000),
                fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Welcome');
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
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(children: [
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
                  Text(isArabic ?"لاعب":"player",
                      style: TextStyle(
                          color: Color.fromARGB(111, 0, 0, 0),
                          fontWeight: FontWeight.w200,
                          fontSize: 20.0,
                          fontFamily: languageProvider.isArabic ? "Cairo" : "eras-itc-light")),
                  //just for space
                  SizedBox(
                    height: 60.0,
                  ),

                  //inputs:

                  //username
                  Create_Input(
                    controller: usernameController,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                        hintText: isArabic ? "اسم المستخدم" : "Username",
                    addPrefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  //phone
                  Create_Input(
                    controller: phoneNumberController,
                    isPassword: false,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                        hintText: isArabic ? "رقم الهاتف" : "Phone Number",
                    addPrefixIcon: Icon(
                      Icons.phone,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  //location
                  Create_Input(
                    onChange: (value) {
                      location = value;
                    },
                    on_tap: () {
                      BottomPicker(
                        items: isArabic
                            ? getEgyptGovernoratesWidgets(context)
                            : egyptGovernoratesWidgets,
                        height: 600.0,
                        titlePadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        buttonContent: Icon(Icons.navigate_next_rounded,
                            color: Colors.white, size: 22.0),
                        buttonPadding: 10.0,
                        buttonStyle: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        pickerTextStyle:
                            TextStyle(fontSize: 20.0, color: Colors.black),
                        pickerTitle: Text(
                            isArabic ? 'اختر المحافظة' : 'Select Governorate',

                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 24.0)),
                        pickerDescription: Text(
                            isArabic
                                  ? 'اختر المحافظة التي يقع فيها الملعب'
                                  : 'Choose the governorate where the stadium is located',
                            style: TextStyle(fontWeight: FontWeight.w400)),
                        onSubmit: (selectedIndex) {
                          String governorate = isArabic
                              ? getEgyptGovernorates(context)[selectedIndex]
                              : egyptGovernorates[selectedIndex];
                          setState(() {
                            citySelected = governorate;
                          });
                          // Navigator.pop(context);

                          Future.delayed(Duration(milliseconds: 300), () {
                            // Start place picker
                            List<Widget> placeWidgets =
                                egyptGovernoratesAndCenters[citySelected]!
                                    .map((place) => Center(
                                          child: Text(
                                            place,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                    .toList();

                            BottomPicker(
                              items: placeWidgets,
                              height: 600.0,
                              titlePadding:
                                  EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                              buttonContent: Icon(Icons.navigate_next_rounded,
                                  color: Colors.white, size: 22.0),
                              buttonPadding: 10.0,
                              buttonStyle: BoxDecoration(
                                gradient: greenGradientColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              pickerTextStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              pickerTitle: Text(                                  isArabic ? 'اختر المكان' : 'Select Place',

                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0)),
                              pickerDescription: Text(
                                  isArabic
                                      ? 'اختر المكان الذي يقع فيه الملعب'
                                      : 'Choose the place where the stadium is located',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400)),
                              onSubmit: (selectedPlaceIndex) {
                                String place = egyptGovernoratesAndCenters[
                                    citySelected]![selectedPlaceIndex];
                                setState(() {
                                  placeSelected = place;
                                });
                                Future.delayed(Duration(milliseconds: 300), () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              20,
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text( isArabic
                                                  ? 'ادخل اسم الحي'
                                                  : 'Enter Neighborhood',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            SizedBox(height: 15),
                                            Create_RequiredInput(
                                              onChange: (value) {
                                                neighborhoodEnterd.text = value;
                                              },
                                              lableText:
                                                  isArabic ? 'ادخل اسم الحي' : 'Enter your neighborhood',
                                              initValue:
                                                  neighborhoodEnterd.text,
                                              textInputType: TextInputType.text,
                                              add_prefix: Icon(
                                                  Icons.location_on,
                                                  color: mainColor),
                                            ),
                                            SizedBox(height: 15),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  location =
                                                      '$citySelected - $placeSelected - ${neighborhoodEnterd.text}';
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: greenGradientColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                              },
                            ).show(context);
                          });
                        },
                      ).show(context);
                    },
                    controller: location == null
                        ? TextEditingController()
                        : TextEditingController(text: location),
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    isReadOnly: true,
                        hintText: isArabic ? "موقعك" : "your location",
                    addPrefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  //date birth
                  Create_Input(
                    controller: dateOfBirth != null
                        ? TextEditingController(
                            text: '${dateOfBirth?.day}/${dateOfBirth?.month}/${dateOfBirth?.year}')
                        : TextEditingController(),
                    onChange: (date) {
                      dateOfBirth = date;
                    },
                    on_tap: () {
                      BottomPicker.date(
                        maxDateTime: DateTime.now(),
                        minDateTime: DateTime(1800),
                        initialDateTime: DateTime.now(),
                        titlePadding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        buttonContent:
                            Icon(Icons.check, color: Colors.white, size: 22.0),
                        buttonPadding: 10.0,
                        buttonStyle: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        pickerTextStyle:
                            TextStyle(fontSize: 20.0, color: Colors.black),
                        pickerTitle: Text(                              isArabic ? 'متى وُلدت؟' : 'when you were born ?',
 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                        onSubmit: (newDateValue) {
                          setState(() {
                            dateOfBirth = newDateValue;
                          });
                        },
                      ).show(context);
                    },
                    // on_tap: () async {
                    //   DateTime? newDateTime = await showRoundedDatePicker(
                    //     context: context,
                    //     height: 200,
                    //     background: const Color.fromARGB(54, 0, 0, 0),
                    //     description: "Date of birth",
                    //     theme: ThemeData(
                    //       primarySwatch: Colors.green,
                    //       hintColor: mainColor, // Ensure accent color is green
                    //       colorScheme: ColorScheme.light(
                    //         primary: const Color.fromARGB(120, 0, 185, 46),
                    //         onPrimary: mainColor,
                    //       ),
                    //       textButtonTheme: TextButtonThemeData(
                    //         style: TextButton.styleFrom(
                    //           foregroundColor:
                    //               mainColor, // Set text color for OK and Cancel
                    //         ),
                    //       ),
                    //     ),
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime(DateTime.now().year - 60),
                    //     lastDate: DateTime(DateTime.now().year + 1),
                    //     borderRadius: 30,
                    //   );

                    //   if (newDateTime != null) {
                    //     setState(() {
                    //       selectedDate = newDateTime;
                    //       // Update the dateOfBirth value
                    //       dateOfBirth =
                    //           "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}";
                    //     });
                    //   }
                    // },
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                        hintText: isArabic ? "تاريخ الميلاد" : "Date of birth",
                    addPrefixIcon: Icon(
                      Icons.date_range_rounded,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                  ),

                  //next
                  SizedBox(
                    height: 50.0,
                    child: Create_GradiantGreenButton(
                      content: Text(
                            isArabic ? 'التالي' : 'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'eras-itc-bold',
                            fontSize: 24.0),
                      ),
                      onButtonPressed: () async {
                        // Ensure all fields are filled
                        if (usernameController.text.trim().isNotEmpty &&
                            phoneNumberController.text.trim().isNotEmpty &&
                            location != null &&
                            location!.trim().isNotEmpty &&
                            dateOfBirth != null) {
                          await storeData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => addAccountImage_player(),
                            ),
                          );
                        } else {
                          // Show an alert dialog to inform the user to fill all fields
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                    title: Text(isArabic ? 'معلومات غير مكتملة' : 'Incomplete Information'),
                                content: Text(
                                    isArabic
                                      ? 'يرجى ملء جميع الحقول المطلوبة.'
                                      : 'Please fill all the required fields.',),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                        isArabic ? 'حسناً' : 'OK',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 30.0),
                  //don't have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(                          isArabic ? 'هل لديك حساب؟ ' : 'have an account? ',

                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login_player');
                          },
                          child: Text( isArabic ? 'سجّل الدخول الآن' : 'login now',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 16.0,
                              )))
                    ],
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
