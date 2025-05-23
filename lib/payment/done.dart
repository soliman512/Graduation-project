import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Done extends StatefulWidget {
  final String bookID;
  final String matchDate;
  final String stadiumID;
  final String matchCost;
  final String matchDuration;
  final String matchTime;

  const Done({
    required this.bookID,
    required this.matchDate,
    required this.matchTime,
    required this.stadiumID,
    required this.matchCost,
    required this.matchDuration,
    super.key,
  });

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  String matchTime = '';
  String stadiumName = '';
  String stadiumLocation = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      Future.delayed(Duration(seconds: 1), () {
        _AnimatedCheck();
      });
    });
    setCardDetails();
  }

  double opacity = 0;
  double checkAnimatedWhiteCircle_width = 0;
  double checkAnimatedGreenCircle_width = 0;
  double checkIconWidth = 0;
  double marginTopForCheck = 300.0;
  List checkImagesWithCircle = [
    // big green circle
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 9.png'),
      'top': 0.0,
      'right': 0.0,
      'left': 0.0,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // big white circle
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 28.png'),
      'top': 0.0,
      'right': 0.0,
      'left': 0.0,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // right MID white circle
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 12.png'),
      'top': 6.06,
      'right': 0.0,
      'left': 167.56,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // green circle (under white)
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 13.png'),
      'top': 37.37,
      'right': 0.0,
      'left': 200.87,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // right, small white circle (up MID white)
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 14.png'),
      'top': 6.06,
      'right': 0.0,
      'left': 150.54,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // dark green circle
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 15.png'),
      'top': 170.61,
      'right': 0.0,
      'left': 166.55,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // left down small green
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 16.png'),
      'top': 189.9,
      'right': 0.0,
      'left': 46.43,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // very small green, down left
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 17.png'),
      'top': 43.43,
      'right': 0.0,
      'left': 0.0,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // black circle, left
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 18.png'),
      'top': 137.37,
      'right': 0.0,
      'left': 19.18,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // up black, white circle
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 19.png'),
      'top': 107.07,
      'right': 0.0,
      'left': 27.25,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // very small circle, down left under black
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 20.png'),
      'top': 157.58,
      'right': 0.0,
      'left': 56.35,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // top white circle, top big white, right
    {
      'image':
          Image.asset('assets/payment_successful_check/imgs/Ellipse 21.png'),
      'top': 63.64,
      'right': 0.0,
      'left': 162.51,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },

    // check
    {
      'image': Image.asset(
          'assets/payment_successful_check/imgs/icons8-check-mark-100 (1) 1.png'),
      'top': 0.0,
      'right': 0.0,
      'left': 0.0,
      'bottom': 0.0,
      'topPosition': 200.0,
      'bottomPosition': 0.0,
      'leftPosition': 100.0,
      'rightPosition': 0.0,
    },
  ];

  void _AnimatedCheck() {
    setState(() {
      for (var i = 0; i < checkImagesWithCircle.length; i++) {
        checkImagesWithCircle[i]['topPosition'] =
            checkImagesWithCircle[i]['top'];
        checkImagesWithCircle[i]['bottomPosition'] =
            checkImagesWithCircle[i]['bottom'];
        checkImagesWithCircle[i]['leftPosition'] =
            checkImagesWithCircle[i]['left'];
        checkImagesWithCircle[i]['rightPosition'] =
            checkImagesWithCircle[i]['right'];
        opacity = 1;
        checkAnimatedGreenCircle_width = 189.77;
        checkAnimatedWhiteCircle_width = 119.11;
        checkIconWidth = 60.56;
        marginTopForCheck = 0.0;
      }
    });
  }

  int duration = 800;
  int durationAll = 600;

  void setCardDetails() async {
    // Get booking details
    final bookingDoc = await FirebaseFirestore.instance
        .collection("bookings")
        .doc(widget.bookID)
        .get();

    matchTime = bookingDoc.data()?['matchTime'] ?? '';

    // Get stadium details
    final stadiumDoc = await FirebaseFirestore.instance
        .collection("stadiums")
        .doc(widget.stadiumID)
        .get();

    setState(() {
      stadiumName = stadiumDoc.data()?['name'] ?? '';
      stadiumLocation = stadiumDoc.data()?['location'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        // title: Add_AppName(
        //   font_size: 30,
        //   align: TextAlign.center,
        //   color: Colors.white,
        // ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          backgroundImage,
          blackBackground,
          Container(
            margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Booking Successfully",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 26,
                      fontFamily: "eras-itc-demi",
                    ),
                  ),
                  Text(
                    " has been completed",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Container(
                    width: 500,
                    margin: EdgeInsets.fromLTRB(0, 300, 0, 0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "assets/payment_successful_check/imgs/successCard.png",
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 100,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      FirebaseAuth.instance.currentUser
                                              ?.displayName ??
                                          'Guest',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "eras-itc-demi"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month_rounded,
                                      color: Colors.white, size: 20.0),
                                  SizedBox(width: 4.0),
                                  Text(
                                    widget.matchDate.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: "eras-itc-demi"),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 60,
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_filled,
                                      color: Colors.white, size: 20.0),
                                  Text(
                                    matchTime + ' : ' + widget.matchDuration,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: "eras-itc-demi"),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 90,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      stadiumName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "eras-itc-demi"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 125,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      stadiumLocation,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   left: 20,
                            //   top: 150,
                            //   child: Container(
                            //     width: 100,
                            //     height: 30,
                            //     decoration: BoxDecoration(
                            //       color: Colors.black,
                            //       borderRadius: BorderRadius.circular(60),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           "Booked",
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 14,
                            //             fontFamily: "eras-itc-demi",
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Icon(Icons.price_check_rounded,
                            //             color: Colors.white, size: 20.0),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              right: 20,
                              top: 150,
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: widget.matchCost.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: "eras-itc-demi",
                                            )),
                                        TextSpan(
                                            text: ".LE",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontFamily: "eras-itc-demi",
                                            ))
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFFFFFFF)),
                              ),
                              onPressed: () {},
                              child: Icon(Icons.save_alt, size: 16)),
                          margin: EdgeInsets.only(top: 20),
                          width: 60,
                          height: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFFFFFFF)),
                              ),
                              onPressed: () {},
                              child: Icon(Icons.share_rounded, size: 16.0)),
                          margin: EdgeInsets.only(top: 20),
                          width: 60,
                          height: 35,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFFFFFFF)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontFamily: "eras-itc-demi"),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 20),
                          width: 160,
                          height: 35,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //check
          AnimatedContainer(
            margin: EdgeInsets.only(top: marginTopForCheck),
            duration: Duration(milliseconds: durationAll),
            width: double.infinity,
            child: Center(
              child: Container(
                width: 215.0,
                height: 200.0,
                child: Container(
                  child: Stack(
                    //  alignment : AlignmentDirectional.centerEnd,
                    children: [
                      //big green circle
                      Center(
                        child: AnimatedContainer(
                          width: checkAnimatedGreenCircle_width,
                          duration: Duration(milliseconds: duration),
                          child: checkImagesWithCircle[0]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //big white circle
                      Center(
                        child: AnimatedContainer(
                          onEnd: _AnimatedCheck,
                          width: checkAnimatedWhiteCircle_width,
                          duration: Duration(milliseconds: duration),
                          child: checkImagesWithCircle[1]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //small white circle
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[2]['topPosition'],
                              left: checkImagesWithCircle[2]['leftPosition']),
                          child: checkImagesWithCircle[2]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //green circle (under white)
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[3]['topPosition'],
                              left: checkImagesWithCircle[3]['leftPosition']),
                          child: checkImagesWithCircle[3]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //right, small white circle (into big green)
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[4]['topPosition'],
                              left: checkImagesWithCircle[4]['leftPosition']),
                          child: checkImagesWithCircle[4]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //dark green circle
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[5]['topPosition'],
                              left: checkImagesWithCircle[5]['leftPosition']),
                          child: checkImagesWithCircle[5]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //left down small green
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[6]['topPosition'],
                              left: checkImagesWithCircle[6]['leftPosition']),
                          child: checkImagesWithCircle[6]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //very small green, down left
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[7]['topPosition'],
                              left: checkImagesWithCircle[7]['leftPosition']),
                          child: checkImagesWithCircle[7]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //black circle, left
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[8]['topPosition'],
                              left: checkImagesWithCircle[8]['leftPosition']),
                          child: checkImagesWithCircle[8]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //up black, white circle
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[9]['topPosition'],
                              left: checkImagesWithCircle[9]['leftPosition']),
                          child: checkImagesWithCircle[9]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //very small circle, down left under black
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[10]['topPosition'],
                              left: checkImagesWithCircle[10]['leftPosition']),
                          child: checkImagesWithCircle[10]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //top white circle, top big white, right
                      AnimatedOpacity(
                        duration: Duration(milliseconds: duration),
                        opacity: opacity,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(
                              top: checkImagesWithCircle[11]['topPosition'],
                              left: checkImagesWithCircle[11]['leftPosition']),
                          child: checkImagesWithCircle[11]['image'],
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 0.0),
                                color: Colors.black54,
                                blurRadius: 10.0)
                          ], shape: BoxShape.circle),
                        ),
                      ),

                      //check
                      Center(
                        child: AnimatedContainer(
                          width: checkIconWidth,
                          duration: Duration(milliseconds: duration),
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: checkImagesWithCircle[12]['image'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
