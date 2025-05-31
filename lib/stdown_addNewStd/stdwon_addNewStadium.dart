import 'dart:io';
<<<<<<< HEAD
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
import 'package:supabase_flutter/supabase_flutter.dart';
=======

import 'package:flutter/material.dart';
import 'package:welcome_signup_login/reusable_widgets/reusable_widgets.dart';
import 'package:welcome_signup_login/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

class AddNewStadium extends StatefulWidget {
  const AddNewStadium({Key? key}) : super(key: key);

  @override
  State<AddNewStadium> createState() => _AddNewStadiumState();
}

<<<<<<< HEAD
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
bool isLoading = false;
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
=======
class _AddNewStadiumState extends State<AddNewStadium> {
//select multible images:
  List<File> selectedImages = [];
//pick image from gallery:
  final ImagePicker multibleImages_picker = ImagePicker();

  Future getImages() async {
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
    final pickFile = await multibleImages_picker.pickMultiImage(
      imageQuality: 80,
      maxHeight: 1000.0,
      maxWidth: 1000.0,
    );

<<<<<<< HEAD
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
  Future<void> _handlePostButtonPressed() async {
    if (_isFormIncomplete()) {
      _showIncompleteDataDialog();
    } else {
      // ارفع الصور الأول
      selectedImagesUrl = await uploadImagesToSupabase(selectedImages);

      await addStadiumToFirestore(
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
          rating: 0,
          userID: FirebaseAuth.instance.currentUser?.uid ?? 'No User ID');

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
    required int rating,
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
      "userID": userID,
      "images": imagesUrl,
      "rating": 0
    };

    try {
      await FirebaseFirestore.instance.collection("stadiums").add(stadiumData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LanguageProvider>(context).isArabic
              ? 'تم إضافة الملعب بنجاح'
              : 'Stadium added successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LanguageProvider>(context).isArabic
              ? ':حدث خطأ $e'
              : 'Error: $e'),
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
          title: Text(Provider.of<LanguageProvider>(context).isArabic
              ? 'بيانات غير كاملة'
              : 'Incomplete Data'),
          content: Text(Provider.of<LanguageProvider>(context).isArabic
              ? 'الرجاء ملء جميع الحقول المطلوبة.'
              : 'Please fill all the required fields.'),
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

  Future<List<String>> uploadImagesToSupabase(List<File> images) async {
    final SupabaseClient supabase = Supabase.instance.client;
    List<String> urls = [];

    for (var image in images) {
      final String fileName =
          'stadiums/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
      // ignore: unused_local_variable
      final String fullPath = await supabase.storage.from('photo').upload(
            fileName,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      final String url = supabase.storage.from('photo').getPublicUrl(fileName);
      urls.add(url);
    }
    return urls;
  }
=======
    List<XFile> xfilePick = pickFile ?? [];
    if (xfilePick.isNotEmpty) {
      selectedImages.clear();

      for (var file in xfilePick) {
        selectedImages.add(File(file.path));
      }
      setState(() {});
    } 
  }

//water
  bool? isAvilable_Water;
  Color? waterAvilable = Color(0xff929292);
  Color? waterNotAvilable = Color(0xff929292);
//track
  bool? isAvilable_Track;
  Color? TrackAvilable = Color(0xff929292);
  Color? TrackNotAvilable = Color(0xff929292);
//grass
  bool? isAvilable_Grass;
  Color? GrassAvilable = Color(0xff929292);
  Color? GrassNotAvilable = Color(0xff929292);
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
<<<<<<< HEAD
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
                    title: Text(Provider.of<LanguageProvider>(context).isArabic
                        ? 'إلغاء البيانات؟'
                        : 'Discard data?'),
                    content: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'هل أنت متأكد أنك تريد إلغاء البيانات؟'
                            : 'Are you sure you want to discard?'),
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'اسم الملعب'
                      : 'Stadium Name',
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
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'بيانات الملعب'
                            : 'Stadium data',
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'إضافة صورة'
                                        : 'Add Image',
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
                              Provider.of<LanguageProvider>(context).isArabic
                                  ? '5MB حجم الملف الأقصى المقبول \nفي التوقيعات التالية:  .jpg   .jpeg,   .png '
                                  : '5MB maximum file size accepted \nin the following formats:  .jpg   .jpeg,   .png ',
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
                                    fit: BoxFit.contain,
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
                      pickerTitle: Text(
                          Provider.of<LanguageProvider>(context, listen: false)
                                  .isArabic
                              ? 'اختر المحافظة'
                              : 'Select Governorate',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 24.0)),
                      pickerDescription: Text(
                          Provider.of<LanguageProvider>(context, listen: false)
                                  .isArabic
                              ? 'اختر المحافظة حيث يوجد الملعب'
                              : 'Choose the governorate where the stadium is located',
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
                            pickerTitle: Text(
                                Provider.of<LanguageProvider>(context,
                                            listen: false)
                                        .isArabic
                                    ? 'اختر المكان'
                                    : 'Select Place',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24.0)),
                            pickerDescription: Text(
                                Provider.of<LanguageProvider>(context,
                                            listen: false)
                                        .isArabic
                                    ? 'اختر المكان حيث يوجد الملعب'
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
                                                          context,
                                                          listen: false)
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
                                                          context,
                                                          listen: false)
                                                      .isArabic
                                                  ? 'أدخل الحي'
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
                                                            context,
                                                            listen: false)
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
                  lableText:
                      Provider.of<LanguageProvider>(context, listen: false)
                              .isArabic
                          ? 'موقع الملعب'
                          : 'Stadium location',
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'السعر'
                      : 'Set Price',
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'الوصف'
                      : 'Description',
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
                  lableText: Provider.of<LanguageProvider>(context).isArabic
                      ? 'الكميه'
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
                    Expanded(child: Divider()), // Divider on the left side
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'المميزات'
                            : 'features',
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? ' متوفر ماء'
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
                                        ? 'غير متوفر ماء'
                                        : 'Water not available',
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'متوفر مسار'
                                        : 'Available Track',
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
                                        ? 'غير متوفر مسار'
                                        : 'Unavailable Track',
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
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'عشب صناعي'
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
                                        : 'Normal Grass',
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
                        Provider.of<LanguageProvider>(context,
                                    listen: false)
                                .isArabic
                            ? 'وقت العمل'
                            : 'time work',
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
                            pickerTitle: Text(Provider.of<LanguageProvider>(
                                        context, listen: false)
                                    .isArabic
                                ? 'متى تريد فتح الملعب في اليوم؟'
                                : 'when you will open stadium in each day ?'),
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
                              Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .isArabic
                                  ? 'بداية من'
                                  : 'start from',
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
                            pickerTitle: Text(Provider.of<LanguageProvider>(
                                        context, listen: false)
                                    .isArabic
                                ? 'متى تريد فتح الملعب في اليوم؟'
                                : 'when you will open stadium in each day ?'),
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
                              Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .isArabic
                                  ? 'ينتهي في'
                                  : 'End on',
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
                        Provider.of<LanguageProvider>(context).isArabic
                            ? ' أيام العمل'
                            : 'work days',
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
                        Provider.of<LanguageProvider>(context).isArabic
                            ? 'انشر ملعبك'
                            : 'Post your stadium',
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
                    onButtonPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await _handlePostButtonPressed();
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            Provider.of<LanguageProvider>(context, listen: false).isArabic
                                ? 'تم إضافة الملعب بنجاح'
                                : 'Stadium added successfully',
                          ),
                        ),
                      );
                      Navigator.pushNamed(context, '/home_owner');
                    },
                    content: isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            Provider.of<LanguageProvider>(context, listen: false).isArabic
                                ? 'انشر'
                                : 'Post',
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

    
      ]),
