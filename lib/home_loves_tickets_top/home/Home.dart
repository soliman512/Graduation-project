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
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

      final bookingEndDateTime =
          parseBookingEndDateTime(matchDate, matchTime, matchDuration);

      if (bookingEndDateTime.isBefore(DateTime.now()) && !isRated) {
        final stadiumDoc = await FirebaseFirestore.instance
            .collection('stadiums')
            .doc(data['stadiumID'])
            .get();
        final stadiumName = stadiumDoc.data()?['name'] ?? '';

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showStadiumReviewPopup(
              context, data['stadiumID'], doc.id, stadiumName);
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

  void _showLocationFilterDialog() {
    final bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    String? selectedGovernorate;
    String? selectedPlace;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                isArabic ? "اختر الموقع" : "Select Location",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
                textAlign: TextAlign.center,
              ),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Governorate Selection
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            isArabic ? "اختر المحافظة" : "Select Governorate",
                            style: TextStyle(color: Colors.grey),
                          ),
                          value: selectedGovernorate,
                          items: egyptGovernorates.map((String governorate) {
                            return DropdownMenuItem<String>(
                              value: governorate,
                              child: Text(
                                governorate,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setDialogState(() {
                              selectedGovernorate = newValue;
                              selectedPlace =
                                  null; // Reset place when governorate changes
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Place Selection (only shown if governorate is selected)
                    if (selectedGovernorate != null)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              isArabic
                                  ? "اختر المكان (اختياري)"
                                  : "Select Place (Optional)",
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: selectedPlace,
                            items: [
                              DropdownMenuItem<String>(
                                value: null,
                                child: Text(
                                  isArabic ? "جميع الأماكن" : "All Places",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              ...(egyptGovernoratesAndCenters[
                                          selectedGovernorate] ??
                                      [])
                                  .map((String place) {
                                return DropdownMenuItem<String>(
                                  value: place,
                                  child: Text(
                                    place,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (String? newValue) {
                              setDialogState(() {
                                selectedPlace = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    isArabic ? "إلغاء" : "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (selectedGovernorate != null) {
                      // Update the parent widget's state
                      this.setState(() {
                        filterLocation_city = selectedGovernorate!;
                        filterLocation_place = selectedPlace ?? '';
                        filterLocation_location = selectedPlace != null
                            ? '$selectedGovernorate - $selectedPlace'
                            : selectedGovernorate!;
                        isFilterLocationTurnOn = true;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    isArabic ? "تطبيق" : "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Enhanced notification data structure
  Future<List<Map<String, dynamic>>> _getUserNotifications() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No user logged in for notifications');
      return [];
    }

    print('Fetching notifications for user: ${user.uid}');

    try {
      // Get notifications from players_notifications collection
      final notificationsSnapshot = await FirebaseFirestore.instance
          .collection('players_notifications')
          .where('playerId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .get();

      print('Found ${notificationsSnapshot.docs.length} notifications');

      List<Map<String, dynamic>> notifications = [];

      for (var notification in notificationsSnapshot.docs) {
        final notificationData = notification.data();
        print('Processing notification: ${notification.id}');
        print('Notification data: $notificationData');

        final matchDate = notificationData['matchDate'];
        final matchTime = notificationData['matchTime'];
        final matchDuration = notificationData['matchDuration'] ?? "1h  -  0m";
        final isRated = notificationData['isRated'] ?? false;
        final bookingEndDateTime =
            parseBookingEndDateTime(matchDate, matchTime, matchDuration);
        final now = DateTime.now();

        // Determine notification state
        String state;
        if (bookingEndDateTime.isBefore(now)) {
          state = isRated ? 'completed' : 'needs_review';
        } else if (bookingEndDateTime.difference(now).inDays <= 1) {
          state = 'coming_soon';
        } else {
          state = 'upcoming';
        }

        print('Notification state: $state');

        notifications.add({
          'id': notification.id,
          'bookingId': notificationData['bookingId'],
          'stadiumName': notificationData['stadiumName'],
          'stadiumId': notificationData['stadiumId'],
          'price': notificationData['price'],
          'matchDate': matchDate,
          'matchTime': matchTime,
          'matchDuration': matchDuration,
          'date': bookingEndDateTime,
          'state': state,
          'isRated': isRated,
          'stadiumImage': notificationData['stadiumImage'],
        });
      }

      print('Processed ${notifications.length} notifications');
      return notifications;
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
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
                        .where('playerId', isEqualTo: user.uid)
                        .where('type', isEqualTo: 'booking')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      print('StreamBuilder state: ${snapshot.connectionState}');
                      print('StreamBuilder hasError: ${snapshot.hasError}');
                      if (snapshot.hasError) {
                        print('StreamBuilder error: ${snapshot.error}');
                      }
                      print('StreamBuilder hasData: ${snapshot.hasData}');
                      if (snapshot.hasData) {
                        print(
                            'Number of notifications: ${snapshot.data?.docs.length}');
                        snapshot.data?.docs.forEach((doc) {
                          print('Notification ${doc.id}: ${doc.data()}');
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

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        extendBodyBehindAppBar: false,
        drawer: Create_Drawer(refreshData: true),
        appBar: Create_AppBar(
          notificationState: () => _showNotificationsDialog(),
          title: Add_AppName(
            align: TextAlign.center,
            font_size: 24.0,
            color: Colors.black,
          ),
        ),

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
                              hintText: isArabic
                                  ? "ما الذي تبحث عنه؟ ..."
                                  : "What the stadiums you looking for ? ...",
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
                                    color:
                                        const Color.fromARGB(255, 19, 19, 19),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          onTap: _showLocationFilterDialog,
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
                        ),
                      ),
                    ],
                  ),

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
                        if (stadiums.isEmpty) {
                          return _buildEmptyMessage();
                        }
                      }

                      // Apply location filter
                      if (isFilterLocationTurnOn) {
                        print(
                            'Applying location filter: City: $filterLocation_city, Place: $filterLocation_place'); // Debug print
                        stadiums = stadiums.where((s) {
                          final location =
                              s['location'].toString().toLowerCase();
                          print(
                              'Checking stadium location: $location'); // Debug print

                          if (filterLocation_place.isNotEmpty) {
                            // If a specific place is selected, filter by both governorate and place
                            final matches = location.contains(
                                    filterLocation_city.toLowerCase()) &&
                                location.contains(
                                    filterLocation_place.toLowerCase());
                            print(
                                'Filtering by place: $matches'); // Debug print
                            return matches;
                          } else {
                            // If only governorate is selected, filter by governorate only
                            final matches = location
                                .contains(filterLocation_city.toLowerCase());
                            print(
                                'Filtering by governorate only: $matches'); // Debug print
                            return matches;
                          }
                        }).toList();

                        print(
                            'Filtered stadiums count: ${stadiums.length}'); // Debug print

                        if (stadiums.isEmpty) {
                          return _buildEmptyMessage(isArabic
                              ? "لم يتم العثور على ملاعب في ${filterLocation_location}"
                              : "No stadiums found in ${filterLocation_location}");
                        }
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
  }
}
