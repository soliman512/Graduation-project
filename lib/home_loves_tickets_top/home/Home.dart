<<<<<<< HEAD
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/stadium_information_player_pg/stadium_information_player_pg.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:graduation_project_main/widgets/ticket_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Home screen widget that displays list of stadiums with search and filter functionality
=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../reusable_widgets/reusable_widgets.dart';
import '../../../constants/constants.dart';

>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
<<<<<<< HEAD
  // Filter heights
  double heightOfListfilter_city = 0.0;
  double heightOfListfilter_place = 0.0;

  // Search state
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  String filterLocation_city = '';
  String filterLocation_place = '';
  String filterLocation_location = '';
  bool isFilterLocationTurnOn = false;

  // Price filter state
  bool isFilterPriceTurnOn = false;
  bool filterTopPrice = false;
  bool filterLeastPrice = false;
  int priceCount = 0;

  // Rating filter state
  bool isFilterRatingTurnOn = false;
  bool filterTopRating = false;
  bool filterLeastRating = false;
  int ratingCount = 0;

  String? testStadiumId;

  /// Builds list of stadium cards from Firestore documents
  Widget _buildStadiumList(List<DocumentSnapshot> stadiums) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stadiums.length,
      itemBuilder: (context, index) {
        final stadium = stadiums[index];
        final stadiumId = stadiums[index].id;
        return StadiumCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Stadium_info_playerPG(
                          stadiumName: stadiums[index]['name'],
                          stadiumtitle: stadiums[index]['name'],
                          stadiumPrice: stadiums[index]['price'].toString(),
                          stadiumLocation: stadiums[index]['location'],
                          isWaterAvailbale: stadiums[index]['hasWater'],
                          isTrackAvailable: stadiums[index]['hasTrack'],
                          isGrassNormal: stadiums[index]['isNaturalGrass'],
                          capacity: stadiums[index]['capacity'].toString(),
                          description: stadiums[index]['description'],
                          stadiumID: stadiumId,
                        )));
          },
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

  /// Builds empty state message when no stadiums are found
  Widget _buildEmptyMessage(
      [String messageEn = "No stadiums found or shown",
      String messageAr = "لم يتم العثور على أي ملاعب أو عرضها"]) {
    final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final String message = isArabic ? messageAr : messageEn;
    return Center(
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 100, color: Color.fromARGB(38, 0, 0, 0)),
            SizedBox(height: 16),
            Text(
              message,
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(38, 0, 0, 0)),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ],
        );
      }),
    );
  }

  //notifications:
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('players_notifications');

  String daysBefore(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    final bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;

    if (difference.inDays > 0) {
      return isArabic
          ? 'منذ ${difference.inDays} أيام'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return isArabic
          ? 'منذ ${difference.inHours} ساعات'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return isArabic
          ? 'منذ ${difference.inMinutes} دقائق'
          : '${difference.inMinutes} minutes ago';
    } else {
      return '';
    }
  }

  List<Map<String, dynamic>> notifications = [
    {
      'stadiumName': 'Al Ahly Stadium',
      'price': 500,
      'isEnd': true,
      'date': DateTime.now().subtract(Duration(days: 2)), // Past booking
      'state': 'completed'
    },
    {
      'stadiumName': 'Cairo Stadium',
      'price': 600,
      'isEnd': false,
      'date': DateTime.now().add(Duration(days: 2)), // Upcoming booking
      'state': 'coming_soon'
    },
    {
      'stadiumName': 'Alexandria Stadium',
      'price': 450,
      'isEnd': false,
      'date': DateTime.now().add(Duration(days: 5)), // Future booking
      'state': 'coming_soon'
    }
  ];

  // Get current user's email username
  String getCurrentUsername() {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    return email.split('@')[0];
  }

  // Add notification data to Firestore collection
  Future<void> addNotificationsToFirestore() async {
    final prefs = await SharedPreferences.getInstance();
    final CollectionReference notificationsCollection =
        FirebaseFirestore.instance.collection('players_notifications');

    // Get the current user's email username
    final String username = getCurrentUsername();
    final bool alreadyAdded =
        prefs.getBool('notificationsAdded_$username') ?? false;

    if (alreadyAdded) return;

    // Check if notifications already exist for this user
    final existingNotifications = await notificationsCollection
        .where('username', isEqualTo: username)
        .get();

    // Only add notifications if they don't already exist
    if (existingNotifications.docs.isEmpty) {
      for (var notification in notifications) {
        await notificationsCollection.add({
          'username': username,
          'stadiumName': notification['stadiumName'],
          'price': notification['price'],
          'isEnd': notification['isEnd'],
          'date': Timestamp.fromDate(notification['date']),
          'createdAt': FieldValue.serverTimestamp(),
          'state': notification['state'],
        });
      }
      await prefs.setBool('notificationsAdded_$username', true);
    }
  }

  @override
  void initState() {
    super.initState();
    addNotificationsToFirestore();
    checkForUnratedBookings(); // استدعاء الدالة الجديدة هنا
  }

  Future<void> checkForUnratedBookings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final bookingsSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('playerID', isEqualTo: user.uid)
        .get();

    for (var doc in bookingsSnapshot.docs) {
      final data = doc.data();
      final matchDate = data['matchDate'];
      final matchTime = data['matchTime'];
      final matchDuration = data['matchDuration'] ?? "1h  -  0m";
      final isRated = data['isRated'] ?? false;

      final bookingEndDateTime = parseBookingEndDateTime(matchDate, matchTime, matchDuration);

      if (bookingEndDateTime.isBefore(DateTime.now()) && !isRated) {
        final stadiumDoc = await FirebaseFirestore.instance
            .collection('stadiums')
            .doc(data['stadiumID'])
            .get();
        final stadiumName = stadiumDoc.data()?['name'] ?? '';

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showStadiumReviewPopup(context, data['stadiumID'], doc.id, stadiumName);
        });
        break;
      }
    }
  }

  // دالة لتحويل التاريخ والوقت لـ DateTime
  DateTime parseBookingDateTime(String matchDate, String matchTime) {
    // matchDate: "23/5/2025", matchTime: "10:30 AM"
    final dateParts = matchDate.split('/');
    final timeParts = matchTime.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1].toUpperCase() == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;
    return DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
      hour,
      minute,
    );
  }

  DateTime parseBookingEndDateTime(
      String matchDate, String matchTime, String matchDuration) {
    // matchDate: "23/5/2025", matchTime: "10:30 AM", matchDuration: "1h  -  30m"
    final dateParts = matchDate.split('/');
    final timeParts = matchTime.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1].toUpperCase() == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    // Parse duration
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

  void _showRatingPopup() {
    showDialog(
      context: context,
      builder: (context) {
        double rating = 0; // قيمة التقييم الافتراضية
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
            // زر Cancel
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق النافذة بدون حفظ التقييم
              },
              child: Text("Cancel"),
            ),
            // زر Submit
            TextButton(
              onPressed: () async {
                if (rating == 0) {
                  showSnackBar(context, "Please select rate.");
                } else {
                  // تخزين التقييم في Firestore
                  await FirebaseFirestore.instance
                      .collection('app_ratings')
                      .add({
                    'rating': rating,
                    'timestamp': FieldValue.serverTimestamp(),
                    'userId': FirebaseAuth.instance.currentUser?.uid,
                    'type': 'player',
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

  void showStadiumReviewPopup(BuildContext context, String stadiumId,
      String bookingId, String stadiumName) {
    double rating = 0;
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate the Stadium"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please rate $stadiumName and write your comment"),
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
                decoration:
                    InputDecoration(hintText: "Write your comment here"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (rating == 0 || commentController.text.isEmpty) {
                  showSnackBar(
                      context, "Please select rating and write a comment");
                  return;
                }
                final user = FirebaseAuth.instance.currentUser;
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .get();
                await FirebaseFirestore.instance
                    .collection('stadiums')
                    .doc(stadiumId)
                    .collection('reviews')
                    .add({
                  'userId': user.uid,
                  'username': userDoc['username'],
                  'userImage': userDoc['profileImage'],
                  'rating': rating,
                  'comment': commentController.text,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                // علم الحجز أنه اتقيم
                await FirebaseFirestore.instance
                    .collection('bookings')
                    .doc(bookingId)
                    .update({'isRated': true});
                Navigator.of(context).pop();
                showSnackBar(context, "Your review has been submitted!");
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        extendBodyBehindAppBar: false,
        drawer: Create_Drawer(refreshData: true),
        appBar: Create_AppBar(
            notificationState: () => showDialog(
                  barrierColor: const Color.fromARGB(237, 0, 0, 0),
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      alignment: Alignment.topCenter,
                      insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('players_notifications')
                                .where('username',
                                    isEqualTo: getCurrentUsername())
                                .orderBy('date', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(
                                        color: Colors.white30),
                                    height: 100,
                                    width: 100.0,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                // Show Firestore index error in a user-friendly way
                                final errorMsg = snapshot.error.toString();
                                if (errorMsg.contains('FAILED_PRECONDITION') &&
                                    errorMsg.contains('index')) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error,
                                              color: Colors.red, size: 60),
                                          SizedBox(height: 16),
                                          Text(
                                            isArabic
                                                ? 'حدث خطأ في قاعدة البيانات. يتطلب الاستعلام فهرسًا في Firestore.'
                                                : 'A database error occurred. The query requires an index in Firestore.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            isArabic
                                                ? 'يرجى التواصل مع الدعم الفني أو مسؤول التطبيق لإصلاح المشكلة.'
                                                : 'Please contact support or the app admin to fix this issue.',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Text(isArabic
                                    ? 'حدث خطأ: ${snapshot.error}'
                                    : 'Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text(
                                          isArabic
                                              ? 'لا توجد إشعارات'
                                              : 'No notifications',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 20.0),
                                      Icon(
                                        Icons.notifications_paused_rounded,
                                        color: Colors.white,
                                        size: 100.0,
                                      ),
                                    ]));
                              }
                              final documents = snapshot.data!.docs;

                              return ListView.builder(
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    final data = documents[index].data()
                                        as Map<String, dynamic>;
                                    final DateTime date =
                                        (data['date'] as Timestamp).toDate();
                                    final String dayName =
                                        DateFormat('EEEE').format(date);
                                    final TimeOfDay time =
                                        TimeOfDay.fromDateTime(date);
                                    final bool isComingSoon =
                                        data['state'] == 'coming_soon';

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: TicketCard(
                                        stadiumName: data['stadiumName'],
                                        price: data['price'].toString(),
                                        date: date.toString() + ' - ' + dayName,
                                        time: time.format(context),
                                        isEnd: data['isEnd'],
                                        daysBefore: daysBefore(date),
                                      ),
                                    );
                                  });
                            }),
                      ),
                    );
                  },
                ),
            title: Add_AppName(
              align: TextAlign.center,
              font_size: 24.0,
              color: Colors.black,
            )),

        // Bottom navigation bar
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
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: Image.asset(
                    "assets/home_loves_tickets_top/imgs/home_active.png"),
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
                icon: Image.asset(
                    "assets/home_loves_tickets_top/imgs/ticket.png"),
                iconSize: 40.0,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: Stack(
          children: [
            backgroundImage_balls,
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 55),

                  // Search bar
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
=======

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
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
<<<<<<< HEAD
                              hintText: isArabic
                                  ? "ما الذي تبحث عنه؟ ..."
                                  : "What the stadiums you looking for ? ...",
=======
                              hintText:
                                  "What are you stadiums looking for ? ...",
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                              hintStyle: TextStyle(
                                color: Color(0x73000000),
                                fontSize: 12.0,
                              ),
<<<<<<< HEAD
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
                                    color:
                                        const Color.fromARGB(255, 19, 19, 19),
                                    size: 18,
                                  ),
                                ),
                              ),
