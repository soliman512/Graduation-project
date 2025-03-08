import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';

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
              title: RichText(
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
                  ],
                ),
              ),
            ),
            //floating action button for home, tickets, and favourites
            //down buttons
            floatingActionButton: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              height: 50.0,
              decoration: BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.circular(10.0)),
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
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    icon: Image.asset(
                        "assets/home_loves_tickets_top/imgs/home_active.png"),
                    iconSize: 40.0,
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
//search bar
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
                                  blurRadius: 4.0)
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
                                    'assets/home_loves_tickets_top/imgs/Vector.png'),
                              ),
                              suffixIcon: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                          CircleBorder()),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              mainColor),
                                      padding: WidgetStateProperty.all(
                                          EdgeInsets.zero)),
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/home_loves_tickets_top/imgs/icon-park-outline_search.png',
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
//filter
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        // padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 10.0,
                          spacing: 10.0,
                          children: [
//city fliter
                            Column(
                              children: [
                                Container(
                                  width: 155.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (heightOfListfilter_city == 0.0) {
                                          heightOfListfilter_city = 150.0;
                                        } else {
                                          heightOfListfilter_city = 0.0;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      elevation:
                                          WidgetStateProperty.all(0.0),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.transparent),
                                      foregroundColor:
                                          WidgetStateProperty.all(
                                              mainColor),
                                      side: WidgetStateProperty.all(
                                        BorderSide(
                                            color: mainColor,
                                            width: 1,
                                            style: BorderStyle.solid),
                                      ),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0))),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                            child: Image.asset(
                                          'assets/home_loves_tickets_top/imgs/city_Vector.png',
                                          width: 16.0,
                                        )),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            'City',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 12.0,
                                                fontFamily: 'eras-itc-bold'),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  width: 155.0,
                                  height: heightOfListfilter_city,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: mainColor, width: 2.0),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var i = 0;
                                            i < cities.length;
                                            i++)
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  cities[i],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
//place filter
                            Column(
                              children: [
                                Container(
                                  width: 155.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (heightOfListfilter_place == 0.0) {
                                          heightOfListfilter_place = 150.0;
                                        } else {
                                          heightOfListfilter_place = 0.0;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      elevation:
                                          WidgetStateProperty.all(0.0),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.transparent),
                                      foregroundColor:
                                          WidgetStateProperty.all(
                                              mainColor),
                                      side: WidgetStateProperty.all(
                                        BorderSide(
                                            color: mainColor,
                                            width: 1,
                                            style: BorderStyle.solid),
                                      ),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0))),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                            child: Image.asset(
                                          'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
                                          width: 16.0,
                                        )),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            'Place',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 12.0,
                                                fontFamily: 'eras-itc-bold'),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  width: 155.0,
                                  height: heightOfListfilter_place,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: mainColor, width: 2.0),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var i = 0;
                                            i < places.length;
                                            i++)
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  places[i],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
// //price filter
                            Container(
                              width: 155.0,
                              height: 40.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  elevation:
                                      WidgetStateProperty.all(0.0),
                                  backgroundColor:
                                      WidgetStateProperty.all(
                                          Colors.transparent),
                                  foregroundColor:
                                      WidgetStateProperty.all(
                                          mainColor),
                                  side: WidgetStateProperty.all(
                                    BorderSide(
                                        color: mainColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10.0))),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Image.asset(
                                      'assets/home_loves_tickets_top/imgs/price_Vector.png',
                                      width: 16.0,
                                    )),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Price',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontSize: 12.0,
                                            fontFamily: 'eras-itc-bold'),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
// //rating filter
                            Container(
                              width: 155.0,
                              height: 40.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  elevation:
                                      WidgetStateProperty.all(0.0),
                                  backgroundColor:
                                      WidgetStateProperty.all(
                                          Colors.transparent),
                                  foregroundColor:
                                      WidgetStateProperty.all(
                                          mainColor),
                                  side: WidgetStateProperty.all(
                                    BorderSide(
                                        color: mainColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10.0))),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                        child: Image.asset(
                                      'assets/home_loves_tickets_top/imgs/rating_Vector.png',
                                      width: 16.0,
                                    )),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Rating',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontSize: 12.0,
                                            fontFamily: 'eras-itc-bold'),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            buildCard(
                              context: context,
                              title: "Barca",
                              location: "Assiut_Al-Azhar",
                              imageUrl:
                                  "assets/cards_home_player/imgs/pngtree-the-camp-nou-stadium-in-barcelona-spain-sport-nou-angle-photo-image_4879020.jpg",
                              price: "250.00 LE",
                            ),
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
                            buildCard(
                                context: context,
                                title: "Anfield",
                                location: "Liverpool_England",
                                imageUrl:
                                    "assets/cards_home_player/imgs/Liverpool-Banner-1.jpg",
                                price: "100.00 .LE"),
                            buildCard(
                                context: context,
                                title: "Emirates",
                                location: "London_England",
                                imageUrl:
                                    "assets/cards_home_player/imgs/photo-1686053246042-43acf5121d86.jpg",
                                price: "180.00 .LE"),
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
