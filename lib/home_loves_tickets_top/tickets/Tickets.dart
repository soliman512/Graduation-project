import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:provider/provider.dart';

Widget _buildCustom(String text, Color textcolor) {
  return Container(
    width: 60,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: textcolor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
          color: Color(0xffFFFFFF), fontFamily: "myfont", fontSize: 12),
    ),
  );
}

Widget buildCard({
  required String title,
  required String location,
  required String name,
  required String day,
  required String time,
  required String imageUrl,
  required String price,
  required bool status,
  required BuildContext context,
  required String timeText, // أضف هذا المتغير
}) {
  final isArabic = Provider.of<LanguageProvider>(context).isArabic;
  return Center(
    child: GestureDetector(
      onTap: () {},
      child: Container(
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
          image: DecorationImage(
            image: imageUrl.startsWith('http')
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    timeText, // استخدم النص المحسوب هنا
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (status) _buildCustom(isArabic ?"جاري" : "Progress", Colors.green),
                      if (!status)
                        _buildCustom(isArabic ?"انتهت" : "end", Color.fromARGB(255, 235, 2, 2)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stadium,
                        size: 19,
                        color: Color(0xff00B92E),
                      ),
                      SizedBox(width: 5),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'eras-itc-bold',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00B92E),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 10,
                        color: Color(0xff00B92E),
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
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'eras-itc-demi',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 10,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'eras-itc-demi',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            day,
                            style: TextStyle(
                              fontFamily: 'eras-itc-demi',
                              fontSize: 10,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 12,
                            color: Color(0xff00B92E),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff00B92E),
                              fontFamily: 'eras-itc-bold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -26.0,
              right: -26.0,
              child: Image.asset(
                "assets/home_loves_tickets_top/imgs/ball.png",
                width: 100.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final user = FirebaseAuth.instance.currentUser;

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
                  fontFamily: isArabic ? "Cairo" : "eras-itc-bold",
                  fontWeight: FontWeight.w900,
                  color: Color(0xff000000),
                  fontSize: 24.0),
              children: [
                TextSpan(text: isArabic ? "  حالة" : "Book"),
                TextSpan(
                    text: isArabic ? "الحجز" : "ing",
                    style: TextStyle(color: Color(0xff00B92E))),
                TextSpan(text: isArabic ? "" : "Status"),
              ],
            ),
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
                  Navigator.pushNamed(context, '/home');
                },
                icon: Image.asset(
                    "assets/home_loves_tickets_top/imgs/home.png"),
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
                  Image.asset("assets/home_loves_tickets_top/imgs/ticket_active.png"),
              iconSize: 40.0,
            ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: [
            backgroundImage_balls,
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bookings')
                  .where('playerID', isEqualTo: user?.uid)
                  .orderBy('matchDate', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Image.asset('assets/loading.gif'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      isArabic ? "لا توجد حجوزات" : "No bookings found",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }
                final bookings = snapshot.data!.docs;
                return ListView.builder(
                  padding: EdgeInsets.only(top: 60, bottom: 80),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index].data() as Map<String, dynamic>;
                    final matchDate = booking['matchDate'] ?? '';
                    final matchTime = booking['matchTime'] ?? '';
                    final matchDuration = booking['matchDuration'] ?? '';
                    final price = booking['matchCost']?.toString() ?? '';
                    final stadiumID = booking['stadiumID'] ?? '';
                    final bookingDateTime = _parseBookingEndDateTime(matchDate, matchTime, matchDuration);

                    // احضر بيانات الاستاد (الاسم، الصورة، الموقع)
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('stadiums').doc(stadiumID).get(),
                      builder: (context, stadiumSnapshot) {
                        if (!stadiumSnapshot.hasData) {
                          return SizedBox();
                        }
                        final stadiumData = stadiumSnapshot.data!.data() as Map<String, dynamic>? ?? {};
                        final stadiumName = stadiumData['name'] ?? '';
                        final stadiumLocation = stadiumData['location'] ?? '';
                        final stadiumImage = (stadiumData['images'] != null && stadiumData['images'].isNotEmpty)
                            ? stadiumData['images'][0]
                            : 'assets/cards_home_player/imgs/test.jpg';

                        // تحديد حالة الحجز
                        final now = DateTime.now();
                        final difference = bookingDateTime.difference(now);
                        String timeText;
                        if (difference.inDays > 0) {
                          timeText = isArabic ? "بعد ${difference.inDays} يوم" : "In ${difference.inDays} days";
                        } else if (difference.inDays == 0) {
                          timeText = isArabic ? "اليوم" : "Today";
                        } else {
                          timeText = isArabic ? "منذ ${difference.inDays.abs()} يوم" : "Before ${difference.inDays.abs()} days";
                        }
                        final isEnded = bookingDateTime.isBefore(now);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: buildCard(
                            title: stadiumName,
                            location: stadiumLocation,
                            name: isArabic ? "أنت" : "You",
                            day: matchDate,
                            time: matchTime,
                            imageUrl: stadiumImage,
                            price: price,
                            status: !isEnded, // جاري إذا لم ينتهي
                            context: context,
                            timeText: timeText, // أرسل النص المحسوب هنا
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// دالة لحساب نهاية الحجز (نفس منطق صفحة Home)
DateTime _parseBookingEndDateTime(String matchDate, String matchTime, String matchDuration) {
  try {
    final dateParts = matchDate.split('/');
    final timeParts = matchTime.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1].toUpperCase() == 'PM';
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    // Parse duration
    final durationParts = RegExp(r'(\d+)h\s*-\s*(\d+)m').firstMatch(matchDuration);
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
  } catch (e) {
    return DateTime.now();
  }
}