=======
                              prefixIcon: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                    'assets/home_loves_tickets_top/imgs/Vector.png'),
                              ),
                              suffixIcon: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          CircleBorder()),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              mainColor),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero)),
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/home_loves_tickets_top/imgs/icon-park-outline_search.png',
                                    width: 26.0,
                                  )),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                            ),
                          ),
                        ),
                      ),
<<<<<<< HEAD
                    ],
                  ),

                  SizedBox(height: 40.0),
                  // Filter bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Filter icon
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

                      // City filter
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            BottomPicker(
                              items: isArabic
                                  ? getEgyptGovernoratesWidgets(context)
                                  : egyptGovernoratesWidgets,
                              height: 600.0,
                              titlePadding:
                                  EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                              buttonContent: Icon(Icons.navigate_next_rounded,
                                  color: Colors.white, size: 22.0),
                              buttonPadding: 10.0,
                              buttonStyle: BoxDecoration(
                                gradient: greenGradientColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              pickerTextStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              pickerTitle: Text(
                                  isArabic
                                      ? 'اختار المحافظه'
                                      : 'Select Governorate',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0)),
                              pickerDescription: Text(
                                  isArabic
                                      ? ' اختار المحافظه التي فيها الملعب'
                                      : 'Choose the governorate where the stadium is located',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400)),
                              onSubmit: (selectedIndex) {
                                String governorate =
                                    egyptGovernorates[selectedIndex];
                                setState(() {
                                  filterLocation_city = governorate;
                                });

                                Future.delayed(Duration(milliseconds: 10), () {
                                  // Show place picker after governorate selection
                                  List<Widget> placeWidgets =
                                      egyptGovernoratesAndCenters[
                                              filterLocation_city]!
                                          .map((place) => Center(
                                                child: Text(
                                                  place,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ))
                                          .toList();

                                  BottomPicker(
                                    items: placeWidgets,
                                    height: 600.0,
                                    titlePadding: EdgeInsets.fromLTRB(
                                        0.0, 20.0, 0.0, 0.0),
                                    buttonContent: Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.white,
                                        size: 22.0),
                                    buttonPadding: 10.0,
                                    buttonStyle: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    pickerTextStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                    pickerTitle: Text(
                                        isArabic
                                            ? 'اختار المكان'
                                            : 'Select Place',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24.0)),
                                    pickerDescription: Text(
                                        isArabic
                                            ? 'اختر المكان الذي يقع فيه الملعب'
                                            : 'Choose the place where the stadium is located',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400)),
                                    onSubmit: (selectedPlaceIndex) {
                                      String place =
                                          egyptGovernoratesAndCenters[
                                                  filterLocation_city]![
                                              selectedPlaceIndex];
                                      setState(() {
                                        filterLocation_place = place;
                                        filterLocation_location =
                                            '$filterLocation_city - $place';
                                        isFilterLocationTurnOn = true;
                                      });
                                    },
                                  ).show(context);
                                });
                              },
                            ).show(context);
                          },
                          child: isFilterLocationTurnOn
                              ? Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: mainColor, width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              filterLocation_location,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  filterLocation_city = '';
                                                  filterLocation_place = '';
                                                  filterLocation_location = '';
                                                  isFilterLocationTurnOn =
                                                      false;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  size: 12.0,
                                                ))
                                          ],
                                        ),
                                      )))
                              : Container(
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
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
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
                                        isArabic ? "المدينة" : "City",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: mainColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )),
                        ),
                      ),

                      // Price filter
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              priceCount++;
                              setState(() {});
                              if (priceCount == 1) {
                                filterLeastPrice = false;
                                filterTopPrice = true;
                                isFilterPriceTurnOn = true;
                              } else if (priceCount == 2) {
                                filterTopPrice = false;
                                filterLeastPrice = true;
                                isFilterPriceTurnOn = true;
                              } else {
                                isFilterPriceTurnOn = false;
                                priceCount = 0;
                              }
                            },
                            child: isFilterPriceTurnOn
                                ? Container(
                                    margin: EdgeInsets.only(right: 14.0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                        gradient: greenGradientColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: mainColor, width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  59, 0, 0, 0),
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0),
                                        ]),
                                    child: Center(
                                      child: filterTopPrice
                                          ? Icon(
                                              Icons
                                                  .keyboard_double_arrow_up_rounded,
                                              color: Colors.white,
                                              size: 20.0)
                                          : Icon(
                                              Icons
                                                  .keyboard_double_arrow_down_rounded,
                                              color: Colors.white,
                                              size: 20.0),
                                    ))
                                : Container(
                                    margin: EdgeInsets.only(right: 14.0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: mainColor, width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  59, 0, 0, 0),
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0),
                                        ]),
                                    child: Image.asset(
                                        'assets/home_loves_tickets_top/imgs/price_Vector.png')),
                          )),

                      // Rating filter
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            ratingCount++;
                            setState(() {});
                            if (ratingCount == 1) {
                              filterLeastRating = false;
                              filterTopRating = true;
                              isFilterRatingTurnOn = true;
                            } else if (ratingCount == 2) {
                              filterTopRating = false;
                              filterLeastRating = true;
                              isFilterRatingTurnOn = true;
                            } else {
                              isFilterRatingTurnOn = false;
                              ratingCount = 0;
                            }
                          },
                          child: isFilterRatingTurnOn
                              ? Container(
                                  margin: EdgeInsets.only(right: 14.0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                      gradient: greenGradientColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: mainColor, width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: Center(
                                    child: filterTopRating
                                        ? Icon(
                                            Icons
                                                .keyboard_double_arrow_up_rounded,
                                            color: Colors.white,
                                            size: 20.0)
                                        : Icon(
                                            Icons
                                                .keyboard_double_arrow_down_rounded,
                                            color: Colors.white,
                                            size: 20.0),
                                  ))
                              : Container(
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
                                            color: const Color.fromARGB(
                                                59, 0, 0, 0),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0),
                                      ]),
                                  child: Image.asset(
                                      'assets/home_loves_tickets_top/imgs/rating_Vector.png')),
