import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class StadiumCard extends StatelessWidget {
  final String title;
  final String location;
  // final String imageUrl;
  final String price;
  final int rating;
  final List<File> selectedImages;

  StadiumCard({
    Key? key,
    required this.title,
    required this.location,
    // required this.imageUrl,
    required this.price,
    required this.rating,
    required this.selectedImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: const Color.fromARGB(255, 255, 255, 255), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 130.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    selectedImages[0].path,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              // name & price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name of stadium
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 20.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "eras-itc-bold",
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  //price
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Text(
                      "${price}.00 .LE",
                      style: TextStyle(
                        fontSize: 13,
                        color: mainColor,
                        fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // location & rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //location
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
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

                  //rating
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(children: [
                      Text(
                        "${rating}.0",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      for (int i = 0; i < rating; i++)
                        Icon(Icons.star,
                            color: const Color.fromARGB(255, 255, 217, 0),
                            size: 15),
                      SizedBox(width: 1),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List cities = [
    'Assiut',
  ];

  List places = [
    'new assiut city',
    'Abu Tig',
    'Manfalut',
    'Al-Qusiya',
    'El-Ghanayem',
    'Sidfa',
  ];

  List prices = [
    'Top',
    'Down',
  ];

  double heightOfListfilter_city = 0.0;
  double heightOfListfilter_place = 0.0;
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
            //down buttons
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
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: const Color.fromARGB(59, 0, 0, 0),
                                //       offset: Offset(0.0, 0.0),
                                //       blurRadius: 2.0),
                                // ]
                              ),
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
                                      "What the stadiums you looking for ? ...",
                                  hintStyle: TextStyle(
                                    color: Color(0x73000000),
                                    fontSize: 12.0,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
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
                      Container(
                        width: double.infinity,
                        // margin: EdgeInsets.symmetric(horizontal: 16.0),
                        margin: EdgeInsets.only(bottom: 60.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            for (int stadiumsShownOnHome = 0;
                                stadiumsShownOnHome < stadiums.length;
                                stadiumsShownOnHome++)
                              stadiums[stadiumsShownOnHome]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
