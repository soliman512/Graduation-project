import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // inputs controller
  String matchDate = '';
  String matchTime = '';
  String matchDuration = '';

  void showDurationPicker(BuildContext context) {
    int hours = 0;
    int minutes = 0;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Use StatefulBuilder to keep state inside the BottomSheet
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Text(
                    "Choose Match Duration",
                    style: TextStyle(
                      fontFamily: 'eras-itc-demi',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hours Picker
                      Column(
                        children: [
                          Text(
                            "Hours",
                            style: TextStyle(
                              color: const Color.fromARGB(92, 158, 158, 158),
                            ),
                          ),
                          NumberPicker(
                            value: hours,
                            minValue: 0,
                            maxValue: 5,
                            onChanged: (value) => setStateModal(
                                () => hours = value), // Update picker state
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      // Minutes Picker
                      Column(
                        children: [
                          Text(
                            "Minutes",
                            style: TextStyle(
                              color: const Color.fromARGB(92, 158, 158, 158),
                            ),
                          ),
                          NumberPicker(
                            value: minutes,
                            minValue: 0,
                            maxValue: 59,
                            step: 30,
                            onChanged: (value) => setStateModal(
                                () => minutes = value), // ✅ Update picker state
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Create_GradiantGreenButton(
                      content: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'eras-itc-demi',
                          fontSize: 18.0,
                        ),
                      ),
                      onButtonPressed: () {
                        // Close the bottom sheet
                        Navigator.pop(context);

                        // Create duration and update main state
                        Duration selectedDuration =
                            Duration(hours: hours, minutes: minutes);

                        // You must call setState in your main StatefulWidget
                        // Replace `setState` with a callback if needed
                        this.setState(() {
                          matchDuration =
                              "${selectedDuration.inHours}h  -  ${selectedDuration.inMinutes.remainder(60)}m";
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 28,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Discard Payment"),
                    content:
                        Text("Are you sure you want to discard the payment?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text("Return"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text("Discard",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/payment/imgs/tickets.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.8),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.width * 0.06,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/payment/imgs/icons8-stadium-100_1_(1).png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "wembley",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                    Text(
                      "200.LE",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: mainColor,
                      size: MediaQuery.of(context).size.width * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Assiut-new assiut city-suzan",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: mainColor,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "3.8",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontFamily: "eras-itc-demi"),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "(218)",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 124, 124, 124),
                            fontSize: MediaQuery.of(context).size.width * 0.027,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'booking details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40.0),

                // Container(
                //   padding:
                //       EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                //   decoration: BoxDecoration(
                //     color: Colors.transparent,
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       color: const Color.fromARGB(80, 0, 185, 46),
                //       width: MediaQuery.of(context).size.width * 0.0017,
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Column(
                //         children: [
                //           Text(
                //             "Day",
                //             style: TextStyle(
                //               color: mainColor,
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.04,
                //               fontFamily: "eras-itc-demi",
                //             ),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.02,
                //           ),
                //           Text(
                //             "Friday",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //           Text(
                //             "6/5/2025",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           Text(
                //             "Time",
                //             style: TextStyle(
                //                 color: mainColor,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.04,
                //                 fontFamily: "eras-itc-demi"),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.04,
                //           ),
                //           Text(
                //             "2:30",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           Text(
                //             "Duration",
                //             style: TextStyle(
                //                 color: mainColor,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.04,
                //                 fontFamily: "eras-itc-demi"),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.02,
                //           ),
                //           Text(
                //             "1:30",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //           Text(
                //             "hour",
                //             style: TextStyle(
                //                 color: const Color.fromARGB(255, 0, 0, 0),
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.03,
                //                 fontFamily: "light"),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // date, time, duration
                // payment way: fawary, credit card, cashr
                Create_RequiredInput(
                  isReadOnly: true,
                  initValue: matchDate,
                  add_prefix:
                      Icon(Icons.calendar_today, color: mainColor, size: 12.0),
                  textInputType: TextInputType.text,
                  lableText: "match date",
                  onTap: () {
                    BottomPicker.date(
                        pickerTitle: Text(
                          "Select Date within the next 30 days",
                          style: TextStyle(
                              fontFamily: 'eras-itc-demi', fontSize: 14.0),
                        ),
                        titlePadding: EdgeInsets.only(
                          top: 4.0,
                          left: 4.0,
                        ),
                        minDateTime: DateTime.now(),
                        maxDateTime: DateTime.now().add(Duration(days: 30)),
                        onSubmit: (selectedDate) {
                          setState(() {
                            matchDate =
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                          });
                        },
                        buttonStyle: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(10),
                        )).show(context);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Create_RequiredInput(
                        isReadOnly: true,
                        initValue: matchTime,
                        add_prefix: Icon(Icons.calendar_today,
                            color: mainColor, size: 12.0),
                        textInputType: TextInputType.text,
                        lableText: "time",
                        onTap: () {
                          BottomPicker.time(
                            pickerTitle: Text(
                              "Select Time",
                              style: TextStyle(
                                  fontFamily: 'eras-itc-demi', fontSize: 14.0),
                            ),
                            titlePadding: EdgeInsets.only(
                              top: 4.0,
                              left: 4.0,
                            ),
                            onSubmit: (selectedTime) {
                              setState(() {
                                matchTime = "${selectedTime.hourOfPeriod}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
                                    "${selectedTime.hour}:${selectedTime.minute}";
                              });
                            },
                            buttonStyle: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            initialTime: null,
                          ).show(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Create_RequiredInput(
                        isReadOnly: true,
                        initValue: matchDuration,
                        add_prefix: Icon(Icons.calendar_today,
                            color: mainColor, size: 12.0),
                        textInputType: TextInputType.text,
                        lableText: "duration",
                        onTap: () => showDurationPicker(context),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
