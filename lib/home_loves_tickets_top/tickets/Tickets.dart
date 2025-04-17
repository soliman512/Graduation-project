import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

Widget _buildCustom(String text, Color textcolor) {
  return Container(
    width: 60,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: textcolor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
          color: Color(0xffFFFFFF), fontFamily: "myfont", fontSize: 12),
    ),
  );
}

Widget buildCard({
  required String title,
  required String location,
  required String name,
  required String day,
  required String time,
  required String imageUrl,
  required String price,
  required bool status,
}) {
  return Center(
    child: GestureDetector(
      onTap: () {},
      child: Container(
        width: 360.0,
        // height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Before 3 days",
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (status) _buildCustom("Progress", Colors.green),
                      if (!status)
                        _buildCustom("end", Color.fromARGB(255, 235, 2, 2)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stadium,
                        size: 19,
                        color: Color(0xff00B92E),
                      ),
                      SizedBox(width: 5),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'eras-itc-bold',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00B92E),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 10,
                        color: Color(0xff00B92E),
                      ),
                      SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'eras-itc-demi',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 10,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'eras-itc-demi',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            day,
                            style: TextStyle(
                              fontFamily: 'eras-itc-demi',
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 12,
                            color: Color(0xff00B92E),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff00B92E),
                              fontFamily: 'eras-itc-bold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -26.0,
              right: -26.0,
              child: Image.asset(
                "assets/home_loves_tickets_top/imgs/ball.png",
                width: 100.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            extendBodyBehindAppBar: false,
            appBar: Create_AppBar(
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.w900,
                        color: Color(0xff000000),
                        fontSize: 24.0),
                    children: [
                      TextSpan(text: "Book"),
                      TextSpan(
                          text: "ing",
                          style: TextStyle(color: Color(0xff00B92E))),
                      TextSpan(text: " Status"),
                    ]),
              ),
            ),
            floatingActionButton: Container(
              width: double.infinity,
              height: 60.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/favourites');
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/favourite.png"),
                    iconSize: 40.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white12,
                    radius: 6.0,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/home.png"),
                    iconSize: 40.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white12,
                    radius: 6.0,
                  ),
                  Image.asset(
                      "assets/home_loves_tickets_top/imgs/ticket_active.png",
                      width: 40.0)
                ],
              ),

              // margin: EdgeInsets.only(left: 16),
              // alignment: Alignment.center,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: [
                backgroundImage_balls,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                        buildCard(
                        title: "Galaxy Club",
                        location: "Downtown City Center",
                        name: "John Doe",
                        day: "12/12/2025",
                        time: "5:00pm - 7:00pm",
                        imageUrl: "assets/cards_home_player/imgs/test.jpg",
                        price: "150.00 .LE",
                        status: false,
                        ),
                      SizedBox(height: 20),
                      buildCard(
                        title: "stars club",
                        location: "Assiut_new assiut city_suzan",
                        name: "Abdelaziz Adel",
                        day: "6/5/2025",
                        time: "2:30pm - 4:00pm",
                        imageUrl: "assets/cards_home_player/imgs/test.jpg",
                        price: "120.00 .LE",
                        status: true,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
