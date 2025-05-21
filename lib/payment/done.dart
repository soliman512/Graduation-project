import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      // Call your method here
      Future.delayed(Duration(seconds: 1), () {
        _AnimatedCheck();
      });
    });
  }

  double opacity = 0;
  double checkAnimatedWhiteCircle_width = 0;
  double checkAnimatedGreenCircle_width = 0;
  double checkIconWidth = 0;
  double marginTopForCheck = 300.0;
  List checkImagesWithCircle = [
    // big green circle
    {
      'image': Image.asset('assets/img/Ellipse 9.png'),
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
      'image': Image.asset('assets/img/Ellipse 28.png'),
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
      'image': Image.asset('assets/img/Ellipse 12.png'),
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
      'image': Image.asset('assets/img/Ellipse 13.png'),
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
      'image': Image.asset('assets/img/Ellipse 14.png'),
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
      'image': Image.asset('assets/img/Ellipse 15.png'),
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
      'image': Image.asset('assets/img/Ellipse 16.png'),
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
      'image': Image.asset('assets/img/Ellipse 17.png'),
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
      'image': Image.asset('assets/img/Ellipse 18.png'),
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
      'image': Image.asset('assets/img/Ellipse 19.png'),
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
      'image': Image.asset('assets/img/Ellipse 20.png'),
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
      'image': Image.asset('assets/img/Ellipse 21.png'),
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
      'image': Image.asset('assets/img/icons8-check-mark-100 (1) 1.png'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "V",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "myfont",
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: "á",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                    fontFamily: "myfont",
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: "monos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "myfont",
                    fontWeight: FontWeight.bold))
          ]),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/img/welcome 2.jpg",
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Column(
              children: [
                Text(
                  "Booking Successfully",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 26,
                    fontFamily: "myfont",
                  ),
                ),
                Text(
                  " has been completed",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: "myfont"),
                ),
                Container(
                  width: 500,
                  margin: EdgeInsets.fromLTRB(0, 300, 0, 0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/img/Frame 63.png",
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
                                    "AbdelAziz Adel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "myfont"),
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
                                Image.asset(
                                  "assets/img/🦆 icon _calendar_.png",
                                  width: 20,
                                ),
                                Text(
                                  "Friday 6/5/2025",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: "myfont"),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 60,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/img/🦆 icon _clock_.png",
                                  width: 20,
                                ),
                                Text(
                                  "2:30Pm-4:00Pm",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: "myfont"),
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
                                    "Wembley",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "myfont"),
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
                                    "Assiut_new assiut city_suzan",
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
                          Positioned(
                            left: 20,
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
                                  Text(
                                    "Booked",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "myfont",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Image.asset(
                                      "assets/img/icons8-visa-100.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                                          text: "200.00",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: "myfont",
                                          )),
                                      TextSpan(
                                          text: ".LE",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontFamily: "myfont",
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
                                    borderRadius: BorderRadius.circular(50))),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFFFFFFF)),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            "assets/img/🦆 icon _bookmark_.png",
                            width: 10,
                            height: 20,
                          ),
                        ),
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
                                    borderRadius: BorderRadius.circular(50))),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFFFFFFF)),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            "assets/img/🦆 icon _share boxed_.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
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
                          onPressed: () {},
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontFamily: "myfont"),
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
