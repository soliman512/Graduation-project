import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:supabase_flutter/supabase_flutter.dart';

class Signup_pg1_player extends StatefulWidget {
  @override
  State<Signup_pg1_player> createState() => _Signup_pg1_playerState();
}

class _Signup_pg1_playerState extends State<Signup_pg1_player> {
  // location visiblity and visibl of items on location
  bool locationPopup = false;
  double locationPopupHeight = 0.0;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;
  DateTime? selectedDate;

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
  }

  String username = '';
  String phoneNumber = '';
  String dateOfBirth = "";


  Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('dateOfBirth', dateOfBirth);
    await prefs.setString('location', Location ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text("sign up",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_signup_player');
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
                  Text("player",
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
                    onChange: (value) {
                      username = value;
                    },
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Username",
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
                    onChange: (value) {
                      phoneNumber = value;
                    },
                    isPassword: false,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    hintText: "Phone Number",
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
                      Location = value;
                    },
                    on_tap: () {
                      setState(() {
                        locationPopup = !locationPopup;
                        locationPopupHeight = locationPopup ? 500.0 : 0.0;
                      });
                    },
                    controller: Location == null
                        ? TextEditingController()
                        : TextEditingController(text: Location),
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
                  SizedBox(
                    height: 30.0,
                  ),
                  //date birth
                  Create_Input(
                    controller: selectedDate == null
                        ? TextEditingController()
                        : TextEditingController(
                            text:
                                "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}"),
                    onChange: (date) {
                      dateOfBirth = date;
                    },
                    on_tap: () async {
                      DateTime? newDateTime = await showRoundedDatePicker(
                        context: context,
                        height: 200,
                        background: const Color.fromARGB(54, 0, 0, 0),
                        description: "Date of birth",
                        theme: ThemeData(
                          primarySwatch: Colors.green,
                          hintColor: mainColor, // Ensure accent color is green
                          colorScheme: ColorScheme.light(
                            primary: const Color.fromARGB(120, 0, 185, 46),
                            onPrimary: mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  mainColor, // Set text color for OK and Cancel
                            ),
                          ),
                        ),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 60),
                        lastDate: DateTime(DateTime.now().year + 1),
                        borderRadius: 30,
                      );

                      if (newDateTime != null) {
                        setState(() {
                          selectedDate = newDateTime;
                        });
                      }
                    },
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Date of Birth",
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
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'eras-itc-bold',
                            fontSize: 24.0),
                      ),
                      onButtonPressed: () async {
                        if (username.isNotEmpty &&
                            phoneNumber.isNotEmpty &&
                            Location != null &&
                            dateOfBirth.isNotEmpty) {
                          Navigator.pushNamed(context, '/addAccountImage_player');
                        } else {

                          // Show an alert dialog or a snackbar to inform the user to fill all fields
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
                          Navigator.pushNamed(context, '/addAccountImage_player');
                        
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 30.0),
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
                            Navigator.pushNamed(context, '/login_player');
                          },
                          child: Text('login now',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 16.0,
                              )))
                    ],
                  )
                ]),
              ),

              //location popup
              Stack(
                children: [
                  Visibility(
                    visible: locationPopup,
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                    ),
                  ),
                  Center(
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: double.infinity,
                        height: locationPopupHeight,
                        margin: EdgeInsets.symmetric(horizontal: 32.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.75),
                              blurRadius: 100.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            //close button
                            Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    locationPopup = false;
                                    locationPopupHeight = 0.0;
                                  });
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                            //content
                            Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text("select your location",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: const Color.fromARGB(
                                                80, 0, 0, 0),
                                            fontFamily: 'eras-itc-demi')),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'if you don’t find your place please write your place before \nyour neighborhood',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ), //inputs
                                    SizedBox(height: 60.0),
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
                                              blurRadius: 10.0,
                                            ),
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
                                          horizontal: 20.0,
                                        ),
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x7C000000),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
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
                                            items:
                                                egyptGovernorates.map((city) {
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
                                              color: mainColor,
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                            ),
                                            alignment: Alignment.center,
                                            underline: null,
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
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
                                                  blurRadius: 10.0,
                                                ),
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
                                              horizontal: 20.0,
                                            ),
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: DropdownButton<String>(
                                                items: placesOfCityOnSelected
                                                    ?.map((
                                                  String place,
                                                ) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(place),
                                                    value: place,
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (String? placeValue) {
                                                  setState(() {
                                                    visibleOfNeighborhood =
                                                        true;
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
                                                  color: mainColor,
                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                                alignment: Alignment.center,
                                                underline: null,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20.0,
                                                ),
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
                                                  blurRadius: 10.0,
                                                ),
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
                                              horizontal: 20.0,
                                            ),
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
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
                                                  bottom: 10.0,
                                                ),
                                                hintText: 'neighborhood',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20.0),
                                    // //button
                                    Visibility(
                                      visible: checkInputs(),
                                      child: SizedBox(
                                        height: 50.0,
                                        child: Create_GradiantGreenButton(
                                          content: Text(
                                            'Done',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'eras-itc-demi',
                                                fontSize: 20.0),
                                          ),
                                          onButtonPressed: () {
                                            if (citySelected == 'another' &&
                                                    neighborhoodEnterd
                                                        .text.isEmpty ||
                                                placeSelected == 'another' &&
                                                    neighborhoodEnterd
                                                        .text.isEmpty) {
                                              showDialog(
                                                context: context,
                                                barrierColor:
                                                    const Color.fromARGB(
                                                        113, 0, 0, 0),
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    elevation: 120,
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Row(
                                                      children: [
                                                        Icon(Icons.error,
                                                            color: Colors.red),
                                                        SizedBox(width: 8.0),
                                                        Text("infull location"),
                                                      ],
                                                    ),
                                                    content: Text(
                                                      "Please, write a full location in neightborhood field.",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("OK",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: mainColor,
                                                            )),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              setState(() {
                                                initValueOfLocation();
                                                locationPopupHeight = 0.0;
                                                locationPopup = false;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
