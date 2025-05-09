import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';

Widget buildCard({
  required String title,
  required String location,
  required String imageUrl,
  required String price,
}) {
  return Center(
    child: Container(
      width: 360.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: mainColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative ball image positioned at the top-right corner
          Positioned(
            top: -26,
            right: -26,
            child: Image.asset(
              "assets/home_loves_tickets_top/imgs/ball.png",
              width: 100.0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container for the card
              Container(
                width: 150,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title of the card
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'eras-itc-bold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Location row with icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Rating and price row
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Star rating
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    Icons.star,
                                    color: Color(0xffFFCC00),
                                    size: 10,
                                  ),
                                SizedBox(width: 2),
                                Text(
                                  "5",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Price text
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                price,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff00B92E),
                                  fontFamily: 'eras-itc-bold',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Handle remove action
                              },
                              child: Container(
                                // width: 100,
                                height: 24,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: Colors.red, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 8,
                                      fontFamily: 'eras-itc-bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Handle book action
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: greenGradientColor,
                                ),
                                // width: 100,
                                height: 24,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        Colors.transparent),
                                    foregroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Book",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'eras-itc-bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Widget _buildRemoveButton() {
//   return Container(
//     width: 100,
//     height: 24,
//     child: OutlinedButton(
//       onPressed: () {},
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(color: Colors.red, width: 2),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       child: Text(
//         "Remove",
//         style: TextStyle(
//           color: Colors.red,
//           fontSize: 8,
//           fontFamily: 'eras-itc-bold',
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildBookButton() {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       gradient: LinearGradient(colors: [
//         Color(0xff005706),
//         Color(0xff007211),
//         Color(0xff00911E),
//         Color(0xff00B92E),
//       ]),
//     ),
//     width: 100,
//     height: 24,
//     child: ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Colors.transparent),
//         foregroundColor: MaterialStateProperty.all(Colors.white),
//       ),
//       onPressed: () {},
//       child: Text(
//         "Book",
//         style: TextStyle(
//           fontSize: 8,
//           fontFamily: 'eras-itc-bold',
//         ),
//       ),
//     ),
//   );
// }

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
        notificationState: () {},
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
        height: 60.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/home_loves_tickets_top/imgs/favourite_active.png",
              width: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.white12,
              radius: 6.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Image.asset("assets/home_loves_tickets_top/imgs/home.png"),
              iconSize: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.white12,
              radius: 6.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tickets');
              },
              icon:
                  Image.asset("assets/home_loves_tickets_top/imgs/ticket.png"),
              iconSize: 40.0,
            ),
          ],
        ),

        // margin: EdgeInsets.only(left: 16),
        // alignment: Alignment.center,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          backgroundImage_balls,
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                buildCard(
                  title: "Wembley",
                  location: "New Assiut_suzan",
                  imageUrl: "assets/cards_home_player/imgs/test.jpg",
                  price: "EGP 250.00",
                ),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
