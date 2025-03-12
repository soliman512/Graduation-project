import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/stdown_addNewStd/testNewStadium.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class AddNewStadium extends StatefulWidget {
  const AddNewStadium({Key? key}) : super(key: key);

  @override
  State<AddNewStadium> createState() => _AddNewStadiumState();
}

class _AddNewStadiumState extends State<AddNewStadium> {
  final bool isDaysOpend = false;
  // Text controllers for inputs
  final TextEditingController stadiumNameController = TextEditingController();
  final TextEditingController stadiumPriceController = TextEditingController();
  final TextEditingController stadiumDescriptionController =
      TextEditingController();
  final TextEditingController stadiumCapacityController =
      TextEditingController();
  final TextEditingController stadiumLocationController =
      TextEditingController();

  @override
  void dispose() {
    stadiumNameController.dispose();
    stadiumPriceController.dispose();
    stadiumDescriptionController.dispose();
    stadiumCapacityController.dispose();
    stadiumLocationController.dispose();
    super.dispose();
  }

  //time work
  List<Map> selectDays = [
    {'day': 'Saturday', 'isSelected': false},
    {'day': 'Sunday', 'isSelected': false},
    {'day': 'Monday', 'isSelected': false},
    {'day': 'Tuesday', 'isSelected': false},
    {'day': 'Wednesday', 'isSelected': false},
    {'day': 'Thursday', 'isSelected': false},
    {'day': 'Friday', 'isSelected': false},
  ];

  List<String> daysSelected = [];

