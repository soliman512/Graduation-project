<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../reusable_widgets/reusable_widgets.dart';
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

class Signup_pg1_player extends StatefulWidget {
  @override
  State<Signup_pg1_player> createState() => _Signup_pg1_playerState();
}

class _Signup_pg1_playerState extends State<Signup_pg1_player> {
<<<<<<< HEAD


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
=======
  // location visiblity and visibl of items on location
  bool visibleOfLocation = false;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;
  bool checkInputs() {
    if (visibleOfPlace == true && visibleOfNeighborhood == true) {
      visibleOfButton = true;
      return true;
    }
    return false;
  }

  String? Location;
  void initValueOfLocation() {
    if (citySelected == null) {
      Location = "";
    } else {
      Location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
    }
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar language
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
                Navigator.pushNamed(context, '/login_signup_player');
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
<<<<<<< HEAD
=======
              // ic
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
<<<<<<< HEAD
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
=======
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFF000000),
                  )),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
            ],
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(children: [
<<<<<<< HEAD
                  SizedBox(
                    height: 44.0,
                  ),
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

=======
                  Text("Player",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        // fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.w200,
                        fontSize: 20.0,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  //logo
                  logo,
                  SizedBox(
                    height: 70.0,
                  ),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                  //inputs:

                  //username
                  Create_Input(
<<<<<<< HEAD
                    controller: usernameController,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                        hintText: isArabic ? "اسم المستخدم" : "Username",
=======
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Username",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    addPrefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
<<<<<<< HEAD
                    height: 30.0,
=======
                    height: 20.0,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                  ),

                  //phone
                  Create_Input(
<<<<<<< HEAD
                    controller: phoneNumberController,
                    isPassword: false,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                        hintText: isArabic ? "رقم الهاتف" : "Phone Number",
=======
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Phone Number",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    addPrefixIcon: Icon(
                      Icons.phone,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
<<<<<<< HEAD
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
=======
                    height: 20.0,
                  ),
                  //location
                  Create_Input(
                    initValue: Location,
                    on_tap: () {
                      setState(() {
                        visibleOfLocation = true;
                      });
                    },
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Location",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    addPrefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
<<<<<<< HEAD
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
=======
                    height: 20.0,
                  ),
                  //date birh
                  Create_Input(
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
<<<<<<< HEAD
                        hintText: isArabic ? "تاريخ الميلاد" : "Date of birth",
=======
                    hintText: "Date of Birth",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    addPrefixIcon: Icon(
                      Icons.date_range_rounded,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                  ),

                  //next
<<<<<<< HEAD
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
=======
                  Create_GradiantGreenButton(
                      title: 'Next',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/sign_up_pg2_player');
                      })
                ]),
              ),

              //location
              Visibility(
                visible: visibleOfLocation,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: null,
                        padding: EdgeInsets.only(bottom: 20.0),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 150.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 100.0)
                            ],
                            color: Colors.white
                            // color: Colors.red
                            ),
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              //close location
                              Positioned(
                                // padding: EdgeInsets.only(right: 10.0, top: 10.0),
                                top: 10.0,
                                right: 10.0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visibleOfLocation = false;
                                    });
                                  },
                                  child: Icon(Icons.close_rounded,
                                      color: Colors.black, size: 30.0),
                                ),
                              ),
                              //inputs
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  //city
                                  ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.all(8.0),
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x7C000000),
                                              blurRadius: 10.0)
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/home_loves_tickets_top/imgs/city_Vector.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x7C000000),
                                                blurRadius: 10.0)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          onChanged: (String? cityValue) {
                                            setState(() {
                                              visibleOfPlace = true;
                                              citySelected = cityValue;
                                              placesOfCityOnSelected = null;
                                              placeSelected = null;
                                            });
                                            placesOfCityOnSelected =
                                                egyptGovernoratesAndCenters[
                                                    cityValue];
                                          },
                                          items: egyptGovernorates.map((city) {
                                            return DropdownMenuItem<String>(
                                              value: city,
                                              child: Text(city),
                                            );
                                          }).toList(),
                                          menuMaxHeight: 300.0,
                                          value: citySelected,
                                          hint: Text('select City'),
                                          icon: Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              size: 30.0,
                                              color: mainColor),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                          alignment: Alignment.center,
                                          underline: null,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              
                                  //place
                                  Visibility(
                                    visible: visibleOfPlace,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0)
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x7C000000),
                                                    blurRadius: 10.0)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              items: placesOfCityOnSelected
                                                  ?.map((String place) {
                                                return DropdownMenuItem<String>(
                                                  child: Text(place),
                                                  value: place,
                                                );
                                              }).toList(),
                                              onChanged: (String? placeValue) {
                                                setState(() {
                                                  visibleOfNeighborhood = true;
                                                  placeSelected = placeValue;
                                                });
                                              },
                                              menuMaxHeight: 300.0,
                                              value: placeSelected,
                                              hint: Text('select place'),
                                              icon: Icon(
                                                  Icons
                                                      .arrow_drop_down_circle_outlined,
                                                  size: 30.0,
                                                  color: mainColor),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                              alignment: Alignment.center,
                                              underline: null,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              
                                  // //neighborhood
                                  Visibility(
                                    visible: visibleOfNeighborhood,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0)
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/home_loves_tickets_top/imgs/nighborhood.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0x7C000000),
                                                      blurRadius: 10.0)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            child: TextField(
                                              controller: neighborhoodEnterd,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  hintText: 'neighborhood'),
                                            )),
                                      ),
                                    ),
                                  ),
                              
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  // //button
                                  Visibility(
                                    visible: checkInputs(),
                                    child: Create_GradiantGreenButton(
                                        title: 'Done',
                                        onButtonPressed: () {
                                          setState(() {
                                            visibleOfLocation = false;
                                            initValueOfLocation();
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
            ],
          )),
    );
  }
}
