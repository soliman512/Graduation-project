import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';

// ignore: must_be_immutable
class Stadium_info_playerPG extends StatefulWidget {
  String stadiumName = '';
  String stadiumPrice = '';
  String stadiumLocation = '';
  bool isWaterAvailbale = false;
  bool isTrackAvailable = false;
  bool isGrassNormal = false;
  String capacity = '';
  String description = '';

  Stadium_info_playerPG({
    required this.stadiumName,
    required this.stadiumPrice,
    required this.stadiumLocation,
    required this.isWaterAvailbale,
    required this.isTrackAvailable,
    required this.isGrassNormal,
    required this.capacity,
    required this.description,
  });

  @override
  State<Stadium_info_playerPG> createState() => _Stadium_info_playerPGState();
}

class _Stadium_info_playerPGState extends State<Stadium_info_playerPG> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(6),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image Slider Section
              SizedBox(
                width: double.infinity,
                height: 260,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        for (int i = 0; i < 4; i++)
                          Image.asset('assets/cards_home_player/imgs/test.jpg',
                              fit: BoxFit.cover),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: _currentPage == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Stadium Name, rating Button and add to favorite Button
              Text(
                widget.stadiumName,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "eras-itc-demi",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20.0),
                      Text(
                        '${widget.stadiumPrice}.00 LE',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-bold",
                          color: mainColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
//rating
                  Row(children: [
                    Row(children: [
                      for (int i = 0; i < 5; i++)
                        Icon(Icons.star, color: Colors.amber, size: 15),
                    ]),
                    Text(
                      "5.0",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 161, 161, 161),
                      ),
                    ),
                    SizedBox(width: 20),
                  ]),
                ],
              ),

              const SizedBox(height: 20),
              //location
              Row(
                children: [
                  SizedBox(width: 20.0),
                  Icon(Icons.location_on, color: Colors.grey, size: 18),
                  Text(
                    widget.stadiumLocation,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'features',
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
              // Features Icons
              Container(
                width: double.infinity,
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.black),
                child: Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        child: Transform.rotate(
                          angle: 0.785,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Transform.rotate(
                              angle: -0.785,
                              child: Icon(Icons.auto_awesome,
                                  size: 29, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.water_drop,
                                      size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text(
                                      widget.isWaterAvailbale
                                          ? 'Available'
                                          : 'Univailable',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.track_changes,
                                      size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text(
                                      widget.isTrackAvailable
                                          ? 'Available'
                                          : 'Univailable',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Icon(Icons.grass, size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text(
                                      widget.isGrassNormal
                                          ? 'normal'
                                          : 'industry',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.group, size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text(widget.capacity,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            ],
                          ))
                    ]),
              ),
              SizedBox(height: 4),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isWaterAvailbale
                              ? 'water is avalablie'
                              : 'no water ',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 9),
                        Text(
                          '${widget.capacity} players',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          widget.isTrackAvailable
                              ? 'running track'
                              : 'no running track',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 9),
                        Text(
                          widget.isGrassNormal
                              ? 'grass is normal'
                              : 'grass is indusrty',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'description',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38),
                    ),
                  ),
                  Expanded(child: Divider()), // Divider on the right side
                ],
              ),
              SizedBox(height: 40.0),
              // Description
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              //choose match date
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'choose match date',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38),
                    ),
                  ),
                  Expanded(child: Divider()), // Divider on the right side
                ],
              ),
              SizedBox(height: 40.0),
              // Date, Time, Duration buttons
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Container(
                          width: 110.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xADADAD),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xff00B92E),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Day",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "eras-itc-light",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 110.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xADADAD),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xff00B92E),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Time",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "eras-itc-light",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 110.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xADADAD),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xff00B92E),
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "eras-itc-light",
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Comments Section
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'reviews',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38),
                    ),
                  ),
                  Expanded(child: Divider()), // Divider on the right side
                ],
              ),
              SizedBox(height: 40.0),
              SizedBox(height: 10),
              // Comment Box
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xff00B92E),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Wrap(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/stadium_information_player_pg/imgs/person.jpeg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "ahmed_789",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "eras-itc-demi",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 100.0),
                              Text(
                                "3:45 pm",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "eras-itc-light",
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Amazing experience! The field was in perfect condition, and the facilities were top-notch. We had a great time playing here Highly recommend it!",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star, color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_half,
                            color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_border,
                            color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_border,
                            color: Color(0xffFFCC00), size: 16),
                        Text(
                          "2.5",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 134, 133, 133),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.stadiumPrice + '.00',
                          style: TextStyle(
                              color: Color(0xff00B92E),
                              fontSize: 32.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' LE',
                          style: TextStyle(
                              color: Color(0xff00B92E),
                              fontSize: 16.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        gradient: greenGradientColor,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Center(
                      child: Text(
                        "Book",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'eras-itc-bold',
                            fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
