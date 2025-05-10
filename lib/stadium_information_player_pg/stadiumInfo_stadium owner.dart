import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdown_editStadium.dart';

// ignore: must_be_immutable
class Stadium_info_stadiumOwner extends StatefulWidget {
  String stadiumName = '';
  String stadiumPrice = '';
  String stadiumLocation = '';
  bool isWaterAvailbale = false;
  bool isTrackAvailable = false;
  bool isGrassNormal = false;
  String capacity = '';
  String description = '';

  Stadium_info_stadiumOwner({
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
  State<Stadium_info_stadiumOwner> createState() =>
      _Stadium_info_stadiumOwnerState();
}

class _Stadium_info_stadiumOwnerState extends State<Stadium_info_stadiumOwner> {
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
          //edit button
          actions: [
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSelectedStadium(
                      name: widget.stadiumName,
                      price: widget.stadiumPrice,
                      description: widget.description,
                      capacity: widget.capacity,
                      location: widget.stadiumLocation,
                      // images: widget.images,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(6),
                width: 50,
                height: 50,
                padding: EdgeInsets.all(6.0),
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
                child: Icon(Icons.edit, color: mainColor),
              ),
            ),
          ],
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
                        Image.asset('assets/cards_home_player/imgs/test.jpg',
                            fit: BoxFit.cover),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          1,
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
                  Icon(Icons.location_on, color: mainColor, size: 18),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
              //choose match date
              SizedBox(height: 40.0),
              // Comments Section
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
                    color: const Color.fromARGB(38, 0, 185, 46),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image and Name
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              "assets/stadium_information_player_pg/imgs/person.jpeg"),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Esther Howard",
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'eras-itc-demi'),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: Color(0xffFFCC00),
                                size: 16,
                              ),
                            SizedBox(width: 4),
                            Text(
                              "5.5",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 16),
                    // Vertical Divider
                    Container(
                      height: 80,
                      width: 1,
                      color: Colors.black12,
                    ),
                    SizedBox(width: 16),
                    // Comment Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "BOOKING IN ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'eras-itc-demi'),
                              ),
                              Text(
                                "2025/3/12",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'This should give you the exact structure shown in the image. Let me know if you need further adjustments!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(20, 0, 0, 0),
                blurRadius: 40,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    border: Border.all(color: mainColor, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "23",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontFamily: 'eras-itc-demi'),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 14,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: greenGradientColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'eras-itc-demi'),
                      ),
                      Text(
                        "Live",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "2",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'eras-itc-demi'),
                      ),
                      Text(
                        "Canceled",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
