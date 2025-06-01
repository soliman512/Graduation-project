import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_main/Home_stadium_owner/stadium_details.dart';
import 'package:graduation_project_main/Home_stadium_owner/booking_details.dart';

class StadiumStatistics extends StatefulWidget {
  const StadiumStatistics({Key? key}) : super(key: key);

  @override
  State<StadiumStatistics> createState() => _StadiumStatisticsState();
}

class _StadiumStatisticsState extends State<StadiumStatistics> {
  bool isLoading = true;
  Map<String, dynamic> statistics = {
    'totalStadiums': 0,
    'totalBookings': 0,
    'totalRevenue': 0.0,
    'averageRating': 0.0,
    'bookingsByMonth': <String, int>{},
    'revenueByMonth': <String, double>{},
    'stadiumsWithBookings': <String, int>{},
    'stadiumsWithRevenue': <String, double>{},
    'recentBookings': <Map<String, dynamic>>[],
    'topRatedStadiums': <Map<String, dynamic>>[],
  };

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    setState(() => isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Get all stadiums owned by the user
      final stadiumsSnapshot = await FirebaseFirestore.instance
          .collection('stadiums')
          .where('userID', isEqualTo: user.uid)
          .get();

      final stadiums = stadiumsSnapshot.docs;
      statistics['totalStadiums'] = stadiums.length;

      // Initialize maps for monthly data
      final now = DateTime.now();
      for (int i = 0; i < 6; i++) {
        final date = now.subtract(Duration(days: 30 * i));
        final monthKey = DateFormat('MMM yyyy').format(date);
        statistics['bookingsByMonth'][monthKey] = 0;
        statistics['revenueByMonth'][monthKey] = 0.0;
      }

      // Get all bookings for these stadiums
      int totalBookings = 0;
      double totalRevenue = 0.0;
      Map<String, List<double>> stadiumRatings = {};

      for (var stadium in stadiums) {
        final stadiumId = stadium.id;
        final stadiumData = stadium.data();
        final stadiumName = stadiumData['name'] as String;

        // Get bookings for this stadium
        final bookingsSnapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('stadiumID', isEqualTo: stadiumId)
            .get();

        final bookings = bookingsSnapshot.docs;
        totalBookings += bookings.length;

        // Process bookings
        for (var booking in bookings) {
          final bookingData = booking.data();
          final price = (bookingData['price'] as num).toDouble();
          totalRevenue += price;

          // Add to monthly statistics
          final bookingDate =
              DateTime.parse(bookingData['createdAt'].toDate().toString());
          final monthKey = DateFormat('MMM yyyy').format(bookingDate);
          if (statistics['bookingsByMonth'].containsKey(monthKey)) {
            statistics['bookingsByMonth'][monthKey] =
                (statistics['bookingsByMonth'][monthKey] ?? 0) + 1;
            statistics['revenueByMonth'][monthKey] =
                (statistics['revenueByMonth'][monthKey] ?? 0.0) + price;
          }

          // Add to stadium statistics
          statistics['stadiumsWithBookings'][stadiumName] =
              (statistics['stadiumsWithBookings'][stadiumName] ?? 0) + 1;
          statistics['stadiumsWithRevenue'][stadiumName] =
              (statistics['stadiumsWithRevenue'][stadiumName] ?? 0.0) + price;

          // Add to recent bookings
          if (statistics['recentBookings'].length < 5) {
            statistics['recentBookings'].add({
              'stadiumName': stadiumName,
              'price': price,
              'date': bookingData['matchDate'],
              'time': bookingData['matchTime'],
              'playerName': bookingData['playerName'] ?? 'Unknown Player',
            });
          }
        }

        // Get ratings for this stadium
        final reviewsSnapshot = await FirebaseFirestore.instance
            .collection('stadiums')
            .doc(stadiumId)
            .collection('reviews')
            .get();

        final reviews = reviewsSnapshot.docs;
        if (reviews.isNotEmpty) {
          double totalRating = 0;
          for (var review in reviews) {
            totalRating += (review.data()['rating'] as num).toDouble();
          }
          final averageRating = totalRating / reviews.length;
          stadiumRatings[stadiumName] = [
            averageRating,
            reviews.length.toDouble()
          ];
        }
      }

      // Calculate overall statistics
      statistics['totalBookings'] = totalBookings;
      statistics['totalRevenue'] = totalRevenue;

      // Calculate average rating across all stadiums
      if (stadiumRatings.isNotEmpty) {
        double totalRating = 0;
        int totalReviews = 0;
        stadiumRatings.forEach((_, ratings) {
          totalRating += ratings[0] * ratings[1];
          totalReviews += ratings[1].toInt();
        });
        statistics['averageRating'] = totalRating / totalReviews;

        // Get top rated stadiums
        statistics['topRatedStadiums'] = stadiumRatings.entries
            .map((e) => {
                  'name': e.key,
                  'rating': e.value[0],
                  'reviews': e.value[1].toInt(),
                })
            .toList()
          ..sort((a, b) =>
              (b['rating'] as double).compareTo(a['rating'] as double));
      }

      // Sort recent bookings by date
      statistics['recentBookings'].sort((a, b) {
        final dateA = DateFormat('dd/MM/yyyy').parse(a['date']);
        final dateB = DateFormat('dd/MM/yyyy').parse(b['date']);
        return dateB.compareTo(dateA);
      });
    } catch (e) {
      print('Error loading statistics: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showStadiumDetails(String stadiumId, String stadiumName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StadiumDetails(
          stadiumId: stadiumId,
          stadiumName: stadiumName,
        ),
      ),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetails(
          bookingData: booking,
        ),
      ),
    );
  }

  void _showDetailedStatistics(String type) {
    final isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isArabic
                        ? type == 'stadiums'
                            ? 'تفاصيل الملاعب'
                            : type == 'bookings'
                                ? 'تفاصيل الحجوزات'
                                : type == 'revenue'
                                    ? 'تفاصيل الإيرادات'
                                    : 'تفاصيل التقييمات'
                        : type == 'stadiums'
                            ? 'Stadium Details'
                            : type == 'bookings'
                                ? 'Booking Details'
                                : type == 'revenue'
                                    ? 'Revenue Details'
                                    : 'Rating Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "eras-itc-bold",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildDetailedContent(type),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedContent(String type) {
    final isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    switch (type) {
      case 'stadiums':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...statistics['stadiumsWithBookings']
                .entries
                .map((entry) => Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Icon(Icons.stadium, color: mainColor),
                        title: Text(entry.key,
                            style:
                                const TextStyle(fontFamily: "eras-itc-bold")),
                        subtitle: Text(
                          '${entry.value} ${isArabic ? "حجز" : "bookings"}',
                          style: const TextStyle(fontFamily: "eras-itc-demi"),
                        ),
                        trailing: Text(
                          '${statistics['stadiumsWithRevenue'][entry.key]?.toStringAsFixed(0) ?? 0} EGP',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: "eras-itc-bold",
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        );
      case 'bookings':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...statistics['recentBookings']
                .map((booking) => Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Icon(Icons.calendar_today, color: mainColor),
                        title: Text(booking['stadiumName'],
                            style:
                                const TextStyle(fontFamily: "eras-itc-bold")),
                        subtitle: Text(
                          '${booking['playerName']} - ${booking['date']} ${booking['time']}',
                          style: const TextStyle(fontFamily: "eras-itc-demi"),
                        ),
                        trailing: Text(
                          '${booking['price']} EGP',
                          style: const TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "eras-itc-bold",
                          ),
                        ),
                        onTap: () => _showBookingDetails(booking),
                      ),
                    ))
                .toList(),
          ],
        );
      case 'revenue':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...statistics['revenueByMonth']
                .entries
                .map((entry) => Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading:
                            const Icon(Icons.attach_money, color: Colors.green),
                        title: Text(entry.key,
                            style:
                                const TextStyle(fontFamily: "eras-itc-bold")),
                        subtitle: Text(
                          '${statistics['bookingsByMonth'][entry.key]} ${isArabic ? "حجز" : "bookings"}',
                          style: const TextStyle(fontFamily: "eras-itc-demi"),
                        ),
                        trailing: Text(
                          '${entry.value.toStringAsFixed(0)} EGP',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: "eras-itc-bold",
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        );
      case 'ratings':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...statistics['topRatedStadiums']
                .map((stadium) => Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: Text(stadium['name'],
                            style:
                                const TextStyle(fontFamily: "eras-itc-bold")),
                        subtitle: Text(
                          '${stadium['reviews']} ${isArabic ? "تقييم" : "reviews"}',
                          style: const TextStyle(fontFamily: "eras-itc-demi"),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            stadium['rating'].toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontFamily: "eras-itc-bold",
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildStatisticsCard(
      String title, String value, IconData icon, Color color,
      {bool isFullWidth = false, String? type}) {
    return InkWell(
      onTap: type != null ? () => _showDetailedStatistics(type) : null,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: isFullWidth
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontFamily: "eras-itc-demi",
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: color,
                              fontFamily: "eras-itc-bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: "eras-itc-demi",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontFamily: "eras-itc-bold",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMonthlyChart() {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final months =
        statistics['bookingsByMonth'].keys.toList().reversed.toList();
    final bookings =
        months.map((m) => statistics['bookingsByMonth'][m] ?? 0).toList();
    final revenue =
        months.map((m) => statistics['revenueByMonth'][m] ?? 0.0).toList();

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? "الإحصائيات الشهرية" : "Monthly Statistics",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "eras-itc-bold",
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isArabic ? "الحجوزات" : "Bookings",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 12,
                      fontFamily: "eras-itc-demi",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                              fontFamily: "eras-itc-demi",
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                  fontFamily: "eras-itc-demi",
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(months.length, (index) {
                        return FlSpot(
                            index.toDouble(), bookings[index].toDouble());
                      }),
                      isCurved: true,
                      color: mainColor,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: mainColor,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: mainColor.withOpacity(0.1),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            mainColor.withOpacity(0.2),
                            mainColor.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopStadiums() {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final topStadiums =
        statistics['topRatedStadiums'] as List<Map<String, dynamic>>;
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? "أعلى الملاعب تقييماً" : "Top Rated Stadiums",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "eras-itc-bold",
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        isArabic ? "التقييم" : "Rating",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 12,
                          fontFamily: "eras-itc-demi",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...topStadiums
                .take(3)
                .map((stadium) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stadium['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "eras-itc-bold",
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${stadium['reviews']} ${isArabic ? "تقييم" : "reviews"}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontFamily: "eras-itc-demi",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                stadium['rating'].toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "eras-itc-bold",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBookings() {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final recentBookings =
        statistics['recentBookings'] as List<Map<String, dynamic>>;
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? "الحجوزات الأخيرة" : "Recent Bookings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "eras-itc-bold",
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isArabic ? "آخر 5 حجوزات" : "Last 5 bookings",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 12,
                      fontFamily: "eras-itc-demi",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...recentBookings
                .map((booking) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: mainColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.calendar_today,
                                  color: mainColor, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['stadiumName'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "eras-itc-bold",
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${booking['playerName']} - ${booking['date']} ${booking['time']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontFamily: "eras-itc-demi",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: mainColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${booking['price']} EGP',
                                style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: "eras-itc-bold",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isArabic ? "إحصائيات الملاعب" : "Stadium Statistics",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "eras-itc-bold",
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: mainColor))
            : Stack(
                children: [
                  backgroundImage_balls,
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overview Cards
                        Column(
                          children: [
                            // Full width card
                            _buildStatisticsCard(
                              isArabic ? "إجمالي الملاعب" : "Total Stadiums",
                              statistics['totalStadiums'].toString(),
                              Icons.stadium,
                              mainColor,
                              isFullWidth: true,
                              type: 'stadiums',
                            ),
                            const SizedBox(height: 16),
                            // Grid of 3 cards
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatisticsCard(
                                    isArabic
                                        ? "إجمالي الحجوزات"
                                        : "Total Bookings",
                                    statistics['totalBookings'].toString(),
                                    Icons.calendar_month,
                                    Colors.blue,
                                    type: 'bookings',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatisticsCard(
                                    isArabic
                                        ? "إجمالي الإيرادات"
                                        : "Total Revenue",
                                    '${statistics['totalRevenue'].toStringAsFixed(0)} EGP',
                                    Icons.attach_money,
                                    Colors.green,
                                    type: 'revenue',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Last card
                            _buildStatisticsCard(
                              isArabic ? "متوسط التقييم" : "Average Rating",
                              statistics['averageRating'].toStringAsFixed(1),
                              Icons.star,
                              Colors.amber,
                              isFullWidth: true,
                              type: 'ratings',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Monthly Chart
                        _buildMonthlyChart(),
                        const SizedBox(height: 24),
                        // Top Stadiums
                        _buildTopStadiums(),
                        const SizedBox(height: 24),
                        // Recent Bookings
                        _buildRecentBookings(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