=======

        // leading: add_logo(10.0),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: 'eras-itc-bold'),
              children: [
                TextSpan(text: 'N', style: TextStyle(color: mainColor)),
                TextSpan(text: 'ew'),
                TextSpan(text: ' S', style: TextStyle(color: mainColor)),
                TextSpan(text: 'Tadium'),
              ]),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage_balls,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Images*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  //add image
                  Container(
                    height: 250.0,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0x8FF2F2F2),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: mainColor, width: 2.0)),
                    child: selectedImages.isEmpty
                        ? //ask to add image
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/stdowner_addNewStadium/imgs/threeCards.png'),
                              GestureDetector(
                                onTap: getImages,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 100.0, vertical: 12.0),
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      'Add Image',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: greenGradientColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              Text(
                                '5MB maximum file size accepted \nin the following formats:  .jpg   .jpeg,   .png ',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0),
                              )
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
                                    childAspectRatio: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Image.file(selectedImages[index]);
                            }),
                  ),

                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Stadium Name*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium name
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        textInputType: TextInputType.text,
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/sign.png'),
                      )),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Stadium Location*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium location
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        textInputType: TextInputType.text,
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/location.png'),
                      )),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Set Price*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium price
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Create_RequiredInput(
                      textInputType: TextInputType.number,
                      add_prefix: Image.asset(
                          'assets/stdowner_addNewStadium/imgs/price.png'),
                      add_suffix: Text('.LE',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 18.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),

                  //stadium description
                  Text(
                    'Description*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        textInputType: TextInputType.text,
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/desc.png'),
                      )),
                  SizedBox(
                    height: 84.0,
                  ),

                  //facilities
                  Container(
                    width: double.infinity,
                    // height: 200.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        //features title
                        Transform.translate(
                          offset: Offset(0.0, -40.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 80.0),
                            height: 40.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: greenGradientColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(color: Colors.white, width: 4.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //icon
                                  Image.asset(
                                      'assets/stdowner_addNewStadium/imgs/whiteFeatures.png',
                                      width: 20.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  //title
                                  Text(
                                    'Features',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'eras-itc-bold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Water',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              width: 200.0,
                              child: Row(
                                children: [
                                  //avilable
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: waterAvilable,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          isAvilable_Water = true;
                                          setState(() {
                                            waterAvilable = mainColor;
                                            waterNotAvilable =
                                                Color(0xff929292);
                                          });
                                        },
                                        child: Text(
                                          'Avilable',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      )),
                                  SizedBox(width: 6.0),
                                  // not avilable
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: waterNotAvilable,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          isAvilable_Water = false;
                                          setState(() {
                                            waterAvilable = Color(0xff929292);
                                            waterNotAvilable = mainColor;
                                          });
                                        },
                                        child: Text('Not Avilable',
                                            style: TextStyle(fontSize: 14.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //track
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Track',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              width: 200.0,
                              child: Row(
                                children: [
                                  //avilable
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: TrackAvilable,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          isAvilable_Track = true;
                                          setState(() {
                                            TrackAvilable = mainColor;
                                            TrackNotAvilable =
                                                Color(0xff929292);
                                          });
                                        },
                                        child: Text(
                                          'Avilable',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      )),
                                  SizedBox(width: 6.0),
                                  // not avilable
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: TrackNotAvilable,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          isAvilable_Track = false;
                                          setState(() {
                                            TrackAvilable = Color(0xff929292);
                                            TrackNotAvilable = mainColor;
                                          });
                                        },
                                        child: Text('Not Avilable',
                                            style: TextStyle(fontSize: 14.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //grass
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Grass',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              width: 200.0,
                              child: Row(
                                children: [
                                  //normal
                                  Expanded(
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: GrassAvilable,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft:
                                                  Radius.circular(10.0)),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            isAvilable_Grass = true;
                                            setState(() {
                                              GrassAvilable = mainColor;
                                              GrassNotAvilable =
                                                  Color(0xff929292);
                                            });
                                          },
                                          child: Text(
                                            'Normal',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.transparent),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                        )),
                                  ),
                                  SizedBox(width: 6.0),
                                  // industry
                                  Expanded(
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: GrassNotAvilable,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0)),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            isAvilable_Grass = false;
                                            setState(() {
                                              GrassAvilable = Color(0xff929292);
                                              GrassNotAvilable = mainColor;
                                            });
                                          },
                                          child: Text('Industry',
                                              style: TextStyle(fontSize: 14.0)),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.transparent),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        //Capacity
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Capacity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                                width: 200.0,
                                height: 30.0,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                  cursorColor: mainColor,
                                  decoration: InputDecoration(
                                    fillColor: Color(0x8FF2F2F2),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: mainColor, width: 2.0),
                                    ),
                                    hintText: 'Enter Capacity',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ),

                  SizedBox(
                    height: 40.0,
                  ),
                  //post, discard
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login_stadium');
                        },
                        child: Text(
                          'Discard',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 16.0)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.red, width: 2.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                        ),
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/stdown_editStadium');
                          },
                          title: 'Post',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
            ),
          ),
        ],
      ),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
    );
  }
}
