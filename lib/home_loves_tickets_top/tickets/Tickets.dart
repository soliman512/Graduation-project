import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Tickets extends StatelessWidget {
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
                TextSpan(text: "Book"),
                TextSpan(
                    text: "ing", style: TextStyle(color: Color(0xff00B92E))),
                TextSpan(text: " Status"),
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
                Navigator.pushNamed(context, '/favourites');
              },
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/favourite.png"),
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
                Navigator.pushNamed(context, '/');
              },
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/ticket_active.png"),
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
      ],)
    ));
  }
}
