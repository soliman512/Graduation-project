import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdwon_addNewStadium.dart';

class Home_Owner extends StatefulWidget {
  @override
  State<Home_Owner> createState() => _HomeState();
}


class _HomeState extends State<Home_Owner> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 80.0,
          scrolledUnderElevation: 0,

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
                icon: Image.asset("assets/home_loves_tickets_top/imgs/bars.png",
                    width: 22.0),
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
                  "assets/home_loves_tickets_top/imgs/notifications.png",
                  width: 22.0,
                ),
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
                    fontSize: 22.0),
                children: [
                  TextSpan(text: "V"),
                  TextSpan(text: "á", style: TextStyle(color: mainColor)),
                  TextSpan(text: "monos"),
                ]),
          ),
          centerTitle: true,
        ),
        floatingActionButton: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          direction: Axis.vertical,
          children: [
            //statue
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('stadiums')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                    setState(() {});
                  }
                });
                setState(() {});
              },
              child: Container(
                width: 50.0,
                child: Image.asset(
                    "assets/home_loves_tickets_top/imgs/Group 204.png"),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            //new stadium
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/stdWon_addNewStadium');

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration:
                        Duration(milliseconds: 1500), 

                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AddNewStadium(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0); 
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 222.0,
                height: 66.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: greenGradientColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png",
                      width: 44.00,
                    ),
                    Text(
                      "New Stadium",
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 18,
                          fontFamily: "eras-itc-demi"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            backgroundImage_balls,
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 55),
                  //SEARCH
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png',
                          ),
                          decoration: BoxDecoration(
                            gradient: greenGradientColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(right: 14.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border(
                              left: BorderSide(color: mainColor, width: 4),
                              right: BorderSide(color: mainColor, width: 0.5),
                              top: BorderSide(color: mainColor, width: 0.5),
                              bottom: BorderSide(color: mainColor, width: 0.5),
                            ),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
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
                                  "What the stadiums you looking for ? ...",
                              hintStyle: TextStyle(
                                color: Color(0x73000000),
                                fontSize: 12.0,
                              ),
                              suffixIcon: Visibility(
                                visible: searchQuery.isNotEmpty,
                                child: IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {
                                      searchQuery = '';
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color:
                                        const Color.fromARGB(255, 19, 19, 19),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //just space
                  SizedBox(
                    height: 40.0,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stadiums')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Image.asset('assets/loading.gif'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/home_loves_tickets_top/imgs/noStadiums.png',
                            fit: BoxFit.contain,
                          ),
                        );
                      } else if (searchQuery.isNotEmpty) {
                        List<DocumentSnapshot> stadiumsAfterFilter = snapshot
                            .data!.docs
                            .where((stadium) => stadium['name']
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                        if (stadiumsAfterFilter.isEmpty) {
                          return Center(
                            child: Text("No stadiums found"),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stadiumsAfterFilter.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot stadium =
                                stadiumsAfterFilter[index];
                            return GestureDetector(
                              onTap: () {},
                              child: StadiumCard(
                                title: stadium['name'],
                                location: stadium['location'],
                                price: stadium['price'].toString(),
                                rating: 5,
                                selectedImages: [
                                  File('assets/cards_home_player/imgs/test.jpg')
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot stadium =
                                snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {},
                              child: StadiumCard(
                                title: stadium['name'],
                                location: stadium['location'],
                                price: stadium['price'].toString(),
                                rating: 5,
                                selectedImages: [
                                  File('assets/cards_home_player/imgs/test.jpg')
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),


SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
