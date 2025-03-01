import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';

class AddNewStadium extends StatefulWidget {
  const AddNewStadium({Key? key}) : super(key: key);

  @override
  State<AddNewStadium> createState() => _AddNewStadiumState();
}

class _AddNewStadiumState extends State<AddNewStadium> {
  
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
  double moveToRight_Water = 0;
  double waterSelector = 130.0;
  //track
  bool isTrackAvailable = true;
  double moveToRight_Track = 0;
  double trackSelector = 130.0;
  //grass
  bool isGrassAvailable = true;
  double moveToRight_Grass = 0;
  double grassSelector = 130.0;
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
          backgroundImage_balls,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Images*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  //add image
                  Container(
                    height: 250.0,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x8FF2F2F2),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: mainColor, width: 2.0),
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
                                return Image.file(selectedImages[index]);
                              },
                            ),
                  ),

                  SizedBox(height: 32.0),
                  Text(
                    'Stadium Name*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  //stadium name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Create_RequiredInput(
                      textInputType: TextInputType.text,
                      add_prefix: Image.asset(
                        'assets/stdowner_addNewStadium/imgs/sign.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Stadium Location*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  //stadium location
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Create_RequiredInput(
                      onTap: () {
                        setState(() {
                          visibleOfLocation = true;
                        });
                      },
                      initValue: Location,
                      isReadOnly: true,
                      textInputType: TextInputType.text,
                      add_prefix: Image.asset(
                        'assets/stdowner_addNewStadium/imgs/location.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Set Price*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  //stadium price
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Create_RequiredInput(
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
                  ),
                  SizedBox(height: 32.0),

                  //stadium description
                  Text(
                    'Description*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Create_RequiredInput(
                      textInputType: TextInputType.text,
                      add_prefix: Image.asset(
                        'assets/stdowner_addNewStadium/imgs/desc.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  //water
                  Center(
                    child: Text(
                      'Water',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'eras-itc-bold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Container(
                      width: 260,
                      height: 40.0,
                      // margin: EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut, // make it smoothly
                            left: isWaterAvailable ? 0 : 120,
                            child: Container(
                              width: waterSelector,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: greenGradientColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isWaterAvailable = true;
                                      waterSelector = 130.0;
                                    });
                                  },
                                  child: Text(
                                    'Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isWaterAvailable = false;
                                      waterSelector = 140.0;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Not Available',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // track
                  Center(
                    child: Text(
                      'Track',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'eras-itc-bold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Container(
                      width: 260,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut, // make it smoothly
                            left: isTrackAvailable ? 0 : 120,
                            child: Container(
                              width: trackSelector,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: greenGradientColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isTrackAvailable = true;
                                      trackSelector = 130.0;
                                    });
                                  },
                                  child: Text(
                                    'Available',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isTrackAvailable = false;
                                      trackSelector = 140.0;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Not Available',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //grass
                  Center(
                    child: Text(
                      'Grass',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'eras-itc-bold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Container(
                      width: 260,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut, // make it smoothly
                            left: isGrassAvailable ? 0 : 120,
                            child: Container(
                              width: grassSelector,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: greenGradientColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isGrassAvailable = true;
                                      grassSelector = 130.0;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 24.0),
                                    child: Text(
                                      'Normal',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isGrassAvailable = false;
                                      grassSelector = 140.0;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Industry',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  //Capacity
                  Center(
                    child: Text(
                      'Capacity',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                        cursorColor: mainColor,
                        decoration: InputDecoration(
                          fillColor: Color(0xC4FFFFFF),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: mainColor,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'Enter Capacity',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.0),
                  // select time:
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                        horizontal: BorderSide(color: mainColor, width: 2.0),
                      ),
                    ),
                    child: Text(
                      'Work Time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'eras-itc-bold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 4,
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
                              color: Color(0xC7FFFFFF),
                              border: Border.all(color: mainColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  selectDays[i]['day'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Visibility(
                                  visible: selectDays[i]['isSelected'],
                                  child: Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: mainColor,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () {
                            // use time picker
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: mainColor,
                            ),
                            labelText: 'start on',
                            labelStyle: TextStyle(fontSize: 20.0),
                            floatingLabelStyle: TextStyle(
                              color: mainColor,
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            // use time picker
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.access_time_filled_sharp,
                              color: mainColor,
                            ),
                            labelText: 'End on',
                            labelStyle: TextStyle(fontSize: 20.0),
                            floatingLabelStyle: TextStyle(
                              color: mainColor,
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ButtonStyle(
                            // padding: MaterialStateProperty.all<EdgeInsets>(
                            //     EdgeInsets.symmetric(vertical: 16.0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.red,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red, width: 2.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 2,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/stdown_editStadium');
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
