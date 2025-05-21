import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdown_editStadium.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Stadium_info_stadiumOwner extends StatefulWidget {
  String stadiumName;
  String stadiumPrice;
  String stadiumLocation;
  bool isWaterAvailbale = false;
  bool isTrackAvailable = false;
  bool isGrassNormal = false;
  String capacity;
  String description;
  List<String> workingDays;
  String startTime;
  String endTime;
  String stadiumID;
  List<String> imagesUrl = [];
  // List<String> imagesUrl;
  Stadium_info_stadiumOwner({
    required this.stadiumName,
    required this.stadiumPrice,
    required this.stadiumLocation,
    required this.isWaterAvailbale,
    required this.isTrackAvailable,
    required this.isGrassNormal,
    required this.capacity,
    required this.description,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.stadiumID,
    required this.imagesUrl,
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
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
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
                      stadiumName: widget.stadiumName,
                      stadiumPrice: widget.stadiumPrice,
                      stadiumDescription: widget.description,
                      stadiumCapacity: widget.capacity,
                      stadiumLocation: widget.stadiumLocation,
                      stadiumId: widget.stadiumID,
                      stadiumImagesUrl: widget.imagesUrl,
                      stadiumHasWater: widget.isWaterAvailbale,
                      stadiumHasTrack: widget.isTrackAvailable,
                      stadiumIsNaturalGrass: widget.isGrassNormal,
                      stadiumWorkingDays: widget.workingDays,
                      stadiumStartTime: widget.startTime,
                      stadiumEndTime: widget.endTime,
                      // imagesUrl: widget.imagesUrl,

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
                      isArabic ? 'الميزات' : 'features',
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
                                          ? isArabic ? 'متاح' : 'Available'
                                          : isArabic ? 'غير متاح' : 'Univailable',
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
                                          ? isArabic ? 'متاح' : 'Available'
                                          : isArabic ? 'غير متاح' : 'Univailable',
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
                                          ? isArabic ? 'طبيعي' : 'industry'
                                          : isArabic ? 'صناعي' : 'normal',
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
                              ? isArabic ? '  متاح ماء' : 'water is avalablie'
                              : isArabic ? ' غير متاح ماء' : 'no water ',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 9),
                        Text(
                          '${widget.capacity} ${isArabic ? 'لاعب' : 'players' }',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          widget.isTrackAvailable
                              ? isArabic ? ' مسار الجري متاح' : 'running track'
                              : isArabic ? ' مسار الجري غير متاح' : 'no running track',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 9),
                        Text(
                          widget.isGrassNormal
                              ? isArabic ? 'عشب طبيعي' : 'grass is normal'
                              : isArabic ? 'عشب صناعي' : 'grass is indusrty',
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
                      isArabic ? 'الوصف' : 'description',
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
              
              // table with working days and time
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      isArabic ? 'وقت العمل والأيام' : 'work time and days',
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
              // Work time and days table
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('stadiums')
                    .doc(widget.stadiumID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: mainColor.withOpacity(0.3),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: Text(
                            isArabic ? 'وقت العمل' : 'Work Time',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "eras-itc-demi",
                              color: mainColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isArabic ? 'من' : 'From',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.startTime,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 1,
                                    color: Colors.grey[300],
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey[300],
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isArabic ? 'الى' : 'To',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.endTime,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 1,
                                    color: Colors.grey[300],
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey[300],
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isArabic ? 'الايام' : 'Days',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ' • ' + widget.workingDays.join('\n • '),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()), // Divider on the left side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      isArabic ? 'التعليقات' : 'feedbacks',
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
              // Comment Box
              for (int i = 0; i < 4; i++) ...[
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
                      color: const Color.fromARGB(14, 0, 0, 0),
                      blurRadius: 2,
                      // offset: Offset(0, 2),
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
                          isArabic ? "إستير هور" : "Esther Howard",
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
                                isArabic ? "الحجز في" : "BOOKING IN ",
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
                            isArabic ? 'هذا يجب أن يعطيك هيكلًا محددًا بالضبط كما يظهر في الصورة. اخبرني إذا كنت بحاجة إلى تعديلات إضافية!' : 'This should give you the exact structure shown in the image. Let me know if you need further adjustments!',
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
              SizedBox(height: 28),
              ],
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
                        isArabic ? "تم" : "Completed",
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
                        isArabic ? "نشط" : "Live",
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
                        isArabic ? "تم الالغاء" : "Canceled",
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
