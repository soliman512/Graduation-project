import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadiumInfo_stadium%20owner.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdwon_addNewStadium.dart';

class Home_Owner extends StatefulWidget {
  const Home_Owner({Key? key}) : super(key: key);

  @override
  State<Home_Owner> createState() => _HomeState();
}

class _HomeState extends State<Home_Owner> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Navigates to the stadium details page, passing all required stadium info and IDs.
  void _navigateToStadiumDetails(DocumentSnapshot stadium) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Stadium_info_stadiumOwner(
          stadiumName: stadium['name'],
          stadiumPrice: stadium['price'].toString(),
          stadiumLocation: stadium['location'],
          isWaterAvailbale: stadium['hasWater'],
          isTrackAvailable: stadium['hasTrack'],
          isGrassNormal: stadium['isNaturalGrass'],
          capacity: stadium['capacity'].toString(),
          description: stadium['description'],
          // userId: stadium['userID'],
          // docId: stadium.id,
        ),
      ),
    );
  }

  /// Navigates to the add new stadium page with a custom transition.
  void _navigateToAddNewStadium() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddNewStadium(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 80.0,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Image.asset(
              "assets/home_loves_tickets_top/imgs/bars.png",
              width: 22.0,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/Welcome'),
            icon: Image.asset(
              "assets/home_loves_tickets_top/imgs/notifications.png",
              width: 22.0,
            ),
          ),
        )
      ],
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontFamily: "eras-itc-bold",
            fontWeight: FontWeight.w900,
            color: Color(0xff000000),
            fontSize: 22.0,
          ),
          children: [
            const TextSpan(text: "V"),
            TextSpan(text: "á", style: TextStyle(color: mainColor)),
            const TextSpan(text: "monos"),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  /// Builds the search bar widget for filtering stadiums by name.
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: 48.0,
            height: 48.0,
            padding: const EdgeInsets.all(8.0),
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
            margin: const EdgeInsets.only(right: 14.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              style: const TextStyle(
                fontSize: 18.0,
                color: Color(0xff000000),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "What the stadiums you looking for ? ...",
                hintStyle: const TextStyle(
                  color: Color(0x73000000),
                  fontSize: 12.0,
                ),
                suffixIcon: Visibility(
                  visible: _searchQuery.isNotEmpty,
                  child: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 19, 19, 19),
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

  /// Filters and returns only the stadiums owned by the current user.
  List<DocumentSnapshot> _filterUserStadiums(List<DocumentSnapshot> stadiums) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return stadiums
        .where((stadium) => stadium['userID'] == currentUserId)
        .toList();


  }

  /// Builds the stadium list view, filtering by search and user ownership.
  Widget _buildStadiumList(QuerySnapshot snapshot) {
    // Filter stadiums by search query if present
    List<DocumentSnapshot> filtered = snapshot.docs;
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((stadium) => stadium['name']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    // Only show stadiums owned by the current user
    final userStadiums = _filterUserStadiums(filtered);
    if (userStadiums.isEmpty) {
      return Center(
        child: Image.asset('assets/cards_home_player/imgs/noStadium.png'),
      );
    }
    return _buildStadiumListView(userStadiums);
  }

  /// Builds the stadium list view for the given stadiums.
  /// Ensures that the image list is not accessed out of range to avoid RangeError.
  Widget _buildStadiumListView(List<DocumentSnapshot> stadiums) {
    final userStadiums = _filterUserStadiums(stadiums);
    if (userStadiums.isEmpty) {
      return Center(
        child: Image.asset('assets/cards_home_player/imgs/noStadium.png'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userStadiums.length,
      itemBuilder: (context, index) {
        final stadium = userStadiums[index];
        // Only use one image for StadiumCard to avoid RangeError.
        return StadiumCard(
          onTap: () => _navigateToStadiumDetails(stadium),
          title: stadium['name'],
          location: stadium['location'],
          price: stadium['price'].toString(),
          rating: 5,
          selectedImages: [File('assets/cards_home_player/imgs/test.jpg')],
        );
      },
    );
  }

  /// Builds the floating action button for adding a new stadium and deleting all stadiums.
  Widget _buildFloatingActionButton() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      direction: Axis.vertical,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Delete All Stadiums'),
                  content: Text(
                      'Are you sure you want to delete all stadiums? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final stadiumsCollection =
                              FirebaseFirestore.instance.collection('stadiums');
                          final snapshot = await stadiumsCollection.get();
                          for (var doc in snapshot.docs) {
                            await doc.reference.delete();
                          }
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('All stadiums deleted successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error deleting stadiums: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text('Delete All',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 50.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child:
                Image.asset("assets/home_loves_tickets_top/imgs/Group 204.png"),
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _navigateToAddNewStadium,
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
                const Text(
                  "New Stadium",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontFamily: "eras-itc-demi",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        drawer: Create_Drawer(),
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingActionButton(),
        body: Stack(
          children: [
            backgroundImage_balls,
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  _buildSearchBar(),
                  const SizedBox(height: 40.0),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('stadiums')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/home_loves_tickets_top/imgs/noStadiums.png',
                          ),
                        );
                      }
                      return _buildStadiumList(snapshot.data!);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
