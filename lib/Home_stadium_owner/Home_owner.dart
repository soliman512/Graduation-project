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
import 'package:graduation_project_main/Home_stadium_owner/stadium_statistics.dart';
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
            onPressed: _showNotificationsDialog,
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
        // Statistics Button
        Container(
          margin: const EdgeInsets.only(bottom: 16, right: 16),
          child: FloatingActionButton(
            heroTag: 'statistics',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StadiumStatistics(),
                ),
              );
            },
            backgroundColor: Colors.black,
            elevation: 4,
            child: const Icon(
              Icons.analytics_outlined,
              color: Colors.white,
              size: 24,
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

  void _showNotificationsDialog() {
    final bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      barrierColor: const Color.fromARGB(237, 0, 0, 0),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.topCenter,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            margin: EdgeInsets.only(top: 30.0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? "الإشعارات" : "Notifications",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                // Notifications List
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notifications')
                        .where('ownerId', isEqualTo: user.uid)
                        .where('type', isEqualTo: 'booking')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(
                          'Owner StreamBuilder state: ${snapshot.connectionState}');
                      print(
                          'Owner StreamBuilder hasError: ${snapshot.hasError}');
                      if (snapshot.hasError) {
                        print('Owner StreamBuilder error: ${snapshot.error}');
                      }
                      print('Owner StreamBuilder hasData: ${snapshot.hasData}');
                      if (snapshot.hasData) {
                        print(
                            'Number of owner notifications: ${snapshot.data?.docs.length}');
                        snapshot.data?.docs.forEach((doc) {
                          print('Owner notification ${doc.id}: ${doc.data()}');
                        });
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  color: Colors.red, size: 48),
                              SizedBox(height: 16),
                              Text(
                                isArabic
                                    ? "حدث خطأ في تحميل الإشعارات"
                                    : "Error loading notifications",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final notifications = snapshot.data?.docs ?? [];

                      if (notifications.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.grey,
                                size: 64,
                              ),
                              SizedBox(height: 16),
                              Text(
                                isArabic
                                    ? "لا توجد إشعارات"
                                    : "No notifications",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index].data()
                              as Map<String, dynamic>;
                          final matchDate = notification['matchDate'];
                          final matchTime = notification['matchTime'];
                          final matchDuration =
                              notification['matchDuration'] ?? "1h  -  0m";
                          final isRated = notification['isRated'] ?? false;
                          final bookingEndDateTime = parseBookingEndDateTime(
                              matchDate, matchTime, matchDuration);
                          final now = DateTime.now();

                          // Determine notification state
                          String state;
                          if (bookingEndDateTime.isBefore(now)) {
                            state = isRated ? 'completed' : 'needs_review';
                          } else if (bookingEndDateTime
                                  .difference(now)
                                  .inDays <=
                              1) {
                            state = 'coming_soon';
                          } else {
                            state = 'upcoming';
                          }

                          // Get appropriate icon and color based on state
                          IconData stateIcon;
                          Color stateColor;
                          String stateText;

                          switch (state) {
                            case 'needs_review':
                              stateIcon = Icons.rate_review;
                              stateColor = Colors.orange;
                              stateText =
                                  isArabic ? "يحتاج تقييم" : "Needs Review";
                              break;
                            case 'coming_soon':
                              stateIcon = Icons.event_available;
                              stateColor = Colors.green;
                              stateText = isArabic ? "قريباً" : "Coming Soon";
                              break;
                            case 'completed':
                              stateIcon = Icons.check_circle;
                              stateColor = Colors.blue;
                              stateText = isArabic ? "مكتمل" : "Completed";
                              break;
                            default:
                              stateIcon = Icons.event;
                              stateColor = Colors.grey;
                              stateText = isArabic ? "قادم" : "Upcoming";
                          }

                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (state == 'needs_review') {
                                  Navigator.of(context).pop();
                                  showStadiumReviewPopup(
                                    context,
                                    notification['stadiumId'],
                                    notification['bookingId'],
                                    notification['stadiumName'],
                                    notification['playerName'],
                                    notification['playerImage'],
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    // Stadium Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        notification['stadiumImage'],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    // Notification Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notification['stadiumName'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${notification['playerName']}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '${notification['matchDate']} - ${notification['matchTime']}',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                stateIcon,
                                                size: 14,
                                                color: stateColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                stateText,
                                                style: TextStyle(
                                                  color: stateColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Price
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: mainColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${notification['price']} EGP',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showStadiumReviewPopup(
      BuildContext context,
      String stadiumId,
      String bookingId,
      String stadiumName,
      String playerName,
      String? playerImage) {
    double rating = 0;
    TextEditingController commentController = TextEditingController();
    final bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isArabic ? "تقييم الحجز" : "Rate Booking"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isArabic
                    ? "يرجى تقييم حجز $playerName في $stadiumName"
                    : "Please rate $playerName's booking at $stadiumName",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              if (playerImage != null)
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(playerImage),
                ),
              SizedBox(height: 16),
              RatingBar.builder(
                minRating: 1,
                itemSize: 30,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText:
                      isArabic ? "اكتب تعليقك هنا" : "Write your comment here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(isArabic ? "إلغاء" : "Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (rating == 0 || commentController.text.isEmpty) {
                  showSnackBar(
                    context,
                    isArabic
                        ? "يرجى اختيار التقييم وكتابة تعليق"
                        : "Please select rating and write a comment",
                  );
                  return;
                }

                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) return;

                  // Add review to stadium's reviews collection
                  await FirebaseFirestore.instance
                      .collection('stadiums')
                      .doc(stadiumId)
                      .collection('reviews')
                      .add({
                    'userId': user.uid,
                    'username': 'Stadium Owner',
                    'userImage': null,
                    'rating': rating,
                    'comment': commentController.text,
                    'timestamp': FieldValue.serverTimestamp(),
                    'bookingId': bookingId,
                    'playerName': playerName,
                  });

                  // Update booking status
                  await FirebaseFirestore.instance
                      .collection('bookings')
                      .doc(bookingId)
                      .update({'isRated': true});

                  Navigator.of(context).pop();
                  showSnackBar(
                    context,
                    isArabic
                        ? "تم إرسال تقييمك بنجاح!"
                        : "Your review has been submitted successfully!",
                  );
                } catch (e) {
                  showSnackBar(
                    context,
                    isArabic
                        ? "حدث خطأ أثناء إرسال التقييم"
                        : "Error submitting review",
                  );
                }
              },
              child: Text(
                isArabic ? "إرسال" : "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  DateTime parseBookingEndDateTime(
      String matchDate, String matchTime, String matchDuration) {
    final dateParts = matchDate.split('/');
    final timeParts = matchTime.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1].toUpperCase() == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    final durationParts =
        RegExp(r'(\d+)h\s*-\s*(\d+)m').firstMatch(matchDuration);
    int durationHours = 0;
    int durationMinutes = 0;
    if (durationParts != null) {
      durationHours = int.parse(durationParts.group(1)!);
      durationMinutes = int.parse(durationParts.group(2)!);
    }

    final start = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
      hour,
      minute,
    );
    return start.add(Duration(hours: durationHours, minutes: durationMinutes));
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
