import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadium_information_player_pg.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:graduation_project_main/widgets/ticket_card.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        final stadiumId = stadiums[index].id;
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
                          stadiumID: stadiumId,
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
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('players_notifications');
  daysBefore(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '';
    }
  }

  List<Map<String, dynamic>> notifications = [
    {
      'stadiumName': 'Al Ahly Stadium',
      'price': 500,
      'isEnd': false,
      'date': DateTime.now(), // Current notification
    },
    {
      'stadiumName': 'Cairo Stadium',
      'price': 600,
      'isEnd': true,
      'date': DateTime(2024, 1, 15, 14, 30), // Jan 15, 2024 2:30 PM
    },
    {
      'stadiumName': 'Alexandria Stadium',
      'price': 450,
      'isEnd': false,
      'date': DateTime(2024, 1, 10, 9, 15), // Jan 10, 2024 9:15 AM
    },
    {
      'stadiumName': 'Olympic Stadium',
      'price': 800,
      'isEnd': true,
      'date': DateTime(2024, 1, 5, 16, 45), // Jan 5, 2024 4:45 PM
    },
    {
      'stadiumName': 'Borg El Arab Stadium',
      'price': 700,
      'isEnd': false,
      'date': DateTime(2023, 12, 28, 11, 20), // Dec 28, 2023 11:20 AM
    },
  ];

  // Add notification data to Firestore collection
  Future<void> addNotificationsToFirestore() async {
    final CollectionReference notificationsCollection =
        FirebaseFirestore.instance.collection('players_notifications');

    for (var notification in notifications) {
      await notificationsCollection.add({
        'stadiumName': notification['stadiumName'],
        'price': notification['price'],
        'isEnd': notification['isEnd'],
        'date': notification['date'],
      });
    }
  }

  @override
  void initState() {
    super.initState();
    addNotificationsToFirestore();
    _showRatingPopupOnSecondOpen();
  }

  Future<void> _showRatingPopupOnSecondOpen() async {
    final prefs = await SharedPreferences.getInstance();
    int openCount = prefs.getInt('openCount') ?? 0;
    openCount++;
    await prefs.setInt('openCount', openCount);

    if (openCount == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showRatingPopup();
      });
    }
  }

  void _showRatingPopup() {
    showDialog(
      context: context,
      builder: (context) {
        double rating = 0; // قيمة التقييم الافتراضية
        return AlertDialog(
          title: Text("Rate the App"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please rate our app!"),
              SizedBox(height: 16),
              RatingBar.builder(
                minRating: 1,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
            ],
          ),
          actions: [
            // زر Cancel
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق النافذة بدون حفظ التقييم
              },
              child: Text("Cancel"),
            ),
            // زر Submit
            TextButton(
              onPressed: () async {
                if (rating == 0) {
                  showSnackBar(context, "Please select rate.");
                } else {
                  // تخزين التقييم في Firestore
                  await FirebaseFirestore.instance.collection('app_ratings').add({
                    'rating': rating,
                    'timestamp': FieldValue.serverTimestamp(),
                    'userId': FirebaseAuth.instance.currentUser?.uid,
                    'type': 'player',
                  });
                  Navigator.of(context).pop();
                  showSnackBar(context, "Thank you for your rating!");
                }
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: itemsCollection.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(
                                        color: Colors.white30),
                                    height: 100,
                                    width: 100.0,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text('No notifications',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 20.0),
                                      Icon(
                                        Icons.notifications_paused_rounded,
                                        color: Colors.white,
                                        size: 100.0,
                                      ),
                                    ]));
                              }
                              final documents = snapshot.data!.docs;

                              return ListView.builder(
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    final data = documents[index].data()
                                        as Map<String, dynamic>;
                                    final DateTime date =
                                        (data['date'] as Timestamp).toDate();
                                    final String dayName =
                                        DateFormat('EEEE').format(date);
                                    final TimeOfDay time =
                                        TimeOfDay.fromDateTime(
                                            (data['date'] as Timestamp)
                                                .toDate());
                                    return Dismissible(
                                      // Wrap in Dismissible for swipe actions
                                      key: Key(documents[index].id),
                                      background: Container(
                                        // Left swipe background
                                        color: Colors.transparent,
                                        alignment: Alignment.centerLeft,
                                        // padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.delete,
                                            color: Colors.red),
                                      ),
                                      secondaryBackground: Container(
                                        // Right swipe background
                                        color: Colors.transparent,
                                        alignment: Alignment.centerRight,
                                        // padding: EdgeInsets.only(left: 20),
                                        child: Icon(Icons.delete,
                                            color: Colors.red),
                                      ),
                                      onDismissed: (deleteNotification) {
                                        itemsCollection
                                            .doc(documents[index].id)
                                            .delete();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: TicketCard(
                                            stadiumName: data['stadiumName'],
                                            price: data['price'].toString(),
                                            date: date.toString() +
                                                ' - ' +
                                                dayName,
                                            time: time.format(context),
                                            isEnd: data['isEnd'],
                                            daysBefore: daysBefore(date)),
                                      ),
                                    );
                                  });
                            }),
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
