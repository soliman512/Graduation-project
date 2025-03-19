import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_main/constants/constants.dart';

import '../../main.dart';

class Home_Owner extends StatefulWidget {
  @override
  State<Home_Owner> createState() => _HomeState();
}

class _HomeState extends State<Home_Owner> {
  Widget buildCard({
    required BuildContext context,
    required String title,
    required String location,
    required String imageUrl,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 360.0,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: mainColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 130.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "eras-itc-bold",
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  location,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 130, 128, 128),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 13,
                              color: mainColor,
                              fontFamily: "eras-itc-bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(children: [
                            Text(
                              "5.5",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.star,
                                color: Color(0xffFFCC00), size: 15),
                            SizedBox(width: 1),
                            Icon(Icons.star,
                                color: Color(0xffFFCC00), size: 15),
                            SizedBox(width: 1),
                            Icon(Icons.star,
                                color: Color(0xffFFCC00), size: 15),
                            SizedBox(width: 1),
                            Icon(Icons.star,
                                color: Color(0xffFFCC00), size: 15),
                            SizedBox(width: 1),
                            Icon(Icons.star,
                                color: Color(0xffFFCC00), size: 15),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            extendBodyBehindAppBar: false,
            floatingActionButton: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Positioned(
                  bottom: 100,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Image.asset(
                        "assets/home_loves_tickets_top/imgs/Group 204.png"),
                    shape: CircleBorder(),
                    backgroundColor: Color(0xff000000),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 1,
                  child: Container(
                    width: 185,
                    height: 80,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Color(0xfffffffff),
                      onPressed: () {
                        Navigator.pushNamed(context, '/stdWon_addNewStadium');
                      },
                      child: Container(
                        width: 185,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF005706),
                              Color(0xFF007211),
                              Color(0xFF00911E),
                              Color(0xFF00B92E),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png",
                                  width: 36.67,
                                  height: 36.67,
                                ),
                                Positioned(
                                  right: 0,
                                  left: 25,
                                  top: 0,
                                  bottom: 20,
                                  child: Image.asset(
                                    "assets/home_loves_tickets_top/imgs/Frame 125.png",
                                    width: 23.16,
                                    height: 23.16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "New",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                      fontFamily: "eras-itc-bold"),
                                ),
                                Text(
                                  "Stadium",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                      fontFamily: "eras-itc-bold"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              toolbarHeight: 80.0,
// foregroundColor: Color(0xFFFFFFFF),
              elevation: 0,
              backgroundColor: Color(0xFFFFFFFF),
//bars
              leading: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        Scaffold.of(context).openDrawer();
                      });
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/bars.png"),
                    iconSize: 24.0,
                  );
                }),
              ),

// notifications
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Welcome');
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/notifications.png"),
                    iconSize: 24.0,
                  ),
                )
              ],
//title "vamonos"
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.w900,
                        color: Color(0xff000000),
                        fontSize: 26.0),
                    children: [
                      TextSpan(text: "V"),
                      TextSpan(text: "á", style: TextStyle(color: mainColor)),
                      TextSpan(text: "monos"),
                    ]),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //SEARCH
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(16.0, 34.0, 16.0, 0.0),
                          padding: EdgeInsets.only(left: 12.0, right: 8.0),
                          height: 48.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 4.0),
                              ]),
                          child: Container(
                            width: double.infinity,
                            child: TextField(
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                              ),
                              autocorrect: true,
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "What are you stadiums looking for ? ...",
                                hintStyle: TextStyle(
                                  color: Color(0x73000000),
                                  fontSize: 12.0,
                                ),
                                prefixIcon: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Image.asset(
                                      "assets/home_loves_tickets_top/imgs/Vectorcom.png"),
                                ),
                                suffixIcon: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            CircleBorder()),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                mainColor),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)),
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/home_loves_tickets_top/imgs/icon-park-outline_search.png",
                                      width: 26.0,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        //just space
                        SizedBox(
                          height: 24.0,
                        ),
                        // cards
                        Container(
                          width: double.infinity,
                          // margin: EdgeInsets.symmetric(horizontal: 16.0),
                          margin: EdgeInsets.only(bottom: 60.0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              buildCard(
                                context: context,
                                title: "Wembley",
                                location: "New Assiut_suzan",
                                imageUrl:
                                    "assets/cards_home_player/imgs/251123-BFCA3674-9133-44F9-9BE9-8F5433D236E6.jpeg",
                                price: "250.00 .LE",
                              ),
                              buildCard(
                                context: context,
                                title: "Camp Nou",
                                location: "Barcelona_Spain",
                                imageUrl:
                                    "assets/cards_home_player/imgs/pngtree-the-camp-nou-stadium-in-barcelona-spain-sport-nou-angle-photo-image_4879020.jpg",
                                price: "150.00 LE",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
