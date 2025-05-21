import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
// import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNewStadium extends StatefulWidget {
  const AddNewStadium({Key? key}) : super(key: key);

  @override
  State<AddNewStadium> createState() => _AddNewStadiumState();
}

List<Widget> egyptGovernoratesWidgets = egyptGovernorates.map((governorate) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        governorate,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}).toList();
List<Widget> gevornmentPlacesWidgets = egyptGovernoratesAndCenters
        .containsKey(citySelected)
    ? egyptGovernoratesAndCenters[citySelected]!.map((place) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              place,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList()
    : []; // Return an empty list if the selected city doesn't exist in the map

class _AddNewStadiumState extends State<AddNewStadium> {
  // controllers
  final TextEditingController stadiumNameController = TextEditingController();
  final TextEditingController stadiumPriceController = TextEditingController();
  final TextEditingController stadiumDescriptionController =
      TextEditingController();
  final TextEditingController stadiumCapacityController =
      TextEditingController();
  final TextEditingController neighborhoodEnterd =
      TextEditingController(); // if not defined

// location
  String? citySelected;
  String? placeSelected;
  String location = '';

  String testLocatin = '';
// time settings
  String timeStart = '';
  String timeEnd = '';

// days
  bool isDaysOpened = false;
  List<String> daysSelected = [];

  List<Map<String, dynamic>> selectDays = [
    {'day': 'Saturday', 'isSelected': false},
    {'day': 'Sunday', 'isSelected': false},
    {'day': 'Monday', 'isSelected': false},
    {'day': 'Tuesday', 'isSelected': false},
    {'day': 'Wednesday', 'isSelected': false},
    {'day': 'Thursday', 'isSelected': false},
    {'day': 'Friday', 'isSelected': false},
  ];

// visibilities
  bool locationPopup = false;
  double locationPopupHeight = 0.0;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;

// images
  List<File> selectedImages = [];
  List<String> selectedImagesUrl = [];
  final ImagePicker multibleImages_picker = ImagePicker();

// features
  bool isWaterAvailable = true;
  bool isTrackAvailable = false;
  bool isGrassNormal = false;

// check if ready to show button
  bool checkInputs() {
    if (visibleOfPlace && visibleOfNeighborhood) {
      visibleOfButton = true;
      return true;
    }
    return false;
  }

// generate final location
  void initValueOflocation() {
    if (citySelected == null) {
      location = '';
    } else {
      location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
    }
  }

// choose multiple images
  Future<void> getImages() async {
    final pickFile = await multibleImages_picker.pickMultiImage(
      imageQuality: 80,
      maxHeight: 1000.0,
      maxWidth: 1000.0,
    );

    if (pickFile.isNotEmpty) {
      selectedImages.clear();
      selectedImagesUrl.clear();

      for (var file in pickFile) {
        selectedImages.add(File(file.path));
        selectedImagesUrl.add(file.path);
      }
      setState(() {});
    }
  }

// Handle Post Button Press
  void _handlePostButtonPressed() {
    if (_isFormIncomplete()) {
      _showIncompleteDataDialog();
    } else {
      addStadiumToFirestore(
        name: stadiumNameController.text,
        location: location,
        hasWater: isWaterAvailable,
        hasTrack: isTrackAvailable,
        isNaturalGrass: isGrassNormal,
        price: double.parse(stadiumPriceController.text),
        description: stadiumDescriptionController.text,
        capacity: int.parse(stadiumCapacityController.text),
        startTime: timeStart,
        endTime: timeEnd,
        workingDays: daysSelected,
        imagesUrl: selectedImagesUrl,
        userID: FirebaseAuth.instance.currentUser?.uid ?? 'No User ID'
      );

      Navigator.pushNamed(context, '/home_owner');
    }
  }

// add new stadium to firestore
  Future<void> addStadiumToFirestore({
    required String name,
    required String location,
    required bool hasWater,
    required bool hasTrack,
    required bool isNaturalGrass,
    required double price,
    required String description,
    required int capacity,
    required String startTime,
    required String endTime,
    required List<String> workingDays,
    required String userID,
    required List<String> imagesUrl,
  }) async {
    final stadiumData = {
      "name": name,
      "location": location,
      "hasWater": hasWater,
      "hasTrack": hasTrack,
      "isNaturalGrass": isNaturalGrass,
      "price": price,
      "description": description,
      "capacity": capacity,
      "startTime": startTime,
      "endTime": endTime,
      "workingDays": workingDays,
      "createdAt": FieldValue.serverTimestamp(),
      "userID" : userID,
      "images" : imagesUrl,
    };

    try {
      await FirebaseFirestore.instance.collection("stadiums").add(stadiumData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LanguageProvider>(context).isArabic ? 'تم إضافة الملعب بنجاح' : 'Stadium added successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LanguageProvider>(context).isArabic ? ':حدث خطأ $e' : 'Error: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

// Check if any required field is empty
  bool _isFormIncomplete() {
    return stadiumNameController.text.isEmpty ||
        stadiumPriceController.text.isEmpty ||
        stadiumDescriptionController.text.isEmpty ||
        stadiumCapacityController.text.isEmpty ||
        location.isEmpty ||
        timeStart.toString().isEmpty ||
        timeEnd.toString().isEmpty ||
        daysSelected.isEmpty ||
        selectedImages.isEmpty;
  }

// Show alert dialog if the form is incomplete
  void _showIncompleteDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Provider.of<LanguageProvider>(context).isArabic ? 'بيانات غير كاملة' : 'Incomplete Data'),
          content: Text(Provider.of<LanguageProvider>(context).isArabic ? 'الرجاء ملء جميع الحقول المطلوبة.' : 'Please fill all the required fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: mainColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(Provider.of<LanguageProvider>(context).isArabic ? 'إلغاء البيانات؟' : 'Discard data?'),
                    content: Text(Provider.of<LanguageProvider>(context).isArabic ? 'هل أنت متأكد أنك تريد إلغاء البيانات؟' : 'Are you sure you want to discard?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home_owner');
                        },
                        child: const Text("discard",
                            style: TextStyle(color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle the first button press
                          Navigator.of(context).pop();
                        },
                        child: const Text("return"),
                      ),
                    ],
                  );
                });
          },
          icon: Image.asset("assets/welcome_signup_login/imgs/back.png"),
          color: Color(0xff000000),
        ),
      ),
      body: Stack(children: [
        // backgroundImage_balls,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.0),
                Image.asset(
                    'assets/stdowner_addNewStadium/imgs/NewStadium.png'),
                    // Text(
                    //   FirebaseAuth.instance.currentUser?.uid ?? 'No User ID',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                // name input
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumNameController.text = value;
                  },
                  initValue: stadiumNameController.text,
                  lableText: Provider.of<LanguageProvider>(context).isArabic ? 'اسم الملعب' : 'Stadium Name',
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/sign.png',
                  ),
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic ? 'بيانات الملعب' : 'Stadium data',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()), // Divider on the right side
                  ],
                ),
                SizedBox(height: 60.0),
                //add image
                Container(
                  height: 250.0,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: mainColor, width: 1.0),
                  ),
                  child: selectedImages.isEmpty
                      ? //ask to add image
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/stdowner_addNewStadium/imgs/threeCards.png',
                            ),
                            GestureDetector(
                              onTap: getImages,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 100.0,
                                  vertical: 12.0,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'إضافة صورة' : 'Add Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: greenGradientColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Text(
                              Provider.of<LanguageProvider>(context).isArabic ? '5MB حجم الملف الأقصى المقبول \nفي التوقيعات التالية:  .jpg   .jpeg,   .png ' : '5MB maximum file size accepted \nin the following formats:  .jpg   .jpeg,   .png ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        )
                      :
                      //images after adding
                      GridView.builder(
                          itemCount: selectedImages.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  child: Image.file(
                                    selectedImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),

                SizedBox(height: 40.0),

                //stadium location
                Create_RequiredInput(
                  onTap: () {
                    BottomPicker(
                      items: egyptGovernoratesWidgets,
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
                      pickerTitle: Text(Provider.of<LanguageProvider>(context).isArabic ? 'اختر المحافظة' : 'Select Governorate',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24.0)),
                      pickerDescription: Text(
                          Provider.of<LanguageProvider>(context).isArabic ? 'اختر المحافظة حيث يوجد الملعب' : 'Choose the governorate where the stadium is located',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                      onSubmit: (selectedIndex) {
                        String governorate = egyptGovernorates[selectedIndex];
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
                            pickerTextStyle:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                            pickerTitle: Text(Provider.of<LanguageProvider>(context).isArabic ? 'اختر المكان' : 'Select Place',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24.0)),
                            pickerDescription: Text(
                                Provider.of<LanguageProvider>(context).isArabic ? 'اختر المكان حيث يوجد الملعب' : 'Choose the place where the stadium is located',
                                style: TextStyle(fontWeight: FontWeight.w400)),
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
                                          Text(Provider.of<LanguageProvider>(context).isArabic ? 'أدخل الحي' : 'Enter Neighborhood',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          SizedBox(height: 15),
                                          TextField(
                                            controller: neighborhoodEnterd,
                                            decoration: InputDecoration(
                                              hintText:
                                                  Provider.of<LanguageProvider>(context).isArabic ? 'أدخل الحي' : 'Enter your neighborhood',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                location =
                                                    '$citySelected - $placeSelected - ${neighborhoodEnterd.text}';
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text(Provider.of<LanguageProvider>(context).isArabic ? 'حفظ' : 'Save'),
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic ? 'موقع الملعب': 'Stadium location',
                  initValue: location,
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/location.png',
                  ),
                ),
                SizedBox(height: 32.0),
                //stadium price
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumPriceController.text = value;
                  },
                  initValue: stadiumPriceController.text,
                  lableText: Provider.of<LanguageProvider>(context).isArabic ? 'السعر': 'Set Price',
                  textInputType: TextInputType.number,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/price.png',
                  ),
                  add_suffix: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      '.LE',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 18.0,
                        fontFamily: 'eras-itc-bold',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),

                //stadium description
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumDescriptionController.text = value;
                  },
                  initValue: stadiumDescriptionController.text,
                  lableText: Provider.of<LanguageProvider>(context).isArabic ? 'الوصف' : 'Description',
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/desc.png',
                  ),
                ),

                SizedBox(height: 32.0),
                //capacity
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumCapacityController.text = value;
                  },
                  initValue: stadiumCapacityController.text,
                  lableText: Provider.of<LanguageProvider>(context).isArabic ? 'الكميه' : 'Capacity',
                  textInputType: TextInputType.number,
                  add_prefix: Icon(
                    Icons.group,
                    color: const Color.fromARGB(255, 0, 156, 39),
                  ),
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic ? 'المميزات' : 'features',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()), // Divider on the right side
                  ],
                ),
                SizedBox(height: 60.0),
                //water, track, grass
                Wrap(
                  spacing: 4.0,
                  runSpacing: 8.0,
                  children: [
                    //water
                    Center(
                      child: Container(
                        width: double.infinity,
                        //height: 220.0,
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isWaterAvailable,
                          first: false,
                          second: true,
                          spacing: 45.0,
                          animationDuration: Duration(milliseconds: 500),
                          style: ToggleStyle(
                            borderColor: Colors.transparent,
                            indicatorColor: Colors.white,
                            backgroundColor: Colors.black,
                            indicatorBorder: Border.all(
                              color: mainColor,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0.2,
                                blurRadius: 0.5,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          customStyleBuilder: (context, local, global) {
                            if (global.position <= 0) {
                              return ToggleStyle(
                                backgroundColor: Colors.white,
                              );
                            }
                            return ToggleStyle(
                              backgroundGradient: greenGradientColor,
                            );
                          },
                          borderWidth: 6.0,
                          height: 60.0,
                          loadingIconBuilder: (context, global) =>
                              CupertinoActivityIndicator(
                            color: Color.lerp(
                              Colors.grey,
                              mainColor,
                              global.position,
                            ),
                          ),
                          onChanged: (value) =>
                              setState(() => isWaterAvailable = value),
                          iconBuilder: (value) => value
                              ? Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/water.png',
                                )
                              : Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/noWater.png',
                                ),
                          textBuilder: (value) => value
                              ? Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? ' متوفر ماء' : 'Water is Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'غير متوفر ماء' : 'Water not available',
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    // track
                    Center(
                      child: Container(
                        width: double.infinity,
                        //height: 220.0,
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isTrackAvailable,
                          first: false,
                          second: true,
                          spacing: 45.0,
                          animationDuration: Duration(milliseconds: 500),
                          style: ToggleStyle(
                            borderColor: Colors.transparent,
                            indicatorColor: Colors.white,
                            backgroundColor: Colors.black,
                            indicatorBorder: Border.all(
                              color: mainColor,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0.2,
                                blurRadius: 0.5,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          customStyleBuilder: (context, local, global) {
                            if (global.position <= 0) {
                              return ToggleStyle(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ),
                              );
                            }
                            return ToggleStyle(
                              backgroundGradient: greenGradientColor,
                            );
                          },
                          borderWidth: 6.0,
                          height: 60.0,
                          loadingIconBuilder: (context, global) =>
                              CupertinoActivityIndicator(
                            color: Color.lerp(
                              Colors.grey,
                              mainColor,
                              global.position,
                            ),
                          ),
                          onChanged: (value) =>
                              setState(() => isTrackAvailable = value),
                          iconBuilder: (value) => value
                              ? Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/track.png',
                                )
                              : Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/noTrack.png',
                                ),
                          textBuilder: (value) => value
                              ? Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'متوفر مسار': 'Available Track',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'غير متوفر مسار': 'Unavailable Track',
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    //grass
                    Center(
                      child: Container(
                        width: double.infinity,
                        //height: 220.0,
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isGrassNormal,
                          first: false,
                          second: true,
                          spacing: 45.0,
                          animationDuration: Duration(milliseconds: 300),
                          style: ToggleStyle(
                            borderColor: Colors.transparent,
                            indicatorColor: Colors.white,
                            backgroundColor: Colors.black,
                            indicatorBorder: Border.all(
                              color: mainColor,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0.2,
                                blurRadius: 0.5,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          customStyleBuilder: (context, local, global) {
                            if (global.position <= 0) {
                              return ToggleStyle(
                                backgroundColor: Colors.white,
                              );
                            }
                            return ToggleStyle(
                              backgroundGradient: greenGradientColor,
                            );
                          },
                          borderWidth: 6.0,
                          height: 60.0,
                          loadingIconBuilder: (context, global) =>
                              CupertinoActivityIndicator(
                            color: Color.lerp(
                              const Color.fromARGB(255, 158, 158, 158),
                              mainColor,
                              global.position,
                            ),
                          ),
                          onChanged: (value) =>
                              setState(() => isGrassNormal = value),
                          iconBuilder: (value) => value
                              ? Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/grass.png',
                                  width: 40.0,
                                )
                              : Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/grass.png',
                                  width: 40.0,
                                ),
                          textBuilder: (value) => value
                              ? Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'عشب صناعي': 'Industry Grass',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context).isArabic ? 'عشب طبيعي': 'Normal Grass',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ),
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic ? 'وقت العمل': 'time work',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()), // Divider on the right side
                  ],
                ),
                SizedBox(height: 60.0),
                //selct time:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.none,
                        onTap: () {
                          //   Navigator.of(context).push(
                          //     showPicker(
                          //       context: context,
                          //       value: Time(hour: 7, minute: 00),
                          //       sunrise: TimeOfDay(
                          //         hour: 6,
                          //         minute: 0,
                          //       ), // optional
                          //       sunset: TimeOfDay(
                          //         hour: 18,
                          //         minute: 0,
                          //       ), // optional
                          //       duskSpanInMinutes: 120, // optional
                          //       onChange: (value) {
                          //         setState(() {
                          //           timeStart =
                          //               '${value.hourOfPeriod.toString().padLeft(2, '0')} : ${value.minute.toString().padLeft(2, '0')} ${value.period == DayPeriod.am ? 'AM' : 'PM'}';
                          //         });
                          //       },
                          //     ),
                          //   );
                          BottomPicker.time(
                            titlePadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                            buttonContent: Icon(Icons.check,
                                color: Colors.white, size: 22.0),
                            buttonPadding: 10.0,
                            buttonStyle: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            minuteInterval: 15,
                            showTimeSeparator: true,
                            pickerTextStyle:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                            pickerTitle: Text(
                                Provider.of<LanguageProvider>(context).isArabic ? 'متى تريد فتح الملعب في اليوم؟': 'when you will open stadium in each day ?'),
                            initialTime: Time(hours: 7, minutes: 30),
                            onSubmit: (timeStartValue) {
                              final formattedTime =
                                  DateFormat.jm().format(timeStartValue);
                              setState(() {
                                timeStart = formattedTime;
                              });
                            },
                          ).show(context);
                        },
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 18.0,
                          fontFamily: 'eras-itc-demi',
                        ),
                        controller: TextEditingController(text: timeStart),
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: Provider.of<LanguageProvider>(context).isArabic ? 'بداية من': 'start from',
                          hintStyle: TextStyle(fontSize: 16.0),
                          fillColor: Colors.white60,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(60, 0, 0, 0),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: mainColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.none,
                        controller: TextEditingController(text: timeEnd),
                        onTap: () {
                          // Navigator.of(context).push(
                          //   showPicker(
                          //     context: context,
                          //     value: Time(hour: 23, minute: 00),
                          //     sunrise: TimeOfDay(
                          //       hour: 6,
                          //       minute: 0,
                          //     ), // optional
                          //     sunset: TimeOfDay(
                          //       hour: 18,
                          //       minute: 0,
                          //     ), // optional
                          //     duskSpanInMinutes: 120, // optional
                          //     onChange: (value) {
                          //       setState(() {
                          //         timeEnd =
                          //             '${value.hourOfPeriod.toString().padLeft(2, '0')} : ${value.minute.toString().padLeft(2, '0')} ${value.period == DayPeriod.am ? 'AM' : 'PM'}';
                          //       });
                          //     },
                          //   ),
                          // );
                          BottomPicker.time(
                            titlePadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                            buttonContent: Icon(Icons.check,
                                color: Colors.white, size: 22.0),
                            buttonPadding: 10.0,
                            buttonStyle: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            minuteInterval: 15,
                            showTimeSeparator: true,
                            pickerTextStyle:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                            pickerTitle: Text(
                               Provider.of<LanguageProvider>(context).isArabic ?'متى تريد فتح الملعب في اليوم؟': 'when you will open stadium in each day ?'),
                            initialTime: Time(hours: 7, minutes: 30),
                            onSubmit: (timeEndValue) {
                              final formattedTime =
                                  DateFormat.jm().format(timeEndValue);
                              setState(() {
                                timeEnd = formattedTime;
                              });
                            },
                          ).show(context);
                        },
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 18.0,
                          fontFamily: 'eras-itc-demi',
                        ),
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: Provider.of<LanguageProvider>(context).isArabic ? 'ينتهي في': 'End on',
                          hintStyle: TextStyle(fontSize: 16.0),
                          fillColor: Colors.white60,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(60, 0, 0, 0),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: mainColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic ? ' أيام العمل': 'work days',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()), // Divider on the right side
                  ],
                ),
                SizedBox(height: 60.0),
                //work time
                Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: selectDays.length,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectDays[i]['isSelected'] =
                                !selectDays[i]['isSelected'];
                            if (selectDays[i]['isSelected']) {
                              daysSelected.add(selectDays[i]['day']);
                            } else {
                              daysSelected.remove(selectDays[i]['day']);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: selectDays[i]['isSelected']
                                ? greenGradientColor
                                : null, // No gradient if not selected
                            // color: selectDays[i]['isSelected']
                            //     ? Colors
                            //         .transparent // Allow gradient to be visible
                            // : Colors.grey[100],
                            border: Border.all(
                              color: selectDays[i]['isSelected']
                                  ? Colors.transparent
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: selectDays[i]['isSelected']
                                ? [
                                    BoxShadow(
                                      color: mainColor.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    )
                                  ]
                                : [],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.calendar_today,
                              //   size: 18,
                              //   color: selectDays[i]['isSelected']
                              //       ? Colors.white
                              //       : Colors.grey,
                              // ),
                              // SizedBox(width: 8),
                              Text(
                                selectDays[i]['day'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: selectDays[i]['isSelected']
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic ? 'انشر ملعبك': 'Post your stadium',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()), // Divider on the right side
                  ],
                ),
                SizedBox(height: 60.0),

                //post,
                SizedBox(
                  height: 50.0,
                  child: Create_GradiantGreenButton(
                    onButtonPressed: _handlePostButtonPressed,
                    content: Text(
                      Provider.of<LanguageProvider>(context).isArabic ? 'انشر': 'Post',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'eras-itc-bold',
                          fontSize: 24.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),

        //location popup
//         Stack(
//           children: [
//             Visibility(
//               visible: locationPopup,
//               child: Container(
//                 width: double.infinity,
//                 color: Colors.transparent,
//               ),
//             ),
//             Center(
//               child: AnimatedContainer(
//                   duration: Duration(milliseconds: 500),
//                   width: double.infinity,
//                   height: locationPopupHeight,
//                   margin: EdgeInsets.symmetric(horizontal: 32.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.75),
//                         blurRadius: 100.0,
//                         offset: Offset(0, 0),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
// //close button
//                       Positioned(
//                         top: 10.0,
//                         right: 10.0,
//                         child: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               locationPopup = false;
//                               locationPopupHeight = 0.0;
//                             });
//                           },
//                           icon: Icon(Icons.close),
//                         ),
//                       ),
// //content and done button
//                       Center(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 30.0,
//                               ),
//                               Text("select your location",
//                                   style: TextStyle(
//                                       fontSize: 20.0,
//                                       color: const Color.fromARGB(80, 0, 0, 0),
//                                       fontFamily: 'eras-itc-demi')),
//                               SizedBox(height: 12.0),
//                               Text(
//                                 'if you don't find your place please write your place before \nyour neighborhood',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 10.0,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ), //inputs
//                               SizedBox(height: 60.0),
//                               //city
//                               ListTile(
//                                 leading: Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   width: 40.0,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(0x7C000000),
//                                         blurRadius: 10.0,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Image.asset(
//                                     'assets/home_loves_tickets_top/imgs/city_Vector.png',
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 title: Container(
//                                   width: double.infinity,
//                                   margin: EdgeInsets.symmetric(
//                                     horizontal: 20.0,
//                                   ),
//                                   height: 40.0,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(0x7C000000),
//                                         blurRadius: 10.0,
//                                       ),
//                                     ],
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   child: Center(
//                                     child: DropdownButton<String>(
//                                       onChanged: (String? cityValue) {
//                                         setState(() {
//                                           visibleOfPlace = true;
//                                           citySelected = cityValue;
//                                           placesOfCityOnSelected = null;
//                                           placeSelected = null;
//                                         });
//                                         placesOfCityOnSelected =
//                                             egyptGovernoratesAndCenters[
//                                                 cityValue];
//                                       },
//                                       items: egyptGovernorates.map((city) {
//                                         return DropdownMenuItem<String>(
//                                           value: city,
//                                           child: Text(city),
//                                         );
//                                       }).toList(),
//                                       menuMaxHeight: 300.0,
//                                       value: citySelected,
//                                       hint: Text('select City'),
//                                       icon: Icon(
//                                         Icons.arrow_drop_down_circle_outlined,
//                                         size: 30.0,
//                                         color: mainColor,
//                                       ),
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 18.0,
//                                       ),
//                                       alignment: Alignment.center,
//                                       underline: null,
//                                       borderRadius: BorderRadius.circular(
//                                         20.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               //place
//                               Visibility(
//                                 visible: visibleOfPlace,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(top: 20.0),
//                                   child: ListTile(
//                                     leading: Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       width: 40.0,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color(0x7C000000),
//                                             blurRadius: 10.0,
//                                           ),
//                                         ],
//                                       ),
//                                       child: Image.asset(
//                                         'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     title: Container(
//                                       width: double.infinity,
//                                       margin: EdgeInsets.symmetric(
//                                         horizontal: 20.0,
//                                       ),
//                                       height: 40.0,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color(0x7C000000),
//                                             blurRadius: 10.0,
//                                           ),
//                                         ],
//                                         borderRadius: BorderRadius.circular(
//                                           10.0,
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: DropdownButton<String>(
//                                           items: placesOfCityOnSelected?.map((
//                                             String place,
//                                           ) {
//                                             return DropdownMenuItem<String>(
//                                               child: Text(place),
//                                               value: place,
//                                             );
//                                           }).toList(),
//                                           onChanged: (String? placeValue) {
//                                             setState(() {
//                                               visibleOfNeighborhood = true;
//                                               placeSelected = placeValue;
//                                             });
//                                           },
//                                           menuMaxHeight: 300.0,
//                                           value: placeSelected,
//                                           hint: Text('select place'),
//                                           icon: Icon(
//                                             Icons
//                                                 .arrow_drop_down_circle_outlined,
//                                             size: 30.0,
//                                             color: mainColor,
//                                           ),
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 18.0,
//                                           ),
//                                           alignment: Alignment.center,
//                                           underline: null,
//                                           borderRadius: BorderRadius.circular(
//                                             20.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               //neighborhood
//                               Visibility(
//                                 visible: visibleOfNeighborhood,
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: 20.0,
//                                   ),
//                                   child: ListTile(
//                                     leading: Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       width: 40.0,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color(0x7C000000),
//                                             blurRadius: 10.0,
//                                           ),
//                                         ],
//                                       ),
//                                       child: Image.asset(
//                                         'assets/home_loves_tickets_top/imgs/nighborhood.png',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     title: Container(
//                                       width: double.infinity,
//                                       margin: EdgeInsets.symmetric(
//                                         horizontal: 20.0,
//                                       ),
//                                       height: 40.0,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color(0x7C000000),
//                                             blurRadius: 10.0,
//                                           ),
//                                         ],
//                                         borderRadius: BorderRadius.circular(
//                                           10.0,
//                                         ),
//                                       ),
//                                       child: TextField(
//                                         controller: neighborhoodEnterd,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 18.0,
//                                         ),
//                                         keyboardType: TextInputType.text,
//                                         textInputAction: TextInputAction.done,
//                                         decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.only(
//                                             bottom: 10.0,
//                                           ),
//                                           hintText: 'neighborhood',
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               SizedBox(height: 20.0),
//                               //button
//                               Visibility(
//                                 visible: checkInputs(),
//                                 child: SizedBox(
//                                   height: 50.0,
//                                   child: Create_GradiantGreenButton(
//                                     content: Text(
//                                       'Done',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'eras-itc-demi',
//                                           fontSize: 20.0),
//                                     ),
//                                     onButtonPressed: () {
//                                       if (citySelected == 'another' &&
//                                               neighborhoodEnterd.text.isEmpty ||
//                                           placeSelected == 'another' &&
//                                               neighborhoodEnterd.text.isEmpty) {
//                                         showDialog(
//                                           context: context,
//                                           barrierColor: const Color.fromARGB(
//                                               113, 0, 0, 0),
//                                           builder: (BuildContext context) {
//                                             return AlertDialog(
//                                               elevation: 120,
//                                               backgroundColor: Colors.white,
//                                               title: Row(
//                                                 children: [
//                                                   Icon(Icons.error,
//                                                       color: Colors.red),
//                                                   SizedBox(width: 8.0),
//                                                   Text("infull location"),
//                                                 ],
//                                               ),
//                                               content: Text(
//                                                 "Please, write a full location in neightborhood field.",
//                                                 style: TextStyle(
//                                                   fontSize: 12.0,
//                                                   color: const Color.fromARGB(
//                                                       255, 0, 0, 0),
//                                                 ),
//                                               ),
//                                               actions: [
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   child: Text("OK",
//                                                       style: TextStyle(
//                                                         fontSize: 12.0,
//                                                         color: mainColor,
//                                                       )),
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       } else {
//                                         setState(() {
//                                           initValueOflocation();
//                                           locationPopupHeight = 0.0;
//                                           locationPopup = false;
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ],
//         )
      ]),
    );
  }
}
