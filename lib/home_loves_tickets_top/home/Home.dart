import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double heightOfListfilter_city = 0.0;
  double heightOfListfilter_place = 0.0;
  String searchQuery = '';

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            extendBodyBehindAppBar: false,
            drawer: Create_Drawer(
              onHomeTap: () {},
              onProfileTap: () {},
            ),
            appBar: Create_AppBar(
                title: Add_AppName(
              align: TextAlign.center,
              font_size: 24.0,
              color: Colors.black,
            )),
            //floating action button for home, tickets, and favourites
            floatingActionButton: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              height: 60.0,
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
                  Image.asset(
                    "assets/home_loves_tickets_top/imgs/home_active.png",
                    width: 40.0,
                    height: 40.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white12,
                    radius: 6.0,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tickets');
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/ticket.png"),
                    iconSize: 40.0,
                  ),
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
                      SizedBox(height: 55),
//search bar
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/home_loves_tickets_top/imgs/icon-park-outline_search.png',
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
                              // height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border(
                                  left: BorderSide(color: mainColor, width: 4),
                                  right:
                                      BorderSide(color: mainColor, width: 0.5),
                                  top: BorderSide(color: mainColor, width: 0.5),
                                  bottom:
                                      BorderSide(color: mainColor, width: 0.5),
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
                                        color: const Color.fromARGB(
                                            255, 19, 19, 19),
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
//filter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // icon
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.filter_list_alt,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              decoration: BoxDecoration(
                                gradient: greenGradientColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          //city
                          Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(right: 14.0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                height: 48.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                        color: mainColor, width: 0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(59, 0, 0, 0),
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                        'assets/home_loves_tickets_top/imgs/city_Vector.png'),
                                    SizedBox(width: 10.0),
                                    Text(
                                      "City",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: mainColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          // price
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(right: 14.0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                height: 48.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                        color: mainColor, width: 0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(59, 0, 0, 0),
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0),
                                    ]),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/home_loves_tickets_top/imgs/price_Vector.png'),
                                  ],
                                )),
                          ),
                          //rating
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(right: 14.0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                height: 48.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                        color: mainColor, width: 0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              const Color.fromARGB(59, 0, 0, 0),
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0),
                                    ]),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/home_loves_tickets_top/imgs/rating_Vector.png'),
                                  ],
                                )),
                          ),
                        ],
                      ),

                      //just space
                      SizedBox(
                        height: 40.0,
                      ),
//just space
                      SizedBox(
                        height: 30.0,
                      ),
// cards
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('stadiums')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Image.asset('assets/loading.gif'));
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline,
                                      size: 100,
                                      color: const Color.fromARGB(38, 0, 0, 0)),
                                  SizedBox(height: 16),
                                  Text("No stadiums found or shown",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: const Color.fromARGB(
                                              38, 0, 0, 0))),
                                ],
                              ),
                            );
                          } else if (searchQuery.isNotEmpty) {
                            List<DocumentSnapshot> stadiumsAfterFilter =
                                snapshot.data!.docs
                                    .where((stadium) => stadium['name']
                                        .toLowerCase()
                                        .contains(searchQuery.toLowerCase()))
                                    .toList();
                            if (stadiumsAfterFilter.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline,
                                        size: 100,
                                        color:
                                            const Color.fromARGB(38, 0, 0, 0)),
                                    SizedBox(height: 16),
                                    Text("No stadiums found or shown",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: const Color.fromARGB(
                                                38, 0, 0, 0))),
                                  ],
                                ),
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
                                      File(
                                          'assets/cards_home_player/imgs/test.jpg')
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
                                      File(
                                          'assets/cards_home_player/imgs/test.jpg')
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),

                      SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ],
            )));
  }
}
