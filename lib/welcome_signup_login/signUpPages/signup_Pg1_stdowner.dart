import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/addAccountImage_owner.dart';
// import 'package:graduation_project_main/welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

class Signup_pg1_StdOwner extends StatefulWidget {
  @override
  State<Signup_pg1_StdOwner> createState() => _Signup_pg1_StdOwnerState();
}

class _Signup_pg1_StdOwnerState extends State<Signup_pg1_StdOwner> {
  //text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? location;
  DateTime? dateOfBirth;

  // Update location selection variables
  String? selectedGovernorate;
  String? selectedCenter;
  String? placeName;
  final TextEditingController placeNameController = TextEditingController();

  @override
  void dispose() {
    placeNameController.dispose();
    super.dispose();
  }

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
          extendBodyBehindAppBar: false,
          //app bar language
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
              // ic
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
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
                    Text(isArabic ? "مالك الملعب" : "stadium owner",
                        style: TextStyle(
                            color: Color.fromARGB(111, 0, 0, 0),
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            fontFamily: languageProvider.isArabic
                                ? "Cairo"
                                : "eras-itc-light")),
                    //just for space
                    SizedBox(
                      height: 60.0,
                    ),

                    //inputs:

                    //username
                    Create_Input(
                        onChange: (username) {
                          usernameController.text = username;
                        },
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.none,
                        hintText: isArabic ? "اسم المستخدم" : "Username",
                        addPrefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: mainColor,
                        )),
                    SizedBox(
                      height: 30.0,
                    ),

                    //phone
                    Create_Input(
                        onChange: (phone) {
                          phoneNumberController.text = phone;
                        },
                        isPassword: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        hintText: isArabic ? "رقم الهاتف" : "Phone Number",
                        addPrefixIcon: Icon(Icons.phone, color: mainColor)),
                    SizedBox(
                      height: 30.0,
                    ),

                    //location
                    Create_Input(
                      on_tap: () => _showLocationPicker(context),
                      controller: locationController,
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      isReadOnly: true,
                      hintText: isArabic ? "موقعك" : "Your Location",
                      addPrefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 30.0),

                    //date birh
                    Create_Input(
                      controller: dateOfBirth != null
                          ? TextEditingController(
                              text:
                                  '${dateOfBirth?.day}/${dateOfBirth?.month}/${dateOfBirth?.year}')
                          : TextEditingController(),
                      on_tap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: mainColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: mainColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            dateOfBirth = picked;
                          });
                        }
                      },
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
                      height: 60.0,
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
                              locationController.text.trim().isNotEmpty &&
                              dateOfBirth != null) {
                            await storeData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => addAccountImage_owner(),
                              ),
                            );
                          } else {
                            // Show an alert dialog to inform the user to fill all fields
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(isArabic
                                      ? 'معلومات غير مكتملة'
                                      : 'Incomplete Information'),
                                  content: Text(
                                    isArabic
                                        ? 'يرجى ملء جميع الحقول المطلوبة.'
                                        : 'Please fill all the required fields.',
                                  ),
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
                    SizedBox(height: 10.0),
                    //don't have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isArabic ? 'هل لديك حساب؟ ' : 'have an account? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login_stadium');
                            },
                            child: Text(
                                isArabic ? 'سجّل الدخول الآن' : 'login now',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16.0,
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showLocationPicker(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final bool isArabic = languageProvider.isArabic;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            final List<String> governorates = getEgyptGovernorates(context);
            final Map<String, List<String>> governoratesCenters =
                getGovernoratesCenters(context);

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 8,
              backgroundColor: Colors.white,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.95),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title with decorative line
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            isArabic ? 'اختر موقعك' : 'Select Your Location',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: isArabic ? 'Cairo' : 'eras-itc-bold',
                              fontSize: 22,
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 50,
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Inputs Container
                    Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Governorate Dropdown
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: mainColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText:
                                    isArabic ? 'المحافظة' : 'Governorate',
                                labelStyle: TextStyle(
                                  color: mainColor.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                prefixIcon: Icon(Icons.location_city,
                                    color: mainColor, size: 20),
                              ),
                              value: selectedGovernorate,
                              items: governorates.map((String governorate) {
                                return DropdownMenuItem<String>(
                                  value: governorate,
                                  child: Text(
                                    governorate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setDialogState(() {
                                  selectedGovernorate = newValue;
                                  selectedCenter = null;
                                  placeName = null;
                                  placeNameController.clear();
                                });
                              },
                              dropdownColor: Colors.white,
                              icon:
                                  Icon(Icons.arrow_drop_down, color: mainColor),
                              isExpanded: true,
                              menuMaxHeight: 300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Center Dropdown
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: mainColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: isArabic ? 'المركز' : 'Center',
                                labelStyle: TextStyle(
                                  color: mainColor.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                prefixIcon: Icon(Icons.location_on,
                                    color: mainColor, size: 20),
                              ),
                              value: selectedCenter,
                              items: selectedGovernorate != null &&
                                      governoratesCenters
                                          .containsKey(selectedGovernorate)
                                  ? governoratesCenters[selectedGovernorate]!
                                      .map((String center) {
                                      return DropdownMenuItem<String>(
                                        value: center,
                                        child: Text(
                                          center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [],
                              onChanged: selectedGovernorate != null
                                  ? (String? newValue) {
                                      setDialogState(() {
                                        selectedCenter = newValue;
                                        placeName = null;
                                        placeNameController.clear();
                                      });
                                    }
                                  : null,
                              dropdownColor: Colors.white,
                              icon:
                                  Icon(Icons.arrow_drop_down, color: mainColor),
                              isExpanded: true,
                              menuMaxHeight: 300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Place Name Input
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: mainColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: TextField(
                              controller: placeNameController,
                              decoration: InputDecoration(
                                labelText:
                                    isArabic ? 'اسم المكان' : 'Place Name',
                                labelStyle: TextStyle(
                                  color: mainColor.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                                hintText: isArabic
                                    ? 'مثال: شارع النيل'
                                    : 'Example: Nile Street',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                prefixIcon: Icon(Icons.home,
                                    color: mainColor, size: 20),
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              onChanged: (String? value) {
                                setDialogState(() {
                                  placeName = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Buttons
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              isArabic ? 'إلغاء' : 'Cancel',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: mainColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (selectedGovernorate != null &&
                                      selectedCenter != null &&
                                      placeName != null &&
                                      placeName!.trim().isNotEmpty) {
                                    setState(() {
                                      location =
                                          '$selectedGovernorate, $selectedCenter, ${placeName!.trim()}';
                                      locationController.text = location!;
                                    });
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isArabic
                                              ? 'يرجى ملء جميع الحقول المطلوبة'
                                              : 'Please fill all required fields',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    isArabic ? 'تأكيد' : 'Confirm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