=======
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
                                          MaterialStateProperty.all(0.0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              mainColor),
                                      side: MaterialStateProperty.all(
                                        BorderSide(
                                            color: mainColor,
                                            width: 1,
                                            style: BorderStyle.solid),
                                      ),
                                      shape: MaterialStateProperty.all(
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
                                          MaterialStateProperty.all(0.0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              mainColor),
                                      side: MaterialStateProperty.all(
                                        BorderSide(
                                            color: mainColor,
                                            width: 1,
                                            style: BorderStyle.solid),
                                      ),
                                      shape: MaterialStateProperty.all(
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
                                      MaterialStateProperty.all(0.0),
                                  backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all(
                                          mainColor),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                        color: mainColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  shape: MaterialStateProperty.all(
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
                                      MaterialStateProperty.all(0.0),
                                  backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all(
                                          mainColor),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                        color: mainColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  shape: MaterialStateProperty.all(
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
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                        ),
                      ),
                    ],
                  ),
<<<<<<< HEAD

                  SizedBox(height: 70.0),

                  // Stadium list
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stadiums')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Image.asset('assets/loading.gif'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return _buildEmptyMessage();
                      }

                      List<DocumentSnapshot> stadiums = snapshot.data!.docs;

                      // Apply search filter
                      if (searchQuery.isNotEmpty) {
                        stadiums = stadiums
                            .where((s) => s['name']
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply location filter
                      if (isFilterLocationTurnOn) {
                        stadiums = stadiums
                            .where((s) => s['location']
                                .toLowerCase()
                                .startsWith(
                                    filterLocation_location.toLowerCase()))
                            .toList();
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply price filter
                      if (isFilterPriceTurnOn) {
                        stadiums = List.from(stadiums);
                        if (filterTopPrice) {
                          stadiums.sort((a, b) =>
                              (b['price'] as num).compareTo(a['price'] as num));
                        } else if (filterLeastPrice) {
                          stadiums.sort((a, b) =>
                              (a['price'] as num).compareTo(b['price'] as num));
                        }
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // Apply rating filter
                      if (isFilterRatingTurnOn) {
                        stadiums = List.from(stadiums);
                        if (filterTopPrice) {
                          stadiums.sort((a, b) => (b['rating'] as num)
                              .compareTo(a['rating'] as num));
                        } else if (filterLeastPrice) {
                          stadiums.sort((a, b) => (a['rating'] as num)
                              .compareTo(b['rating'] as num));
                        }
                        return stadiums.isEmpty
                            ? _buildEmptyMessage()
                            : _buildStadiumList(stadiums);
                      }

                      // No filters applied
                      return _buildStadiumList(stadiums);
                    },
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
=======
                ),
              ],
            )));
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
  }
}
