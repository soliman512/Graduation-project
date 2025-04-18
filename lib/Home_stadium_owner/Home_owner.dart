import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdwon_addNewStadium.dart';

/// Main widget for the stadium owner's home page
class Home_Owner extends StatefulWidget {
  @override
  State<Home_Owner> createState() => _HomeState();
}

/// Custom widget to display stadium information in a card format
class StadiumCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final int rating;
  final List<File> selectedImages;

  const StadiumCard({
    Key? key,
    required this.title,
    required this.location,
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
              // Stadium image
              _buildStadiumImage(),
              SizedBox(height: 12.0),
              // Stadium name and price
              _buildTitleAndPrice(),
              // Location and rating
              _buildLocationAndRating(),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the stadium image section
  Widget _buildStadiumImage() {
    return Container(
      width: double.infinity,
      height: 130.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Image.asset(
          selectedImages[0].path,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the title and price section
  Widget _buildTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Stadium name
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
        // Price
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
    );
  }

  /// Builds the location and rating section
  Widget _buildLocationAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Location
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 13, color: Colors.grey),
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
        // Rating
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            children: [
              Text("${rating}.0",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              for (int i = 0; i < rating; i++)
                Icon(Icons.star,
                    color: const Color.fromARGB(255, 255, 217, 0), size: 15),
              SizedBox(width: 1),
            ],
          ),
        ),
      ],
    );
  }
}

/// State class for the Home_Owner widget
class _HomeState extends State<Home_Owner> {
  // Controllers and state variables
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingActionButton(),
        body: _buildBody(),
      ),
    );
  }

  /// Builds the app bar with menu and notification icons
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 80.0,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Color(0xFFFFFFFF),
      leading: _buildMenuButton(),
      actions: [_buildNotificationButton()],
      title: _buildAppBarTitle(),
      centerTitle: true,
    );
  }

  /// Builds the menu button
  Widget _buildMenuButton() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            setState(() {
              Scaffold.of(context).openDrawer();
            });
          },
          icon: Image.asset("assets/home_loves_tickets_top/imgs/bars.png",
              width: 22.0),
        );
      }),
    );
  }

  /// Builds the notification button
  Widget _buildNotificationButton() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Welcome');
        },
        icon: Image.asset(
          "assets/home_loves_tickets_top/imgs/notifications.png",
          width: 22.0,
        ),
      ),
    );
  }

  /// Builds the app bar title
  Widget _buildAppBarTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            fontFamily: "eras-itc-bold",
            fontWeight: FontWeight.w900,
            color: Color(0xff000000),
            fontSize: 22.0),
        children: [
          TextSpan(text: "V"),
          TextSpan(text: "á", style: TextStyle(color: mainColor)),
          TextSpan(text: "monos"),
        ],
      ),
    );
  }

  /// Builds the floating action button with new stadium option
  Widget _buildFloatingActionButton() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      direction: Axis.vertical,
      children: [
        _buildStatueButton(),
        SizedBox(height: 8.0),
        _buildNewStadiumButton(),
      ],
    );
  }

  /// Builds the statue button
  Widget _buildStatueButton() {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection('stadiums')
            .get()
            .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
            setState(() {});
          }
        });
        setState(() {});
      },
      child: Container(
        width: 50.0,
        child: Image.asset("assets/home_loves_tickets_top/imgs/Group 204.png"),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Builds the new stadium button
  Widget _buildNewStadiumButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                AddNewStadium(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              final tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Container(
        width: 222.0,
        height: 66.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: greenGradientColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png",
              width: 44.00,
            ),
            Text(
              "New Stadium",
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18,
                  fontFamily: "eras-itc-demi"),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    return Stack(
      children: [
        backgroundImage_balls,
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55),
              _buildSearchBar(),
              SizedBox(height: 40.0),
              _buildStadiumList(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the search bar
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: 48.0,
            height: 48.0,
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
                'assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png'),
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
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                hintText: "What the stadiums you looking for ? ...",
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
                      color: const Color.fromARGB(255, 19, 19, 19),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the list of stadiums
  Widget _buildStadiumList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stadiums').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/home_loves_tickets_top/imgs/noStadiums.png',
              fit: BoxFit.contain,
            ),
          );
        }

        List<DocumentSnapshot> stadiums = snapshot.data!.docs;
        if (searchQuery.isNotEmpty) {
          stadiums = stadiums
              .where((stadium) => stadium['name']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          if (stadiums.isEmpty) {
            return Center(child: Text("No stadiums found"));
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stadiums.length,
          itemBuilder: (context, index) {
            DocumentSnapshot stadium = stadiums[index];
            return GestureDetector(
              onTap: () {},
              child: StadiumCard(
                title: stadium['name'],
                location: stadium['location'],
                price: stadium['price'].toString(),
                rating: 5,
                selectedImages: [
                  File('assets/cards_home_player/imgs/test.jpg')
                ],
              ),
            );
          },
        );
      },
    );
  }
}
