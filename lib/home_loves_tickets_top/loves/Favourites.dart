import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../reusable_widgets//reusable_widgets.dart';

class Favourites extends StatefulWidget {
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
                TextSpan(text: "Fa"),
                TextSpan(text: "v", style: TextStyle(color: Color(0xff00B92E))),
                TextSpan(text: "ourites"),
              ]),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/favourite_active.png"),
              iconSize: 40.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/home.png"),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: [
        backgroundImage_balls,
        SingleChildScrollView(
          child: Column(children: [],),
        )
      ],),
    
    ));
  }
}
