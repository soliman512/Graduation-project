import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditSelectedStadium extends StatefulWidget {
  final String stadiumName;
  final String stadiumLocation;
  final String stadiumPrice;
  final String stadiumDescription;
  final String stadiumCapacity;
  final List<String> stadiumImagesUrl;
  final String stadiumId;
  final List<String> stadiumWorkingDays;
  final String stadiumStartTime;
  final String stadiumEndTime;
  final bool stadiumHasWater;
  final bool stadiumHasTrack;
  final bool stadiumIsNaturalGrass;

  EditSelectedStadium({
    required this.stadiumName,
    required this.stadiumLocation,
    required this.stadiumPrice,
    required this.stadiumDescription,
    required this.stadiumCapacity,
    required this.stadiumImagesUrl,
    required this.stadiumId,
    required this.stadiumWorkingDays,
    required this.stadiumStartTime,
    required this.stadiumEndTime,
    required this.stadiumHasWater,
    required this.stadiumHasTrack,
    required this.stadiumIsNaturalGrass,
  });

  @override
  State<EditSelectedStadium> createState() => _EditSelectedStadiumState();
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

List<Widget> gevornmentPlacesWidgets =
    egyptGovernoratesAndCenters.containsKey(citySelected)
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
        : [];

class _EditSelectedStadiumState extends State<EditSelectedStadium> {
  // Controllers
  late TextEditingController stadiumNameController;
  late TextEditingController stadiumPriceController;
  late TextEditingController stadiumDescriptionController;
  late TextEditingController stadiumCapacityController;
  late TextEditingController neighborhoodEnterd;

  // Location
  String? citySelected;
  String? placeSelected;
  late String location;

  // Time settings
  late String timeStart;
  late String timeEnd;

  // Days
  bool isDaysOpened = false;
  late List<String> daysSelected;
  late List<Map<String, dynamic>> selectDays;

  // Visibilities
  bool locationPopup = false;
  double locationPopupHeight = 0.0;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;

  // Images
  late List<File> selectedImages;
  late List<String> selectedImagesUrl;
  final ImagePicker multibleImages_picker = ImagePicker();

  // Features
  late bool isWaterAvailable;
  late bool isTrackAvailable;
  late bool isGrassNormal;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with widget data
    stadiumNameController = TextEditingController(text: widget.stadiumName);
    stadiumPriceController = TextEditingController(text: widget.stadiumPrice);
    stadiumDescriptionController =
        TextEditingController(text: widget.stadiumDescription);
    stadiumCapacityController =
        TextEditingController(text: widget.stadiumCapacity);
    neighborhoodEnterd = TextEditingController();

    // Initialize location
    List<String> locationParts = widget.stadiumLocation.split('-');
    if (locationParts.length == 3) {
      citySelected = locationParts[0];
      placeSelected = locationParts[1];
      neighborhoodEnterd.text = locationParts[2];
      location = widget.stadiumLocation;
    } else {
      location = '';
    }

    // Initialize time
    timeStart = widget.stadiumStartTime;
    timeEnd = widget.stadiumEndTime;

    // Initialize working days
    daysSelected = List.from(widget.stadiumWorkingDays);
    selectDays = [
      {
        'day': 'Saturday',
        'isSelected': widget.stadiumWorkingDays.contains('Saturday')
      },
      {
        'day': 'Sunday',
        'isSelected': widget.stadiumWorkingDays.contains('Sunday')
      },
      {
        'day': 'Monday',
        'isSelected': widget.stadiumWorkingDays.contains('Monday')
      },
      {
        'day': 'Tuesday',
        'isSelected': widget.stadiumWorkingDays.contains('Tuesday')
      },
      {
        'day': 'Wednesday',
        'isSelected': widget.stadiumWorkingDays.contains('Wednesday')
      },
      {
        'day': 'Thursday',
        'isSelected': widget.stadiumWorkingDays.contains('Thursday')
      },
      {
        'day': 'Friday',
        'isSelected': widget.stadiumWorkingDays.contains('Friday')
      },
    ];

    // Initialize images
    selectedImages = [];
    selectedImagesUrl = List.from(widget.stadiumImagesUrl);

    // Initialize features
    isWaterAvailable = widget.stadiumHasWater;
    isTrackAvailable = widget.stadiumHasTrack;
    isGrassNormal = widget.stadiumIsNaturalGrass;
  }

  // Check if ready to show button
  bool checkInputs() {
    if (visibleOfPlace && visibleOfNeighborhood) {
      visibleOfButton = true;
      return true;
    }
    return false;
  }

  // Generate final location
  void initValueOflocation() {
    if (citySelected == null) {
      location = '';
    } else {
      location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
    }
  }

  // Choose multiple images
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

  // Handle Update Button Press
  void _handleUpdateButtonPressed() {
    if (_isFormIncomplete()) {
      _showIncompleteDataDialog();
    } else {
      updateStadiumInFirestore(
        stadiumId: widget.stadiumId,
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
        userID: FirebaseAuth.instance.currentUser?.uid ?? 'No User ID',
      );

      Navigator.pushNamed(context, '/home_owner');
    }
  }

  // Update stadium in Firestore
  Future<void> updateStadiumInFirestore({
    required String stadiumId,
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
      "updatedAt": FieldValue.serverTimestamp(),
      "userID": userID,
      "images": imagesUrl,
    };

    try {
      await FirebaseFirestore.instance
          .collection("stadiums")
          .doc(stadiumId)
          .update(stadiumData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stadium updated successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
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
        timeStart.isEmpty ||
        timeEnd.isEmpty ||
        daysSelected.isEmpty ||
        selectedImagesUrl.isEmpty;
  }

  // Show alert dialog if the form is incomplete
  void _showIncompleteDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete Data'),
          content: Text('Please fill all the required fields.'),
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

//open image to show and delete
  Image? openImage;
  bool isImageOpend = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                        isArabic ? "تجاهل التغييرات؟" : "Discard changes?"),
                    content: Text(isArabic
                        ? "هل أنت متأكد أنك تريد تجاهل التغييرات؟"
                        : "Are you sure you want to discard your changes?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home_owner');
                        },
                        child: Text(isArabic ? "تجاهل" : "Discard",
                            style: TextStyle(color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(isArabic ? "رجوع" : "Return"),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 92.0),
                Image.asset(
                    'assets/stdowner_addNewStadium/imgs/NewStadium.png'),
                // Name input
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumNameController.text = value;
                  },
                  initValue: stadiumNameController.text,
                  lableText: isArabic ? 'اسم الملعب' : 'Stadium Name',
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/sign.png',
                  ),
                ),
                SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        isArabic ? 'بيانات الملعب' : 'Stadium Data',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 60.0),
                // Add image
                Container(
                  height: 250.0,
                  padding: EdgeInsets.all(4.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: mainColor, width: 1.0),
                  ),
                  child: GridView.builder(
                    itemCount: selectedImages.isNotEmpty
                        ? selectedImages.length + 1
                        : selectedImagesUrl.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: getImages,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: mainColor, width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 40.0, color: mainColor),
                                  Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'إضافة صورة'
                                        : 'Add Image',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        int adjustedIndex = index - 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isImageOpend = true;
                            });
                            openImage = selectedImages.isNotEmpty
                                ? Image.file(
                                    selectedImages[adjustedIndex],
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    selectedImagesUrl[adjustedIndex],
                                    fit: BoxFit.cover,
                                  );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: mainColor.withOpacity(0.3),
                                width: 1.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: selectedImages.isNotEmpty
                                  ? Image.file(
                                      selectedImages[adjustedIndex],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : Image.network(
                                      selectedImagesUrl[adjustedIndex],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 40.0),
                // Stadium location
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
                      pickerTitle: Text(
                          isArabic ? 'اختر المحافظة' : 'Select Governorate',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24.0)),
                      pickerDescription: Text(
                          isArabic
                              ? 'اختر المحافظة التي يوجد بها الملعب'
                              : 'Choose the governorate where the stadium is located',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                      onSubmit: (selectedIndex) {
                        String governorate = egyptGovernorates[selectedIndex];
                        setState(() {
                          citySelected = governorate;
                        });

                        Future.delayed(Duration(milliseconds: 300), () {
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
                            pickerTitle: Text(
                                Provider.of<LanguageProvider>(context).isArabic
                                    ? 'حدد مكان'
                                    : 'Select Place',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24.0)),
                            pickerDescription: Text(
                                Provider.of<LanguageProvider>(context).isArabic
                                    ? 'اختر مكان الملعب'
                                    : 'Choose the place where the stadium is located',
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
                                          Text(
                                              Provider.of<LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'أدخل الحي'
                                                  : 'Enter Neighborhood',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          SizedBox(height: 15),
                                          TextField(
                                            controller: neighborhoodEnterd,
                                            decoration: InputDecoration(
                                              hintText: Provider.of<
                                                              LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'أدخل الحي الخاص بك'
                                                  : 'Enter your neighborhood',
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
                                            child: Text(
                                                Provider.of<LanguageProvider>(
                                                            context)
                                                        .isArabic
                                                    ? 'حفظ'
                                                    : 'Save'),
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'موقع الملعب'
                      : 'Stadium Location',
                  initValue: location,
                  isReadOnly: true,
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/location.png',
                  ),
                ),
                SizedBox(height: 32.0),
                // Stadium price
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumPriceController.text = value;
                  },
                  initValue: stadiumPriceController.text,
                  lableText: 'Set Price',
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
                // Stadium description
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumDescriptionController.text = value;
                  },
                  initValue: stadiumDescriptionController.text,
                  lableText: 'Description',
                  textInputType: TextInputType.text,
                  add_prefix: Image.asset(
                    'assets/stdowner_addNewStadium/imgs/desc.png',
                  ),
                ),
                SizedBox(height: 32.0),
                // Capacity
                Create_RequiredInput(
                  onChange: (value) {
                    stadiumCapacityController.text = value;
                  },
                  initValue: stadiumCapacityController.text,
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'السعة'
                      : 'Capacity',
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
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'المميزات'
                            : 'Features',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 60.0),
                // Water, track, grass
                Wrap(
                  spacing: 4.0,
                  runSpacing: 8.0,
                  children: [
                    // Water
                    Center(
                      child: Container(
                        width: double.infinity,
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'متاح ماء'
                                        : 'Water is Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'غير متاح ماء'
                                        : 'Water not Available',
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
                    // Track
                    Center(
                      child: Container(
                        width: double.infinity,
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? ' المسار متاح'
                                        : 'Track Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'eras-itc-bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? ' المسار غير متاح'
                                        : 'Track not Available',
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
                    // Grass
                    Center(
                      child: Container(
                        width: double.infinity,
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'عشب الصناعي'
                                        : 'Industry Grass',
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'عشب طبيعي'
                                        : 'Natural Grass',
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
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'وقت العمل'
                            : 'Work Time',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 60.0),
                // Select time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.none,
                        onTap: () {
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
                            pickerTitle: Text(Provider.of<LanguageProvider>(
                                        context)
                                    .isArabic
                                ? 'متى ستفتح الملعب كل يوم؟'
                                : 'When will you open the stadium each day?'),
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
                          hintText:
                              Provider.of<LanguageProvider>(context).isArabic
                                  ? 'يبدأ من'
                                  : 'Start From',
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
                            pickerTitle: Text(Provider.of<LanguageProvider>(
                                        context)
                                    .isArabic
                                ? 'متى سيتم إغلاق الملعب كل يوم؟'
                                : 'When will you close the stadium each day?'),
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
                          hintText:
                              Provider.of<LanguageProvider>(context).isArabic
                                  ? 'ينتهي في '
                                  : 'End On',
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
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? ' أيام العمل'
                            : 'Work Days',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 60.0),
                // Work days
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
                      String dayText = selectDays[i]['day'];
                      if (Provider.of<LanguageProvider>(context).isArabic) {
                        switch (dayText) {
                          case 'Saturday':
                            dayText = 'السبت';
                            break;
                          case 'Sunday':
                            dayText = 'الأحد';
                            break;
                          case 'Monday':
                            dayText = 'الإثنين';
                            break;
                          case 'Tuesday':
                            dayText = 'الثلاثاء';
                            break;
                          case 'Wednesday':
                            dayText = 'الأربعاء';
                            break;
                          case 'Thursday':
                            dayText = 'الخميس';
                            break;
                          case 'Friday':
                            dayText = 'الجمعة';
                            break;
                        }
                      }
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
                                : null,
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
                              Text(
                                dayText,
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
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'تحديث الملعب'
                            : 'Update Your Stadium',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 40.0),
                // Update and Delete buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 55.0,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: _handleUpdateButtonPressed,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.update, color: Colors.white, size: 24),
                              SizedBox(width: 8),
                              Text(
                                Provider.of<LanguageProvider>(context).isArabic
                                    ? 'تحديث'
                                    : 'Update',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'eras-itc-demi',
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'حذف الملعب'
                                        : 'Delete Stadium',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.red),
                                  ),
                                  content: Text(Provider.of<LanguageProvider>(
                                              context)
                                          .isArabic
                                      ? 'هل أنت متأكد من حذف الملعب؟'
                                      : 'Are you sure you want to delete the stadium?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                          Provider.of<LanguageProvider>(context)
                                                  .isArabic
                                              ? 'إلغاء'
                                              : 'Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          final stadiumDoc = FirebaseFirestore
                                              .instance
                                              .collection('stadiums')
                                              .doc(widget.stadiumId);
                                          await stadiumDoc.delete();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Home_Owner(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(Provider.of<
                                                              LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'تم حذف الملعب بنجاح'
                                                  : 'Stadium deleted successfully'),
                                              backgroundColor: Colors.grey[900],
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(Provider.of<
                                                              LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'خطأ في حذف الملعب: $e'
                                                  : 'Error deleting stadium: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                          Provider.of<LanguageProvider>(context)
                                                  .isArabic
                                              ? 'نعم'
                                              : 'Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: Colors.red,
                                width: 2.0,
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 24.0,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  Provider.of<LanguageProvider>(context)
                                          .isArabic
                                      ? 'حذف'
                                      : 'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isImageOpend,
          child: Stack(
            children: [
              blackBackground,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Close button
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isImageOpend = false;
                            openImage = null;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Display image
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      height: 300.0,
                      child: openImage,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    // Remove image button
                    GestureDetector(
                      onTap: () {
                        if (openImage != null) {
                          String? openImagePath;
                          if (openImage!.image is FileImage) {
                            openImagePath =
                                (openImage!.image as FileImage).file.path;
                          } else if (openImage!.image is NetworkImage) {
                            openImagePath =
                                (openImage!.image as NetworkImage).url;
                          }

                          if (openImagePath != null) {
                            int indexToRemove = selectedImages.isNotEmpty
                                ? selectedImages.indexWhere(
                                    (image) => image.path == openImagePath)
                                : selectedImagesUrl
                                    .indexWhere((url) => url == openImagePath);

                            if (indexToRemove != -1) {
                              String removedImageUrl =
                                  selectedImagesUrl[indexToRemove];
                              setState(() {
                                selectedImagesUrl.removeAt(indexToRemove);
                                isImageOpend = false;
                                openImage = null;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Image removed successfully'),
                                  backgroundColor: Colors.black87,
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        selectedImagesUrl.insert(
                                            indexToRemove, removedImageUrl);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
