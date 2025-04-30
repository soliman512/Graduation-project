import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadium_information_player_pg.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double heightOfListfilter_city = 0.0;
  double heightOfListfilter_place = 0.0;
  String searchQuery = '';

  //visibilty for filter by location
  // visibilities
  bool locationPopup = false;
  double locationPopupHeight = 0.0;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;
  //filter by location
  String filterLocation_city = '';
  String filterLocation_place = '';
  String filterLocation_location = '';
  bool isFilterLocationTurnOn = false;
  //filter by price
  bool isFilterPriceTurnOn = false;
  bool filterTopPrice = false;
  bool filterLeastPrice = false;
  int priceCount = 0;
  //filter by rating
  bool isFilterRatingTurnOn = false;
  bool filterTopRating = false;
  bool filterLeastRating = false;
  int ratingCount = 0;

  TextEditingController searchController = TextEditingController();

//database
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            extendBodyBehindAppBar: false,
            drawer: Create_Drawer(),
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
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  locationPopup = true;
                                  locationPopupHeight = 360.0;
                                });
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
                                                      filterLocation_location =
                                                          '';
                                                      isFilterLocationTurnOn =
                                                          false;
                                                      setState(() {});
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
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
                          // price
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
                          //rating
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                ratingCount++;
                                setState(() {});
                                //top rating
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
                                          'assets/home_loves_tickets_top/imgs/rating_Vector.png')),
                            ),
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
                            return _buildEmptyMessage();
                          }

                          List<DocumentSnapshot> stadiums = snapshot.data!.docs;

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

                          if (isFilterLocationTurnOn) {
                            stadiums = stadiums
                                .where((s) => s['location']
                                    .contains(filterLocation_location))
                                .toList();
                            return stadiums.isEmpty
                                ? _buildEmptyMessage()
                                : _buildStadiumList(stadiums);
                          }

                          if (isFilterPriceTurnOn) {
                            stadiums = List.from(stadiums);
                            if (filterTopPrice) {
                              stadiums.sort((a, b) => (b['price'] as num)
                                  .compareTo(a['price'] as num));
                            } else if (filterLeastPrice) {
                              stadiums.sort((a, b) => (a['price'] as num)
                                  .compareTo(b['price'] as num));
                            }
                            return stadiums.isEmpty
                                ? _buildEmptyMessage()
                                : _buildStadiumList(stadiums);
                          }

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

                          // Default
                          return _buildStadiumList(stadiums);
                        },
                      ),
                      SizedBox(height: 80.0),
                    ],
                  ),
                ),

                //location popup
                Stack(
                  children: [
                    Visibility(
                      visible: locationPopup,
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    Center(
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: double.infinity,
                          height: locationPopupHeight,
                          margin: EdgeInsets.symmetric(horizontal: 32.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.75),
                                blurRadius: 100.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
//close button
                              Positioned(
                                top: 10.0,
                                right: 10.0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      locationPopup = false;
                                      locationPopupHeight = 0.0;
                                    });
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ),
//content and done button
                              Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //city
                                      ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x7C000000),
                                                blurRadius: 10.0,
                                              ),
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/home_loves_tickets_top/imgs/city_Vector.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                          ),
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x7C000000),
                                                blurRadius: 10.0,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              onChanged: (String? cityValue) {
                                                setState(() {
                                                  visibleOfPlace = true;
                                                  filterLocation_city =
                                                      cityValue ?? 'notSet';
                                                  citySelected = cityValue;
                                                  placesOfCityOnSelected = null;
                                                  placeSelected = null;
                                                });
                                                placesOfCityOnSelected =
                                                    egyptGovernoratesAndCenters[
                                                        cityValue];
                                              },
                                              items:
                                                  egyptGovernorates.map((city) {
                                                return DropdownMenuItem<String>(
                                                  value: city,
                                                  child: Text(city),
                                                );
                                              }).toList(),
                                              menuMaxHeight: 300.0,
                                              value: citySelected,
                                              hint: Text('select City'),
                                              icon: Icon(
                                                Icons
                                                    .arrow_drop_down_circle_outlined,
                                                size: 30.0,
                                                color: mainColor,
                                              ),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                              alignment: Alignment.center,
                                              underline: null,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //place
                                      Visibility(
                                        visible: visibleOfPlace,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: ListTile(
                                            leading: Container(
                                              padding: EdgeInsets.all(8.0),
                                              width: 40.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x7C000000),
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            title: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x7C000000),
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.0,
                                                ),
                                              ),
                                              child: Center(
                                                child: DropdownButton<String>(
                                                  items: placesOfCityOnSelected
                                                      ?.map((
                                                    String place,
                                                  ) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      child: Text(place),
                                                      value: place,
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? placeValue) {
                                                    setState(() {
                                                      visibleOfButton = true;
                                                      placeSelected =
                                                          placeValue;
                                                      filterLocation_place =
                                                          placeValue ??
                                                              'not set yet';
                                                    });
                                                  },
                                                  menuMaxHeight: 300.0,
                                                  value: placeSelected,
                                                  hint: Text('select place'),
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_drop_down_circle_outlined,
                                                    size: 30.0,
                                                    color: mainColor,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                  ),
                                                  alignment: Alignment.center,
                                                  underline: null,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 20.0),
                                      //button
                                      Visibility(
                                        visible: visibleOfButton,
                                        child: SizedBox(
                                          height: 50.0,
                                          width: 200.0,
                                          child: Create_GradiantGreenButton(
                                            content: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                            onButtonPressed: () {
                                              isFilterLocationTurnOn = true;
                                              filterLocation_location =
                                                  '$filterLocation_city-$filterLocation_place';
                                              setState(() {
                                                locationPopupHeight = 0.0;
                                                locationPopup = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            )));
  }
}
