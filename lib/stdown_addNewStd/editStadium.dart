import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_lastversion/stadiums/stadiums.dart';

// ignore: must_be_immutable
class EditStadium extends StatefulWidget {
  final AddStadium stadium;
  EditStadium({required this.stadium});
  @override
  State<EditStadium> createState() => _EditStadiumState();
}

class _EditStadiumState extends State<EditStadium> {
  double heightOfDays = 0.0;
  double rotationOfDaysArrow = 0.0;

  List<String> daysSelected = [];
  @override
  Widget build(BuildContext context) {
    bool isDaysOpend = false;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
              TextSpan(text: 'E', style: TextStyle(color: mainColor)),
              TextSpan(text: 'dit'),
              TextSpan(text: ' S', style: TextStyle(color: mainColor)),
              TextSpan(text: 'Tadium'),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stdWon_addNewStadium');
          },
          icon: Image.asset('assets/welcome_signup_login/imgs/back.png'),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/no_internetConnection');
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 25.0, 10.0, 25.0),
              padding: EdgeInsets.only(top: 6.0),
              height: 30.0,
              width: 60.0,
              decoration: BoxDecoration(
                gradient: greenGradientColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    Image.asset('assets/editstadium_stdown/imgs/bi_save.png'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Center(
                child: Text(
                  'Edit Images',
                  style: TextStyle(
                    color: const Color.fromARGB(76, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8.0),

              //images
              Container(
                width: double.infinity,
                height: 250.0,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: mainColor, width: 1.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.stadium.selectedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(widget.stadium.selectedImages[index].path),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Create_RequiredInput(
                initValue: widget.stadium.title,
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
                lableText: 'Stadium Location',
                initValue: widget.stadium.location,
                isReadOnly: true,
                textInputType: TextInputType.text,
                add_prefix: Image.asset(
                  'assets/stdowner_addNewStadium/imgs/location.png',
                ),
              ),
              SizedBox(height: 32.0),
              //stadium price
              Create_RequiredInput(
                initValue: widget.stadium.price,
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
                initValue: widget.stadium.description,
                lableText: 'Description',
                textInputType: TextInputType.text,
                add_prefix: Image.asset(
                  'assets/stdowner_addNewStadium/imgs/desc.png',
                ),
              ),

              SizedBox(height: 32.0),
              //capacity
              Create_RequiredInput(
                initValue: widget.stadium.capacity,
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
                    flex: 2,
                    child: Divider(color: Colors.black, thickness: 1.0),
                  ),
                  SizedBox(width: 2.0),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Edit Features',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: 'eras-itc-demi',
                      ),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Expanded(
                    flex: 2,
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
                        current: widget.stadium.isWaterAvailable,
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
                            return ToggleStyle(backgroundColor: Colors.white);
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
                            (value) => setState(
                              () => widget.stadium.isWaterAvailable = value,
                            ),

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
                        current: widget.stadium.isTrackAvailable,
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
                            (value) => setState(
                              () => widget.stadium.isTrackAvailable = value,
                            ),

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
                        current: widget.stadium.isGrassNormal,
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
                            return ToggleStyle(backgroundColor: Colors.white);
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
                            (value) => setState(
                              () => widget.stadium.isGrassNormal = value,
                            ),

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
                      'Edit Work Schduale',
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
                            sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                            sunset: TimeOfDay(hour: 18, minute: 0), // optional
                            duskSpanInMinutes: 120, // optional
                            onChange: (value) {
                              setState(() {
                                widget.stadium.timeStart =
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
                      controller: TextEditingController(
                        text: widget.stadium.timeStart,
                      ),
                      readOnly: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'start from',
                        labelStyle: TextStyle(fontSize: 16.0),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
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
                          borderSide: BorderSide(color: mainColor, width: 2.0),
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
                      controller: TextEditingController(
                        text: widget.stadium.timeEnd,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: Time(hour: 23, minute: 00),
                            sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                            sunset: TimeOfDay(hour: 18, minute: 0), // optional
                            duskSpanInMinutes: 120, // optional
                            onChange: (value) {
                              setState(() {
                                widget.stadium.timeEnd =
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
                        floatingLabelAlignment: FloatingLabelAlignment.center,
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
                          borderSide: BorderSide(color: mainColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              //work time
              // Center(
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 1,
              //       crossAxisSpacing: 10.0,
              //       mainAxisSpacing: 10.0,
              //       childAspectRatio: 8.0,
              //     ),
              //     itemCount: selectDays.length,
              //     itemBuilder: (BuildContext context, int i) {
              //       return GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectDays[i]['isSelected'] =
              //                 !selectDays[i]['isSelected'];
              //             if (selectDays[i]['isSelected'] == true) {
              //               daysSelected.add(selectDays[i]['day']);
              //             } else {
              //               daysSelected.remove(selectDays[i]['day']);
              //             }
              //           });
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color:
              //                 selectDays[i]['isSelected']
              //                     ? const Color.fromARGB(94, 123, 209, 126)
              //                     : Color.fromARGB(255, 255, 255, 255),
              //             border: Border.all(
              //               color: mainColor,
              //               width: selectDays[i]['isSelected'] ? 4.0 : 1.0,
              //             ),
              //             borderRadius: BorderRadius.circular(5.0),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(width: 6.0),
              //               Text(
              //                 selectDays[i]['day'],
              //                 style: TextStyle(
              //                   color: const Color.fromARGB(
              //                     255,
              //                     0,
              //                     105,
              //                     26,
              //                   ),
              //                   fontSize: 14.0,
              //                   fontFamily: 'eras-itc-demi',
              //                 ),
              //               ),
              //               Visibility(
              //                 visible: days[i]['isSelected'],
              //                 child: Row(
              //                   children: [
              //                     SizedBox(width: 4.0),
              //                     Image.asset(
              //                       'assets/stdowner_addNewStadium/imgs/Maskgroup.png',
              //                     ),
              //                     SizedBox(width: 20.0),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(height: 40.0),

              //days
              Column(
                children: [
                  //button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        heightOfDays = heightOfDays == 0.0 ? 500.0 : 0.0;
                        rotationOfDaysArrow =
                            rotationOfDaysArrow == 0.0 ? 0.5 : 0.0;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: greenGradientColor,
                        // color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: mainColor, width: 1.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'change work days',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'eras-itc-demi',
                            ),
                          ),

                          AnimatedRotation(
                            duration: Duration(milliseconds: 300),
                            turns: rotationOfDaysArrow,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // days
                  // AnimatedContainer(
                  //   duration: Duration(milliseconds: 300),

                  //   width: double.infinity,
                  //   height: heightOfDays,
                  //   padding: EdgeInsets.all(8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.8),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     border: Border.all(color: mainColor, width: 1.0),
                  //   ),
                  //   child: Center(
                  //     child: GridView.builder(
                  //       shrinkWrap: true,
                  //       physics: NeverScrollableScrollPhysics(),
                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 1,
                  //         crossAxisSpacing: 10.0,
                  //         mainAxisSpacing: 10.0,
                  //         childAspectRatio: 8.0,
                  //       ),
                  //       itemCount: selectDays.length,
                  //       itemBuilder: (BuildContext context, int i) {
                  //         return GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               selectDays[i]['isSelected'] =
                  //                   !selectDays[i]['isSelected'];
                  //               if (selectDays[i]['isSelected'] == true) {
                  //                 daysSelected.add(selectDays[i]['day']);
                  //               } else {
                  //                 daysSelected.remove(selectDays[i]['day']);
                  //               }
                  //             });
                  //           },
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               color:
                  //                   selectDays[i]['isSelected']
                  //                       ? const Color.fromARGB(
                  //                         94,
                  //                         123,
                  //                         209,
                  //                         126,
                  //                       )
                  //                       : Color.fromARGB(255, 255, 255, 255),
                  //               border: Border.all(
                  //                 color: mainColor,
                  //                 width:
                  //                     selectDays[i]['isSelected'] ? 4.0 : 1.0,
                  //               ),
                  //               borderRadius: BorderRadius.circular(5.0),
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 SizedBox(width: 6.0),
                  //                 Text(
                  //                   selectDays[i]['day'],
                  //                   style: TextStyle(
                  //                     color: const Color.fromARGB(
                  //                       255,
                  //                       0,
                  //                       105,
                  //                       26,
                  //                     ),
                  //                     fontSize: 14.0,
                  //                     fontFamily: 'eras-itc-demi',
                  //                   ),
                  //                 ),
                  //                 Visibility(
                  //                   visible: selectDays[i]['isSelected'],
                  //                   child: Row(
                  //                     children: [
                  //                       SizedBox(width: 4.0),
                  //                       Image.asset(
                  //                         'assets/stdowner_addNewStadium/imgs/Maskgroup.png',
                  //                       ),
                  //                       SizedBox(width: 20.0),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