  String? timeStart;
  String? timeEnd;

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
  }

  //select multible images:
  List<File> selectedImages = [];
  //pick image from gallery:
  final ImagePicker multibleImages_picker = ImagePicker();

  Future getImages() async {
    final pickFile = await multibleImages_picker.pickMultiImage(
      imageQuality: 80,
      maxHeight: 1000.0,
      maxWidth: 1000.0,
    );

    List<XFile> xfilePick = pickFile;
    if (xfilePick.isNotEmpty) {
      selectedImages.clear();

      for (var file in xfilePick) {
        selectedImages.add(File(file.path));
      }
      setState(() {});
    }
  }

  //water
  bool isWaterAvailable = true;
  //track
  bool isTrackAvailable = false;
  //grass
  bool isGrassNormal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40.0,
        centerTitle: true,

        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontFamily: 'eras-itc-bold',
            ),
            children: [
              TextSpan(text: 'N', style: TextStyle(color: mainColor)),
              TextSpan(text: 'ew'),
              TextSpan(text: ' S', style: TextStyle(color: mainColor)),
              TextSpan(text: 'Tadium'),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(child: backgroundImage_balls, opacity: 0.2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),
                  Center(
                    child: Text(
                      'Images',
                      style: TextStyle(
                        color: const Color.fromARGB(76, 0, 0, 0),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.0),
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
                    child:
                        selectedImages.isEmpty
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
                                        'Add Image',
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
                                  '5MB maximum file size accepted \nin the following formats:  .jpg   .jpeg,   .png ',
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
                                        borderRadius: BorderRadius.circular(10.0),
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

                  //stadium name
                  Create_RequiredInput(
                    onChange: (value) {
                      stadiumNameController.text = value;
                    },
                    initValue: stadiumNameController.text,
                    lableText: 'Stadium Name',
                    textInputType: TextInputType.text,
                    add_prefix: Image.asset(
                      'assets/stdowner_addNewStadium/imgs/sign.png',
                    ),
                  ),
                  SizedBox(height: 32.0),

                  //stadium location
                  Create_RequiredInput(
                    // initValue: stadiumLocationController.text,
                    onChange: (value) {
                      Location = value;
                    },
                    onTap: () {
                      setState(() {
                        visibleOfLocation = true;
                      });
                    },
                    lableText: 'Stadium Location',
                    initValue: Location,
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
                    lableText: 'Set Price',
                    textInputType: TextInputType.number,
                    add_prefix: Image.asset(
                      'assets/stdowner_addNewStadium/imgs/price.png',
                    ),
                    add_suffix: Text(
                      '.LE',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 18.0,
                        fontFamily: 'eras-itc-bold',
                        fontWeight: FontWeight.w800,
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
                    lableText: 'Description',
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
                    lableText: 'Capacity',
                    textInputType: TextInputType.number,
                    add_prefix: Icon(
                      Icons.group,
                      color: const Color.fromARGB(255, 0, 156, 39),
                    ),
                  ),
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Divider(color: Colors.black, thickness: 1.0),
                      ),
                      SizedBox(width: 2.0),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Features',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: 'eras-itc-demi',
                          ),
                        ),
                      ),
                      SizedBox(width: 2.0),
                      Expanded(
                        flex: 3,
                        child: Divider(color: Colors.black, thickness: 1.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  Wrap(
                    spacing: 4.0,
                    runSpacing: 8.0,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //water
                      Center(
                        child: Container(
                          width: 240.0,
                          child: AnimatedToggleSwitch<bool>.dual(
                            current: isWaterAvailable,
                            first: false,
                            second: true,
                            spacing: 45.0,
                            animationDuration: Duration(milliseconds: 500),
                            style: const ToggleStyle(
                              borderColor: Colors.transparent,
                              indicatorColor: Colors.white,
                              backgroundColor: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0,
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
                            loadingIconBuilder:
                                (context, global) => CupertinoActivityIndicator(
                                  color: Color.lerp(
                                    Colors.grey,
                                    mainColor,
                                    global.position,
                                  ),
                                ),
                            onChanged:
                                (value) =>
                                    setState(() => isWaterAvailable = value),

                            iconBuilder:
                                (value) =>
                                    value
                                        ? Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/avi_water.png',
                                        )
                                        : Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/no_avi_water.png',
                                        ),
                            textBuilder:
                                (value) =>
                                    value
                                        ? Center(
                                          child: Text(
                                            'Water is Available',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'eras-itc-bold',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                        : Center(
                                          child: Text(
                                            'Water not available',
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
                          width: 240.0,
                          child: AnimatedToggleSwitch<bool>.dual(
                            current: isTrackAvailable,
                            first: false,
                            second: true,
                            spacing: 45.0,
                            animationDuration: Duration(milliseconds: 500),
                            style: const ToggleStyle(
                              borderColor: Colors.transparent,
                              indicatorColor: Colors.white,
                              backgroundColor: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0,
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
                            loadingIconBuilder:
                                (context, global) => CupertinoActivityIndicator(
                                  color: Color.lerp(
                                    Colors.grey,
                                    mainColor,
                                    global.position,
                                  ),
                                ),
                            onChanged:
                                (value) =>
                                    setState(() => isTrackAvailable = value),

                            iconBuilder:
                                (value) =>
                                    value
                                        ? Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/avi_track1.png',
                                        )
                                        : Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/notAvi_track.png',
                                        ),
                            textBuilder:
                                (value) =>
                                    value
                                        ? Center(
                                          child: Text(
                                            'Available Track',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'eras-itc-bold',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                        : Center(
                                          child: Text(
                                            'Unavailable Track',
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
                          width: 240.0,
                          child: AnimatedToggleSwitch<bool>.dual(
                            current: isGrassNormal,
                            first: false,
                            second: true,
                            spacing: 45.0,
                            animationDuration: Duration(milliseconds: 300),
                            style: const ToggleStyle(
                              borderColor: Colors.transparent,
                              indicatorColor: Colors.white,
                              backgroundColor: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1.0,
                                  blurRadius: 2.0,
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
                            loadingIconBuilder:
                                (context, global) => CupertinoActivityIndicator(
                                  color: Color.lerp(
                                    const Color.fromARGB(255, 158, 158, 158),
                                    mainColor,
                                    global.position,
                                  ),
                                ),
                            onChanged:
                                (value) =>
                                    setState(() => isGrassNormal = value),

                            iconBuilder:
                                (value) =>
                                    value
                                        ? Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/normal_grass.png',
                                          width: 40.0,
                                        )
                                        : Image.asset(
                                          'assets/stdowner_addNewStadium/imgs/industry_grass.png',
                                          width: 40.0,
                                        ),
                            textBuilder:
                                (value) =>
                                    value
                                        ? Center(
                                          child: Text(
                                            'Industry Grass',
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
                                            'Normal Grass',
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

                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Divider(color: Colors.black, thickness: 1.0),
                      ),
                      SizedBox(width: 2.0),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Work Schduale',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: 'eras-itc-demi',
                          ),
                        ),
                      ),
                      SizedBox(width: 2.0),
                      Expanded(
                        flex: 1,
                        child: Divider(color: Colors.black, thickness: 1.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  //selct time:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context).push(
                              showPicker(
                                context: context,
                                value: Time(hour: 7, minute: 00),
                                sunrise: TimeOfDay(
                                  hour: 6,
                                  minute: 0,
                                ), // optional
                                sunset: TimeOfDay(
                                  hour: 18,
                                  minute: 0,
                                ), // optional
                                duskSpanInMinutes: 120, // optional
                                onChange: (value) {
                                  setState(() {
                                    timeStart =
                                        '${value.hourOfPeriod.toString().padLeft(2, '0')} : ${value.minute.toString().padLeft(2, '0')} ${value.period == DayPeriod.am ? 'AM' : 'PM'}';
                                  });
                                },
                              ),
                            );
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
                            labelText: 'start from',
                            labelStyle: TextStyle(fontSize: 16.0),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelStyle: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18.0,
                            ),
                            fillColor: Colors.white60,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(186, 0, 0, 0),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Center(
                        child: Text(
                          'TO',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 18.0,
                            fontFamily: 'eras-itc-demi',
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.none,
                          controller: TextEditingController(text: timeEnd),
                          onTap: () {
                            Navigator.of(context).push(
                              showPicker(
                                context: context,
                                value: Time(hour: 23, minute: 00),
                                sunrise: TimeOfDay(
                                  hour: 6,
                                  minute: 0,
                                ), // optional
                                sunset: TimeOfDay(
                                  hour: 18,
                                  minute: 0,
                                ), // optional
                                duskSpanInMinutes: 120, // optional
                                onChange: (value) {
                                  setState(() {
                                    timeEnd =
                                        '${value.hourOfPeriod.toString().padLeft(2, '0')} : ${value.minute.toString().padLeft(2, '0')} ${value.period == DayPeriod.am ? 'AM' : 'PM'}';
                                  });
                                },
                              ),
                            );
                          },
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 18.0,
                            fontFamily: 'eras-itc-demi',
                          ),
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'End on',
                            labelStyle: TextStyle(fontSize: 16.0),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelStyle: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18.0,
                            ),
                            fillColor: Colors.white60,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(186, 0, 0, 0),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  //work time
                  Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 8.0,
                      ),
                      itemCount: selectDays.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectDays[i]['isSelected'] =
                                  !selectDays[i]['isSelected'];
                              if (selectDays[i]['isSelected'] == true) {
                                daysSelected.add(selectDays[i]['day']);
                              } else {
                                daysSelected.remove(selectDays[i]['day']);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  selectDays[i]['isSelected']
                                      ? const Color.fromARGB(94, 123, 209, 126)
                                      : Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(
                                color: mainColor,
                                width: selectDays[i]['isSelected'] ? 4.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 6.0),
                                Text(
                                  selectDays[i]['day'],
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      105,
                                      26,
                                    ),
                                    fontSize: 14.0,
                                    fontFamily: 'eras-itc-demi',
                                  ),
                                ),
                                Visibility(
                                  visible: selectDays[i]['isSelected'],
                                  child: Row(
                                    children: [
                                      SizedBox(width: 4.0),
                                      Image.asset(
                                        'assets/stdowner_addNewStadium/imgs/Maskgroup.png',
                                      ),
                                      SizedBox(width: 20.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.0),
                  //post, discard
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login_stadium');
                          },
                          child: Text(
                            'discard',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 8.0),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: WidgetStateProperty.all<Color>(
                              Colors.red,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red, width: 2.0),
                              ),
                            ),
                            elevation: WidgetStateProperty.all<double>(0.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 2,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) => EditStadium(
                                      title: stadiumNameController.text,
                                      price: stadiumPriceController.text,
                                      description:
                                          stadiumDescriptionController.text,
                                      capacity: stadiumCapacityController.text,

                                      location: Location ?? 'not set',
                                      timeStart: timeStart.toString(),
                                      timeEnd: timeEnd.toString(),
                                      days: daysSelected,
                                      isWaterAvailable: isWaterAvailable,
                                      isTrackAvailable: isTrackAvailable,
                                      isGrassNormal: isGrassNormal,
                                      selectedImages:
                                          selectedImages
                                              .map((file) => XFile(file.path))
                                              .toList(),
                                    ),
                              ),
                            );
                          },
                          title: 'Post',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
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
                      horizontal: 16.0,
                      vertical: 150.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 100.0),
                      ],
                      color: Colors.white,
                      // color: Colors.red
                    ),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          //close location
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  visibleOfLocation = false;
                                });
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                          ),
                          //inputs
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    borderRadius: BorderRadius.circular(10.0),
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
                                            egyptGovernoratesAndCenters[cityValue];
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
                                        Icons.arrow_drop_down_circle_outlined,
                                        size: 30.0,
                                        color: mainColor,
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),
                                      alignment: Alignment.center,
                                      underline: null,
                                      borderRadius: BorderRadius.circular(20.0),
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
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          items:
                                              placesOfCityOnSelected?.map((
                                                String place,
                                              ) {
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
                                ),
                              ),

                              // //neighborhood
                              Visibility(
                                visible: visibleOfNeighborhood,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
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
                                        borderRadius: BorderRadius.circular(
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
                                        textInputAction: TextInputAction.done,
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
                                child: Create_GradiantGreenButton(
                                  title: 'Done',
                                  onButtonPressed: () {
                                    setState(() {
                                      visibleOfLocation = false;
                                      initValueOfLocation();
                                    });
                                  },
                                ),
                              ),
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
      ),
    );
  }
}
