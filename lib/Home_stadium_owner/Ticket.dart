import 'package:flutter/material.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';

class Tickets_Owner extends StatefulWidget {
  @override
  State<Tickets_Owner> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets_Owner> {
  Widget buildCard({
    required String title,
    required String location,
    required String name,
    required String day,
    required String time,
    required String imageUrl,
    required String svgurl,
    required String price,
  }) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.green, width: 2),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.darken),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isArabic ? "قبل 3 أيام" : "Before 3 days",
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          ),
                          Row(
                            children: [
                              _buildCustom(isArabic ? "انتهت" : "End", Colors.red),
                              _buildCustom(isArabic ? "جاري" : "Progress", Colors.green),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/favourite/imgs/icons8-stadium-100 2.png",
                                width: 19,
                                height: 19,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "myfont",
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
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/favourite/imgs/Group 140.png",
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/favourite/imgs/🦆 icon _clock_.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/favourite/imgs/Vector.png",
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      day,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        price,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff00B92E),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      svgurl,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/favourite/imgs/ball 1.png"),
            ),
          ],
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          foregroundColor: Color(0xff000000),
          elevation: 0,
          backgroundColor: Color(0x00),
          leading: Container(
            margin: EdgeInsets.only(left: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/home_loves_tickets_top/imgs/4213475_arrow_back_left_return_icon (2) 3.png",
                width: 40,
                height: 40,
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                    "assets/home_loves_tickets_top/imgs/notifications.png"),
                iconSize: 24.0,
              ),
            )
          ],
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                    fontFamily: "eras-itc-bold",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff000000),
                    fontSize: 24.0),
                children: [
                  TextSpan(text: isArabic ? "حجز" : "Book"),
                  TextSpan(
                      text: isArabic ? "حالة" :"ing" , style: TextStyle(color: Color(0xff00B92E))),
                  TextSpan(text: isArabic ? " ": " Status"),
                ]),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildCard(
                  title: "Barca",
                  location: "Assiut_new assiut city_suzan",
                  name: "Abdelaziz Adel",
                  day: "Friday 6/5/2025",
                  time: "2:30pm-4:00pm",
                  imageUrl: "assets/favourite/imgs/120316-ملعب-خماسى--(2).jpg",
                  svgurl: "assets/favourite/imgs/Group 123.png",
                  price: "300.00 .LE",
                ),
                SizedBox(height: 16),
                buildCard(
                  title: "Wembley",
                  location: "New Assiut_suzan",
                  name: "Omar Al-Somah",
                  day: "Friday 6/5/2025",
                  time: "2:30pm-4:00pm",
                  imageUrl:
                      "assets/favourite/imgs/251123-BFCA3674-9133-44F9-9BE9-8F5433D236E6.jpeg",
                  svgurl: "assets/favourite/imgs/Group 123 (1).png",
                  price: "250.00 .LE",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
