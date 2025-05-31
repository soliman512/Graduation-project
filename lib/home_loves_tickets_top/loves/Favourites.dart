import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';

Widget buildCard({
  required BuildContext context,
  required String title,
  required String location,
  required String imageUrl,
  required String price,
  required VoidCallback onRemove,
  Color borderColor =
      const Color(0xff00B92E), // Default to green if not provided
}) {
  final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;

  return Center(
    child: Container(
      width: 360.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
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
                  child: imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
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
                                  onPressed: onRemove,
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: Colors.red, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    isArabic ? "إزالة" : "Remove",
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
                                    isArabic ? "حجز" : "Book",
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

Widget _buildEmptyMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(message, style: TextStyle(color: Colors.grey, fontSize: 16)),
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
=======
import '../../constants/constants.dart';
import '../../reusable_widgets//reusable_widgets.dart';
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

class Favourites extends StatefulWidget {
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
<<<<<<< HEAD
  void _removeFromFavorites(String stadiumId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Get stadium name before deleting
    final stadiumDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(stadiumId)
        .get();

    String stadiumName = stadiumId;
    if (stadiumDoc.exists && stadiumDoc.data()!.containsKey('title')) {
      stadiumName = stadiumDoc.data()!['title'] as String;
    }

    // Delete from favorites
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(stadiumId)
        .delete();

    // Show snackbar
    showSnackBar(
      context,
      Provider.of<LanguageProvider>(context, listen: false).isArabic
          ? "\u062a\u0645 \u0625\u0632\u0627\u0644\u0629 $stadiumName \u0645\u0646 \u0627\u0644\u0645\u0641\u0636\u0644\u0629"
          : "$stadiumName removed from favorites",
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
=======
  @override
  Widget build(BuildContext context) {
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      extendBodyBehindAppBar: false,
      appBar: Create_AppBar(
<<<<<<< HEAD
        notificationState: () {},
=======
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
<<<<<<< HEAD
                  fontFamily: isArabic ? "Cairo" : "eras-itc-bold",
=======
                  fontFamily: "eras-itc-bold",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                  fontWeight: FontWeight.w900,
                  color: Color(0xff000000),
                  fontSize: 24.0),
              children: [
<<<<<<< HEAD
                TextSpan(text: isArabic ? "الم" : "Fa"),
                TextSpan(
                    text: isArabic ? "فض" : "v",
                    style: TextStyle(color: Color(0xff00B92E))),
                TextSpan(text: isArabic ? "لات" : "ourites"),
=======
                TextSpan(text: "Fa"),
                TextSpan(text: "v", style: TextStyle(color: Color(0xff00B92E))),
                TextSpan(text: "ourites"),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
              ]),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
<<<<<<< HEAD
        height: 60.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(30.0)),
=======
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Color(0xff000000),
            borderRadius: BorderRadius.circular(10.0)),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
<<<<<<< HEAD
            CircleAvatar(
              backgroundColor: Colors.white12,
              radius: 6.0,
            ),
=======
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
<<<<<<< HEAD
              icon: Image.asset("assets/home_loves_tickets_top/imgs/home.png"),
              iconSize: 40.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.white12,
              radius: 6.0,
            ),
=======
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/home.png"),
              iconSize: 40.0,
            ),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tickets');
              },
<<<<<<< HEAD
              icon:
                  Image.asset("assets/home_loves_tickets_top/imgs/ticket.png"),
=======
              icon: Image.asset(
                  "assets/home_loves_tickets_top/imgs/ticket.png"),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
              iconSize: 40.0,
            ),
          ],
        ),
<<<<<<< HEAD
        alignment: Alignment.center,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Builder(
        builder: (context) {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            return Center(
                child: Text(isArabic ? "الرجاء تسجيل الدخول" : "Please login"));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('favorites')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return _buildEmptyMessage(
                    isArabic ? "لا يوجد مفضلة" : 'No favorites yet');
              }

              final favorites = snapshot.data!.docs;

              return ListView.separated(
                itemCount: favorites.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return buildCard(
                    context: context,
                    title: favorite['title'] ?? '',
                    location: favorite['location'] ?? '',
                    imageUrl: favorite['imagePath'] ?? 'assets/default.png',
                    price: "${favorite['price'] ?? ''}.00 LE",
                    borderColor: mainColor, // Pass the mainColor from context
                    onRemove: () {
                      _removeFromFavorites(favorite.id);
                    },
                  );
                },
              );
            },
          );
        },
      ),
=======

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
    
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
    ));
  }
}
