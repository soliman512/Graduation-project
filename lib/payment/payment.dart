import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';

import 'package:numberpicker/numberpicker.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
  final String stadiumName;
  final String stadiumPrice;
  final String stadiumLocation;
  final String stadiumID;

  Payment({
    required this.stadiumID,
    required this.stadiumName,
    required this.stadiumPrice,
    required this.stadiumLocation,
  });
}

class _PaymentState extends State<Payment> with TickerProviderStateMixin {
  double testCost = 200.0;
  // inputs controller
  String matchDate = '';
  String matchTime = '';
  String matchDuration = '';
  double calcCost = 0.0;
  double matchCost = 0.0;
  String paymentWay = '';
  bool creditCard = false;
  bool fawry = false;
  bool cash = false;

  void showDurationPicker(BuildContext context) {
    int hours = 1;
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
                            minValue: 1,
                            maxValue: 6,
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
                        calcCost = testCost * (hours + minutes / 60);
                        matchCost = calcCost;
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
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
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
                    title: Text(isArabic ? "إلغاء الدفع" : "Discard Payment"),
                    content:
                        Text(isArabic ? "هل أنت متأكد من إلغاء الدفع؟" : "Are you sure you want to discard the payment?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(isArabic ? "عودة" : "Return"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text(isArabic ? "إلغاء" : "Discard",
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
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(
                      color: mainColor.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width * 0.0017,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // date
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchDate.isNotEmpty
                                        ? matchDate
                                        : "Select date",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: matchDate.isNotEmpty
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // time from : to
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchTime.isNotEmpty &&
                                            matchDuration.isNotEmpty
                                        ? "$matchTime - ${matchDuration.replaceAll(' - ', '')}"
                                        : "time & duration",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: (matchTime.isNotEmpty &&
                                              matchDuration.isNotEmpty)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // cost
                              Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchCost > 0
                                        ? "$matchCost LE"
                                        : "Select cost",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: (matchCost.toString().isNotEmpty &&
                                              matchCost > 0)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Expanded(
                        child: Image.asset('assets/payment/imgs/tickets.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.3),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.09,
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
                      Icon(Icons.calendar_today, color: mainColor, size: 18.0),
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
                        maxDateTime:
                            DateTime.now().add(const Duration(days: 30)),
                        initialDateTime:
                            DateTime.now().add(const Duration(days: 1)),
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
                        add_prefix: Icon(Icons.access_time,
                            color: mainColor, size: 18.0),
                        textInputType: TextInputType.text,
                        lableText: "time",
                        onTap: () {
                          BottomPicker.time(
                            pickerTitle: Text(
                              "Select Time",
                              style: TextStyle(
                                  fontFamily: 'eras-itc-demi',
                                  fontSize: 18.0), // Set font size to 18
                            ),
                            titlePadding: EdgeInsets.only(
                              top: 4.0,
                              left: 4.0,
                            ),
                            minuteInterval: 30, // Set minute step to 30
                            onSubmit: (selectedTime) {
                              // Format the selected time
                              selectedTime = TimeOfDay(
                                hour: selectedTime.hour,
                                minute: selectedTime.minute,
                              );
                              setState(() {
                                final hour = selectedTime.hour % 12 == 0
                                    ? 12
                                    : selectedTime.hour % 12;
                                final minute = selectedTime.minute
                                    .toString()
                                    .padLeft(2, '0');
                                final period =
                                    selectedTime.hour >= 12 ? 'PM' : 'AM';
                                matchTime =
                                    "${hour.toString().padLeft(2, '0')}:$minute $period";

                                matchTime = "$hour:$minute $period";
                              });
                            },
                            buttonStyle: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            initialTime: Time(
                              hours: TimeOfDay.now().hour,
                              minutes: TimeOfDay.now().minute >= 30 ? 30 : 0,
                            ),
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
                        add_prefix:
                            Icon(Icons.timelapse, color: mainColor, size: 18.0),
                        textInputType: TextInputType.text,
                        lableText: "duration",
                        onTap: () => showDurationPicker(context),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'payment method',
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: mainColor.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: creditCard ? 3 : 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                creditCard = true;
                                fawry = false;
                                cash = false;
                                paymentWay = "Credit Card";
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                              decoration: BoxDecoration(
                                gradient:
                                    creditCard ? greenGradientColor : null,
                                color: creditCard ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.credit_card,
                                      color: creditCard
                                          ? Colors.white
                                          : mainColor),
                                  SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(
                                            opacity: animation, child: child),
                                    child: creditCard
                                        ? Text(
                                            "Credit Card",
                                            key: ValueKey('creditCard'),
                                            style: TextStyle(
                                              fontFamily: 'eras-itc-demi',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : SizedBox(width: 0, height: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          flex: fawry ? 3 : 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                creditCard = false;
                                fawry = true;
                                cash = false;
                                paymentWay = "Fawry";
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                              decoration: BoxDecoration(
                                gradient: fawry ? greenGradientColor : null,
                                color: fawry ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_balance_wallet,
                                      color: fawry ? Colors.white : mainColor),
                                  SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(
                                            opacity: animation, child: child),
                                    child: fawry
                                        ? Text(
                                            "Fawry",
                                            key: ValueKey('fawry'),
                                            style: TextStyle(
                                              fontFamily: 'eras-itc-demi',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : SizedBox(width: 0, height: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          flex: cash ? 3 : 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                creditCard = false;
                                fawry = false;
                                cash = true;
                                paymentWay = "Cash";
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                              decoration: BoxDecoration(
                                gradient: cash ? greenGradientColor : null,
                                color: cash ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.money,
                                      color: cash ? Colors.white : mainColor),
                                  SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (child, animation) =>
                                        FadeTransition(
                                            opacity: animation, child: child),
                                    child: cash
                                        ? Text(
                                            "Cash",
                                            key: ValueKey('cash'),
                                            style: TextStyle(
                                              fontFamily: 'eras-itc-demi',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          )
                                        : SizedBox(width: 0, height: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
