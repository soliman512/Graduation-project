import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadium_information_player_pg.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:graduation_project_main/widgets/ticket_card.dart';

/// Home screen widget that displays list of stadiums with search and filter functionality
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Filter heights
  double heightOfListfilter_city = 0.0;
  double heightOfListfilter_place = 0.0;

  // Search state
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  // Location filter state
  // bool locationPopup = false;
  // double locationPopupHeight = 0.0;
  // bool visibleOfPlace = false;
  // bool visibleOfNeighborhood = false;
  // bool visibleOfButton = false;
  String filterLocation_city = '';
  String filterLocation_place = '';
  String filterLocation_location = '';
  bool isFilterLocationTurnOn = false;

  // Price filter state
  bool isFilterPriceTurnOn = false;
  bool filterTopPrice = false;
  bool filterLeastPrice = false;
  int priceCount = 0;

  // Rating filter state
  bool isFilterRatingTurnOn = false;
  bool filterTopRating = false;
  bool filterLeastRating = false;
  int ratingCount = 0;

  /// Builds list of stadium cards from Firestore documents
  Widget _buildStadiumList(List<DocumentSnapshot> stadiums) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stadiums.length,
      itemBuilder: (context, index) {
        final stadium = stadiums[index];
        return StadiumCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Stadium_info_playerPG(
                          stadiumName: stadiums[index]['name'],
                          stadiumPrice: stadiums[index]['price'].toString(),
                          stadiumLocation: stadiums[index]['location'],
                          isWaterAvailbale: stadiums[index]['hasWater'],
                          isTrackAvailable: stadiums[index]['hasTrack'],
                          isGrassNormal: stadiums[index]['isNaturalGrass'],
                          capacity: stadiums[index]['capacity'].toString(),
                          description: stadiums[index]['description'],
                        )));
          },
          title: stadium['name'],
          location: stadium['location'],
          price: stadium['price'].toString(),
          rating: 5,
          selectedImages: [
            File('assets/cards_home_player/imgs/test.jpg'),
          ],
        );
      },
    );
  }

  /// Builds empty state message when no stadiums are found
  Widget _buildEmptyMessage([String message = "No stadiums found or shown"]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              size: 100, color: Color.fromARGB(38, 0, 0, 0)),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 20, color: Color.fromARGB(38, 0, 0, 0)),
          ),
        ],
      ),
    );
  }

  //notifications:
  Widget notifications() {
    return Icon(
      Icons.notifications_none_outlined,
      size: 24,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        extendBodyBehindAppBar: false,
        drawer: Create_Drawer(),
        appBar: Create_AppBar(
            notificationState: () => showDialog(
                  barrierColor: const Color.fromARGB(237, 0, 0, 0),
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      alignment: Alignment.topCenter,
                      insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(), // Add bouncing scroll effect
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int noitiCount = 0;
                                  noitiCount < 10;
                                  noitiCount++) 
                                Dismissible( // Wrap in Dismissible for swipe actions
                                  // Unique key required for Dismissible widget to track items
                                  // and handle animations/state correctly during dismissal
                                  key: Key('notification_$noitiCount'),
                                  direction: DismissDirection.horizontal,
                                  background: Container( // Left swipe background
                                    color: Colors.transparent,
                                    alignment: Alignment.centerLeft,
                                    // padding: EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        Icon(Icons.delete, color: Colors.red),
                                      ],
                                    ),
                                  ),
                                  
                                  onDismissed: (direction) {
                                    // // Handle swipe actions
                                    // if (direction == DismissDirection.startToEnd) {
                                    //   // Handle left swipe
                                    // } else {
                                    //   // Handle right swipe
                                    // }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: TicketCard(
                                        stadiumName: "Al Ahly Stadium",
                                        price: "200",
                                        date: "2024-01-20", 
                                        time: "7:00 PM",
                                        isEnd: false,
                                        daysBefore: "2 days ago"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            title: Add_AppName(
              align: TextAlign.center,
              font_size: 24.0,
              color: Colors.black,
            )),

        // Bottom navigation bar
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: Stack(
          children: [
            backgroundImage_balls,
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 55),

                  // Search bar
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

                  SizedBox(height: 40.0),
                  // Filter bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Filter icon
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

                      // City filter
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            BottomPicker(
                              items: egyptGovernoratesWidgets,
                              height: 600.0,
                              titlePadding:
                                  EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                              buttonContent: Icon(Icons.navigate_next_rounded,
                                  color: Colors.white, size: 22.0),
                              buttonPadding: 10.0,
                              buttonStyle: BoxDecoration(
                                gradient: greenGradientColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              pickerTextStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              pickerTitle: Text('Select Governorate',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0)),
                              pickerDescription: Text(
                                  'Choose the governorate where the stadium is located',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400)),
                              onSubmit: (selectedIndex) {
                                String governorate =
                                    egyptGovernorates[selectedIndex];
                                setState(() {
                                  filterLocation_city = governorate;
                                });

                                Future.delayed(Duration(milliseconds: 10), () {
                                  // Show place picker after governorate selection
                                  List<Widget> placeWidgets =
                                      egyptGovernoratesAndCenters[
                                              filterLocation_city]!
                                          .map((place) => Center(
                                                child: Text(
                                                  place,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ))
                                          .toList();

                                  BottomPicker(
                                    items: placeWidgets,
                                    height: 600.0,
                                    titlePadding: EdgeInsets.fromLTRB(
                                        0.0, 20.0, 0.0, 0.0),
                                    buttonContent: Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.white,
                                        size: 22.0),
                                    buttonPadding: 10.0,
                                    buttonStyle: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    pickerTextStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                    pickerTitle: Text('Select Place',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24.0)),
                                    pickerDescription: Text(
                                        'Choose the place where the stadium is located',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400)),
                                    onSubmit: (selectedPlaceIndex) {
                                      String place =
                                          egyptGovernoratesAndCenters[
                                                  filterLocation_city]![
                                              selectedPlaceIndex];
                                      setState(() {
                                        filterLocation_place = place;
                                        filterLocation_location =
                                            '$filterLocation_city - $place';
                                        isFilterLocationTurnOn = true;
                                      });
                                    },
                                  ).show(context);
                                });
                              },
                            ).show(context);
                          },
                          child: isFilterLocationTurnOn
                              ? Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: mainColor, width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              filterLocation_location,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  filterLocation_city = '';
                                                  filterLocation_place = '';
                                                  filterLocation_location = '';
                                                  isFilterLocationTurnOn =
                                                      false;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  size: 12.0,
                                                ))
                                          ],
                                        ),
                                      )))
                              : Container(
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
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
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
                      ),

                      // Price filter
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              priceCount++;
                              setState(() {});
                              if (priceCount == 1) {
                                filterLeastPrice = false;
                                filterTopPrice = true;
                                isFilterPriceTurnOn = true;
                              } else if (priceCount == 2) {
                                filterTopPrice = false;
                                filterLeastPrice = true;
                                isFilterPriceTurnOn = true;
                              } else {
                                isFilterPriceTurnOn = false;
                                priceCount = 0;
                              }
                            },
                            child: isFilterPriceTurnOn
                                ? Container(
                                    margin: EdgeInsets.only(right: 14.0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                        gradient: greenGradientColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: mainColor, width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  59, 0, 0, 0),
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0),
                                        ]),
                                    child: Center(
                                      child: filterTopPrice
                                          ? Icon(
                                              Icons
                                                  .keyboard_double_arrow_up_rounded,
                                              color: Colors.white,
                                              size: 20.0)
                                          : Icon(
                                              Icons
                                                  .keyboard_double_arrow_down_rounded,
                                              color: Colors.white,
                                              size: 20.0),
                                    ))
                                : Container(
                                    margin: EdgeInsets.only(right: 14.0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: mainColor, width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  59, 0, 0, 0),
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0),
                                        ]),
                                    child: Image.asset(
                                        'assets/home_loves_tickets_top/imgs/price_Vector.png')),
                          )),

                      // Rating filter
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            ratingCount++;
                            setState(() {});
                            if (ratingCount == 1) {
                              filterLeastRating = false;
                              filterTopRating = true;
                              isFilterRatingTurnOn = true;
                            } else if (ratingCount == 2) {
                              filterTopRating = false;
                              filterLeastRating = true;
                              isFilterRatingTurnOn = true;
                            } else {
                              isFilterRatingTurnOn = false;
                              ratingCount = 0;
                            }
                          },
                          child: isFilterRatingTurnOn
                              ? Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: mainColor, width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: Center(
                                    child: filterTopRating
                                        ? Icon(
                                            Icons
                                                .keyboard_double_arrow_up_rounded,
                                            color: Colors.white,
                                            size: 20.0)
                                        : Icon(
                                            Icons
                                                .keyboard_double_arrow_down_rounded,
                                            color: Colors.white,
                                            size: 20.0),
                                  ))
                              : Container(
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
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: Image.asset(
                                      'assets/home_loves_tickets_top/imgs/rating_Vector.png')),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 70.0),

                  // Stadium list
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stadiums')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Image.asset('assets/loading.gif'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return _buildEmptyMessage();
                      }

                      List<DocumentSnapshot> stadiums = snapshot.data!.docs;

                      // Apply search filter
                      if (searchQuery.isNotEmpty) {
                        stadiums = stadiums
                            .where((s) => s['name']
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply location filter
                      if (isFilterLocationTurnOn) {
                        stadiums = stadiums
                            .where((s) => s['location']
                                .toLowerCase()
                                .startsWith(
                                    filterLocation_location.toLowerCase()))
                            .toList();
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply price filter
                      if (isFilterPriceTurnOn) {
                        stadiums = List.from(stadiums);
                        if (filterTopPrice) {
                          stadiums.sort((a, b) =>
                              (b['price'] as num).compareTo(a['price'] as num));
                        } else if (filterLeastPrice) {
                          stadiums.sort((a, b) =>
                              (a['price'] as num).compareTo(b['price'] as num));
                        }
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply rating filter
                      if (isFilterRatingTurnOn) {
                        stadiums = List.from(stadiums);
                        if (filterTopPrice) {
                          stadiums.sort((a, b) => (b['rating'] as num)
                              .compareTo(a['rating'] as num));
                        } else if (filterLeastPrice) {
                          stadiums.sort((a, b) => (a['rating'] as num)
                              .compareTo(b['rating'] as num));
                        }
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // No filters applied
                      return _buildStadiumList(stadiums);
                    },
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
