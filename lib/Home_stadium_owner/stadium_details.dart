import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StadiumDetails extends StatefulWidget {
  final String stadiumId;
  final String stadiumName;

  const StadiumDetails({
    Key? key,
    required this.stadiumId,
    required this.stadiumName,
  }) : super(key: key);

  @override
  State<StadiumDetails> createState() => _StadiumDetailsState();
}

class _StadiumDetailsState extends State<StadiumDetails> {
  bool isLoading = true;
  Map<String, dynamic> stadiumData = {};
  List<Map<String, dynamic>> bookings = [];
  List<Map<String, dynamic>> reviews = [];
  String? ownerId;
  Map<String, dynamic> ownerData = {};

  @override
  void initState() {
    super.initState();
    loadStadiumDetails();
  }

  Future<void> loadStadiumDetails() async {
    setState(() => isLoading = true);
    try {
      // Get current user
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('No user logged in');
        return;
      }

      // Get owner document from owners collection using current user's email
      final ownersSnapshot = await FirebaseFirestore.instance
          .collection('owners')
          .where('email', isEqualTo: currentUser.email)
          .get();

      if (ownersSnapshot.docs.isEmpty) {
        print('No owner found for current user');
        return;
      }

      // Get owner document ID and data
      final ownerDoc = ownersSnapshot.docs.first;
      ownerId = ownerDoc.id;
      ownerData = ownerDoc.data();

      // Get stadium details and verify ownership
      final stadiumDoc = await FirebaseFirestore.instance
          .collection('stadiums')
          .doc(widget.stadiumId)
          .get();

      if (stadiumDoc.exists) {
        final data = stadiumDoc.data()!;
        // Verify if the stadium belongs to the current owner
        if (data['userID'] == ownerId) {
          stadiumData = data;
        } else {
          print('Stadium does not belong to current owner');
          return;
        }
      }

      // Get bookings with player details
      final bookingsSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('stadiumID', isEqualTo: widget.stadiumId)
          .orderBy('matchDate', descending: true)
          .get();

      bookings = [];
      for (var booking in bookingsSnapshot.docs) {
        final bookingData = booking.data();
        // Get player details
        final playerDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(bookingData['playerID'])
            .get();

        if (playerDoc.exists) {
          final playerData = playerDoc.data()!;
          bookings.add({
            ...bookingData,
            'playerName': playerData['username'] ?? 'Unknown Player',
            'playerImage': playerData['profileImage'],
            'bookingId': booking.id,
          });
        }
      }

      // Get reviews with user details
      final reviewsSnapshot = await FirebaseFirestore.instance
          .collection('stadiums')
          .doc(widget.stadiumId)
          .collection('reviews')
          .orderBy('timestamp', descending: true)
          .get();

      reviews = [];
      for (var review in reviewsSnapshot.docs) {
        final reviewData = review.data();
        // Get reviewer details if it's not a stadium owner review
        if (reviewData['userId'] != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(reviewData['userId'])
              .get();

          if (userDoc.exists) {
            final userData = userDoc.data()!;
            reviews.add({
              ...reviewData,
              'username': userData['username'] ?? 'Unknown User',
              'userImage': userData['profileImage'],
            });
          }
        } else {
          reviews.add(reviewData);
        }
      }
    } catch (e) {
      print('Error loading stadium details: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.stadiumName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: "eras-itc-bold",
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: mainColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stadium Info Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? "معلومات الملعب" : "Stadium Information",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "eras-itc-bold",
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.location_on,
                            stadiumData['location'] ?? 'N/A',
                            isArabic ? "الموقع" : "Location",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.phone,
                            stadiumData['phone'] ?? 'N/A',
                            isArabic ? "رقم الهاتف" : "Phone",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.attach_money,
                            '${stadiumData['price'] ?? 0} EGP',
                            isArabic ? "السعر" : "Price",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.people,
                            '${stadiumData['capacity'] ?? 0} ${isArabic ? "شخص" : "people"}',
                            isArabic ? "السعة" : "Capacity",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.access_time,
                            '${stadiumData['startTime'] ?? 'N/A'} - ${stadiumData['endTime'] ?? 'N/A'}',
                            isArabic ? "ساعات العمل" : "Working Hours",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.calendar_today,
                            (stadiumData['workingDays'] as List<dynamic>?)
                                    ?.join(', ') ??
                                'N/A',
                            isArabic ? "أيام العمل" : "Working Days",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Bookings Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isArabic ? "الحجوزات" : "Bookings",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "eras-itc-bold",
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
                                  '${bookings.length} ${isArabic ? "حجز" : "bookings"}',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 12,
                                    fontFamily: "eras-itc-demi",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...bookings.map((booking) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey[200]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage:
                                                booking['playerImage'] != null
                                                    ? NetworkImage(
                                                        booking['playerImage'])
                                                    : null,
                                            child:
                                                booking['playerImage'] == null
                                                    ? const Icon(Icons.person,
                                                        size: 16)
                                                    : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              booking['playerName'] ??
                                                  'Unknown Player',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "eras-itc-bold",
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: _getBookingStatusColor(
                                                      booking['isRated'] ??
                                                          false)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              _getBookingStatusText(
                                                  booking['isRated'] ?? false,
                                                  isArabic),
                                              style: TextStyle(
                                                color: _getBookingStatusColor(
                                                    booking['isRated'] ??
                                                        false),
                                                fontSize: 12,
                                                fontFamily: "eras-itc-demi",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${booking['matchDate']} ${booking['matchTime']}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          fontFamily: "eras-itc-demi",
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${booking['price']} EGP',
                                        style: const TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: "eras-itc-bold",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Reviews Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isArabic ? "التقييمات" : "Reviews",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "eras-itc-bold",
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${reviews.length} ${isArabic ? "تقييم" : "reviews"}',
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
                          const SizedBox(height: 16),
                          ...reviews.map((review) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey[200]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage:
                                                review['userImage'] != null
                                                    ? NetworkImage(
                                                        review['userImage'])
                                                    : null,
                                            child: review['userImage'] == null
                                                ? const Icon(Icons.person,
                                                    size: 16)
                                                : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              review['username'] ??
                                                  'Unknown User',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "eras-itc-bold",
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.amber.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  review['rating'].toString(),
                                                  style: const TextStyle(
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontFamily: "eras-itc-bold",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        review['comment'] ?? '',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14,
                                          fontFamily: "eras-itc-demi",
                                        ),
                                      ),
                                      if (review['timestamp'] != null) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              (review['timestamp'] as Timestamp)
                                                  .toDate()),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                            fontFamily: "eras-itc-demi",
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: mainColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontFamily: "eras-itc-demi",
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "eras-itc-bold",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getBookingStatusColor(bool isRated) {
    return isRated ? Colors.green : Colors.blue;
  }

  String _getBookingStatusText(bool isRated, bool isArabic) {
    return isRated
        ? (isArabic ? "مكتمل" : "Completed")
        : (isArabic ? "قادم" : "Upcoming");
  }
}
