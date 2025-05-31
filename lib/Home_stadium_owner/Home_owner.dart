// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadiumInfo_stadiumOwner.dart';
import 'package:graduation_project_main/stdown_addNewStd/stdwon_addNewStadium.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Owner extends StatefulWidget {
  const Home_Owner({Key? key}) : super(key: key);

  @override
  State<Home_Owner> createState() => _HomeState();
}

class _HomeState extends State<Home_Owner> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _showRatingPopupOnSecondOpen();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showRatingPopupOnSecondOpen() async {
    final prefs = await SharedPreferences.getInstance();
    int openCount = prefs.getInt('openCount_owner') ?? 0;
    openCount++;
    await prefs.setInt('openCount_owner', openCount);

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
        double rating = 0;
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (rating == 0) {
                  showSnackBar(context, "Please select rate.");
                } else {
                  await FirebaseFirestore.instance
                      .collection('app_ratings')
                      .add({
                    'rating': rating,
                    'timestamp': FieldValue.serverTimestamp(),
                    'userId': FirebaseAuth.instance.currentUser?.uid,
                    'type': 'owner',
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
          stadiumID: stadium.id,
          imagesUrl: List<String>.from(stadium['images'] ?? []),
          workingDays: List<String>.from(stadium['workingDays'] ?? []),
          startTime: stadium['startTime'],
          endTime: stadium['endTime'],
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
    // ignore: unused_local_variable
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
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
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
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
                hintText: isArabic
                    ? "ما الذي تبحث عنه؟ ..."
                    : "What the stadiums you looking for ? ...",
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
        child: Image.asset('assets/home_loves_tickets_top/imgs/noStadiums.png'),
      );
    }
    return _buildStadiumListView(userStadiums);
  }

  /// Builds the stadium list view for the given stadiums.
  /// Ensures that the image list is not accessed out of range to avoid RangeError.
  Widget _buildStadiumListView(List<DocumentSnapshot> stadiums) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stadiums.length,
      itemBuilder: (context, index) {
        final stadium = stadiums[index];
        // Only use one image for StadiumCard to avoid RangeError.
        return StadiumCard(
          onTap: () => _navigateToStadiumDetails(stadium),
          title: stadium['name'],
          location: stadium['location'],
          price: stadium['price'].toString(),
          rating: 5,
          selectedImages: List<String>.from(
              stadium['images'] ?? ['assets/cards_home_player/imgs/test.jpg']),
        );
      },
    );
  }

  /// Builds the floating action button for adding a new stadium and deleting all stadiums.
  Widget _buildFloatingActionButton() {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return Column(
      // alignment: Alignment.bottomRight,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Delete All Button
        Container(
          margin: const EdgeInsets.only(bottom: 16, right: 16),
          child: FloatingActionButton(
            heroTag: 'deleteAll',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      isArabic ? 'حذف جميع الملاعب' : 'Delete All Stadiums',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      isArabic
                          ? 'هل أنت متأكد من حذف جميع الملاعب؟ هذه الخطوة لا يمكن التراجع عنها.'
                          : 'Are you sure you want to delete all stadiums? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          isArabic ? 'إلغاء' : 'Cancel',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            final stadiumsCollection = FirebaseFirestore
                                .instance
                                .collection('stadiums');
                            final snapshot = await stadiumsCollection.get();
                            for (var doc in snapshot.docs) {
                              await doc.reference.delete();
                            }
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isArabic
                                      ? 'تم حذف جميع الملاعب'
                                      : 'All stadiums deleted successfully',
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          } catch (e) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isArabic
                                      ? 'Error deleting stadiums: $e'
                                      : 'Error deleting stadiums: $e',
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Delete All',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.black,
            elevation: 4,
            child: Image.asset(
              "assets/home_loves_tickets_top/imgs/Group 204.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        // New Stadium Button
        FloatingActionButton.extended(
          heroTag: 'newStadium',
          onPressed: _navigateToAddNewStadium,
          backgroundColor: mainColor,
          elevation: 4,
          icon: Image.asset(
            "assets/home_loves_tickets_top/imgs/ic_twotone-stadium.png",
            width: 24.00,
          ),
          label: Text(
            isArabic ? "إضافة ملعب جديد" : "New Stadium",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "eras-itc-demi",
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
        drawer: Create_Drawer(refreshData: true),
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
