import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup_pg1_player extends StatefulWidget {
  @override
  State<Signup_pg1_player> createState() => _Signup_pg1_playerState();
}

class _Signup_pg1_playerState extends State<Signup_pg1_player> {
  File? imgPath;
  String? profileImage;
  // location visiblity and visibl of items on location
  bool visibleOfLocation = false;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;
  bool visibleOfDateOfBirth =
      false; // New variable to control the visibility of the popup window for a field Date of Birth

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

Future<void> uploadImage(String filePath) async {
    final File file = File(filePath);
    final storage = Supabase.instance.client.storage.from('photo'); // اختر الـ bucket المناسب
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';  // اسم الصورة بناءً على الوقت الحالي

    try {
      final response = await storage.upload(fileName, file);
      if (response != null && response.isNotEmpty) {
        print('Image uploaded successfully');
        setState(() {
          profileImage = storage.getPublicUrl(fileName); // رابط الصورة
        });
      } else {
        print('Upload image failed: ${response?.isEmpty ?? "Unknown response state"}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
  // upload image
  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
        await uploadImage(pickedImg.path); // رفع الصورة إلى Supabase
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  'Photo Library',
                  style: TextStyle(fontFamily: "eras-itc-bold", fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  uploadImage2Screen(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text(
                  'Camera',
                  style: TextStyle(fontFamily: "eras-itc-bold", fontSize: 15),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await uploadImage2Screen(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // New variables to store the entered values ​​year, month and day
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  // Variable to store the date of birth value
  String dateOfBirth = "";

  Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('phoneNumber', phoneNumberController.text);
    await prefs.setString('dateOfBirth', dateOfBirth);
    await prefs.setString('location', Location ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  // title
                  Add_AppName(
                      font_size: 34.0,
                      align: TextAlign.center,
                      color: Colors.black),
                  //specific user
                  Text("Player",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontSize: 20.0,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  //logo
                  logo,
                  SizedBox(
                    height: 20.0,
                  ),

                  // profile pic
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: mainColor,
                          width: 1.5,
                        )),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 77.0,
                                backgroundImage: AssetImage(
                                    "assets/welcome_signup_login/imgs/avatar.png"),
                              )
                            : ClipOval(
                                child: Image.file(imgPath!,
                                    width: 154.0,
                                    height: 154.0,
                                    fit: BoxFit.cover),
                              ),
                        Positioned(
                          bottom: -6,
                          right: -1,
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: mainColor,
                              ),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                showImageSourceActionSheet(context);
                              },
                              icon: Icon(Icons.add_a_photo),
                              iconSize: 20,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // just space
                  SizedBox(
                    height: 20.0,
                  ),
                  //inputs:

                  //username
                  Create_Input(
                    controller: usernameController,
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
                    height: 20.0,
                  ),

                  //phone
                  Create_Input(
                    controller: phoneNumberController,
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
                    addPrefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //date birh
                  Create_Input(
                    initValue: dateOfBirth,
                    on_tap: () {
                      setState(() {
                        visibleOfDateOfBirth = true;
                      });
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
                  Create_GradiantGreenButton(
                    title: 'Next',
                    onButtonPressed: () async {
                      if (usernameController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          Location != null &&
                          Location!.isNotEmpty &&
                          dateOfBirth.isNotEmpty &&
                          imgPath != null) {
                        // رفع الصورة إلى Supabase
                        await uploadImage(imgPath!.path); // تأكد من رفع الصورة
                        await storeData();
                        Navigator.pushNamed(context, '/sign_up_pg2_player');
                      } else {
                        // Show an alert dialog or a snackbar to inform the user to fill all fields
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Incomplete Information'),
                              content:
                                  Text('Please fill all the required fields.'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                                    BorderRadius.circular(
                                                        10.0)),
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
                                                  contentPadding:
                                                      EdgeInsets.only(
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
              ),

              // Date of Birth
              Visibility(
                visible: visibleOfDateOfBirth,
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
                              //close Date of Birth
                              Positioned(
                                // padding: EdgeInsets.only(right: 10.0, top: 10.0),
                                top: 10.0,
                                right: 10.0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visibleOfDateOfBirth = false;
                                    });
                                  },
                                  child: Icon(Icons.close_rounded,
                                      color: Colors.black, size: 30.0),
                                ),
                              ),
                              //inputs
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  // Date of Birth input
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
                                      child: Icon(
                                        Icons.date_range_rounded,
                                        color: mainColor,
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Year input
                                            Flexible(
                                              child: TextField(
                                                controller: yearController,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10.0),
                                                    hintText: 'Year'),
                                              ),
                                            ),
                                            // Month input
                                            Flexible(
                                              child: TextField(
                                                controller: monthController,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10.0),
                                                    hintText: 'Month'),
                                              ),
                                            ),
                                            // Day input
                                            Flexible(
                                              child: TextField(
                                                controller: dayController,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10.0),
                                                    hintText: 'Day'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  // Done button
                                  Create_GradiantGreenButton(
                                      title: 'Done',
                                      onButtonPressed: () {
                                        setState(() {
                                          visibleOfDateOfBirth = false;
                                          dateOfBirth =
                                              "${yearController.text}-${monthController.text}-${dayController.text}";
                                          print("Date of Birth: $dateOfBirth");
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
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
