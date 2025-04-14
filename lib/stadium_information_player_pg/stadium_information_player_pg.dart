import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Stadium_info_playerPG(),
  ));
}

class Stadium_info_playerPG extends StatefulWidget {
  Stadium_info_playerPG({key});

  @override
  State<Stadium_info_playerPG> createState() => _Stadium_info_playerPGState();
}

class _Stadium_info_playerPGState extends State<Stadium_info_playerPG> {
  double sendCommentClose = 25.0;
  TextEditingController _commentController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Stadium Information'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
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
              const SizedBox(height: 10),

              // Stadium Name, rating Button and add to favorite Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Wembley",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: "eras-itc-bold",
                      ),
                    ),
                  ),
                  Row(
                    children: [
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
                    ],
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? mainColor : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => setState(() => isFavorite = !isFavorite),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // price
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(children: [
                  Text(
                    "200.00 .LE",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "eras-itc-bold",
                      color: mainColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  // SizedBox(width: 10),
                ]),
              ),

              //location
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 18),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assiut, New Assiut City, Suzan ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 40),
              // Divider
              Container(
                height: 1,
                color: const Color.fromARGB(38, 0, 0, 0),
                margin: const EdgeInsets.symmetric(horizontal: 18),
              ),
              const SizedBox(height: 30),
              // Features Icons
              Container(
                width: 400,
                height: 80,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -30,
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
                                  Text("Available",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.track_changes,
                                      size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text("track",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Icon(Icons.grass, size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text("normal",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.group, size: 29, color: mainColor),
                                  SizedBox(height: 6),
                                  Text("10",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            ],
                          ))
                    ]),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Description",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "A football field with durable artificial grass, perfect for all-weather games. The surface is smooth, with clear white lines marking key areas like the penalty box. Surrounding the field are safety fences and seating for spectators. Bright floodlights make it ideal for exciting night matches.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "- water is avalablie",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  "- seats 10 people",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              children: [
                                Text(
                                  "- running track ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  "- grass is normal",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                      ),
                    )
                  ],
                ),
              ),

              // Back Button
              Positioned(
                top: 40,
                left: 16,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),

              // Choose date of match section
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Choose date of match",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: "eras-itc-demi",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              // Date, Time, Duration buttons
              SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xADADAD)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xFF000000)),
                            side: WidgetStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Day",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xADADAD)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xFF000000)),
                            side: WidgetStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xADADAD)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xFF000000)),
                            side: WidgetStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 49.0),

              // Comments Section
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: "eras-itc-demi",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              // Add Comment
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Color(0x9DD9D9D9),
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextField(
                  controller: _commentController,
                  onChanged: (s) {
                    setState(() {
                      if (_commentController.text.isEmpty) {
                        sendCommentClose = 25.0;
                      } else {
                        sendCommentClose = 0.0;
                      }
                    });
                  },
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontFamily: "eras-itc-demi",
                  ),
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  cursorColor: Color(0xff00B92E),
                  autocorrect: true,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffix: Stack(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(CircleBorder()),
                                backgroundColor:
                                    WidgetStateProperty.all(Color(0xff00B92E)),
                              ),
                              child: Icon(
                                Icons.send_rounded,
                                size: 16,
                                color: Color(0xFFFFFFFF),
                              )),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.only(left: 15.0),
                            width: sendCommentClose,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF00B92E),
                              shape: BoxShape.circle,
                            ),
                            child: null,
                          ),
                        ],
                      ),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(right: 12.0),
                        child: Image.asset(
                            'assets/stadium_information_player_pg/imgs/comment.png'),
                      ),
                      hintText: 'Add Comment',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black45,
                        fontFamily: "eras-itc-light",
                      )),
                ),
              ),
              SizedBox(height: 16.0),
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
                              Positioned(
                                right: 16.0,
                                child: Text(
                                  "3:45 pm",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "eras-itc-light",
                                    color: Colors.grey,
                                  ),
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
                          '200,0',
                          style: TextStyle(
                              color: Color(0xff00B92E),
                              fontSize: 32.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' .LE',
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
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff005706),
                          Color(0xff007211),
                          Color(0xff00911E),
                          Color(0xff00B92E),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      "Book",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "eras-itc-bold",
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
