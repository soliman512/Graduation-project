import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/addAccountImage_owner.dart';
// import 'package:graduation_project_main/welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup_pg1_StdOwner extends StatefulWidget {
  @override
  State<Signup_pg1_StdOwner> createState() => _Signup_pg1_StdOwnerState();
}

class _Signup_pg1_StdOwnerState extends State<Signup_pg1_StdOwner> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? location;
  DateTime? dateOfBirth;

  void initValueOfLocation() {
    if (citySelected == null) {
      location = "";
    } else {
      location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
    }
  }

    Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('phoneNumber', phoneController.text);
    await prefs.setString('dateOfBirth', dateOfBirth.toString());
    await prefs.setString('location', location ?? '');
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
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

                    //username
                    Create_Input(
                        onChange: (username) {
                          usernameController.text = username;
                        },
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.none,
                        hintText: "Username",
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
                          phoneController.text = phone;
                        },
                        isPassword: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        hintText: "Phone Number",
                        addPrefixIcon: Icon(Icons.phone, color: mainColor)),
                    SizedBox(
                      height: 30.0,
                    ),

                    // set location
                    Create_Input(
                      on_tap: () {
                        BottomPicker(
                          items: egyptGovernoratesWidgets,
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
                          pickerTextStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          pickerTitle: Text('Select Governorate',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 24.0)),
                          pickerDescription: Text(
                              'Choose the governorate where the stadium is located',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          onSubmit: (selectedIndex) {
                            String governorate =
                                egyptGovernorates[selectedIndex];
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
                                pickerTitle: Text('Select Place',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24.0)),
                                pickerDescription: Text(
                                    'Choose the place where the stadium is located',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400)),
                                onSubmit: (selectedPlaceIndex) {
                                  String place = egyptGovernoratesAndCenters[
                                      citySelected]![selectedPlaceIndex];
                                  setState(() {
                                    placeSelected = place;
                                  });
                                  Future.delayed(Duration(milliseconds: 300),
                                      () {
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
                                              Text('Enter Neighborhood',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                              SizedBox(height: 15),
                                              Create_RequiredInput(
                                                onChange: (value) {
                                                  neighborhoodEnterd.text =
                                                      value;
                                                },
                                                lableText:
                                                    'Enter your neighborhood',
                                                initValue:
                                                    neighborhoodEnterd.text,
                                                textInputType:
                                                    TextInputType.text,
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
                                                    gradient:
                                                        greenGradientColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                      hintText: "your location",
                      addPrefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 30.0),

                    //date birh
                    Create_Input(
                        controller: dateOfBirth == null
                            ? TextEditingController()
                            : TextEditingController(
                                text:
                                    "${dateOfBirth?.day}/${dateOfBirth?.month}/${dateOfBirth?.year}"),
                        onChange: (date) {
                          dateOfBirth = date;
                        },
                        on_tap: () {
                          BottomPicker.date(
                            maxDateTime: DateTime.now(),
                            minDateTime: DateTime(1800),
                            initialDateTime: DateTime.now(),
                            titlePadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                            buttonContent: Icon(Icons.check,
                                color: Colors.white, size: 22.0),
                            buttonPadding: 10.0,
                            buttonStyle: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            pickerTextStyle:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                            pickerTitle: Text('when you were born ?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0)),
                            onSubmit: (newDateValue) {
                              setState(() {
                                dateOfBirth = newDateValue;
                              });
                            },
                          ).show(context);
                        },
                        isReadOnly: true,
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        hintText: "Date of birth",
                        addPrefixIcon:
                            Icon(Icons.calendar_today, color: mainColor)),
                    SizedBox(
                      height: 60.0,
                    ),

                    //next
                  SizedBox(
                    height: 50.0,
                    child: Create_GradiantGreenButton(
                      content: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'eras-itc-bold',
                            fontSize: 24.0),
                      ),
                      onButtonPressed: () async {
                        // Ensure all fields are filled
                        if (usernameController.text.trim().isNotEmpty &&
                            phoneController.text.trim().isNotEmpty &&
                            location != null &&
                            location!.trim().isNotEmpty &&
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
                                title: Text('Incomplete Information'),
                                content: Text(
                                    'Please fill all the required fields.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
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
                        Text('have an account? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login_stadium');
                            },
                            child: Text('login now',
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
}
