import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookingDetails extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const BookingDetails({
    Key? key,
    required this.bookingData,
  }) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool isLoading = true;
  Map<String, dynamic> stadiumData = {};
  Map<String, dynamic> playerData = {};

  @override
  void initState() {
    super.initState();
    loadBookingDetails();
  }

  Future<void> loadBookingDetails() async {
    setState(() => isLoading = true);
    try {
      // Get stadium details
      final stadiumDoc = await FirebaseFirestore.instance
          .collection('stadiums')
          .doc(widget.bookingData['stadiumID'])
          .get();

      if (stadiumDoc.exists) {
        stadiumData = stadiumDoc.data() ?? {};
      }

      // Get player details
      final playerDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.bookingData['playerID'])
          .get();

      if (playerDoc.exists) {
        playerData = playerDoc.data() ?? {};
      }
    } catch (e) {
      print('Error loading booking details: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _getStatusText(String? status, bool isArabic) {
    switch (status) {
      case 'completed':
        return isArabic ? "مكتمل" : "Completed";
      case 'cancelled':
        return isArabic ? "ملغي" : "Cancelled";
      case 'upcoming':
        return isArabic ? "قادم" : "Upcoming";
      case 'needs_review':
        return isArabic ? "يحتاج تقييم" : "Needs Review";
      default:
        return isArabic ? "غير معروف" : "Unknown";
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'upcoming':
        return Colors.blue;
      case 'needs_review':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'upcoming':
        return Icons.event;
      case 'needs_review':
        return Icons.rate_review;
      default:
        return Icons.help;
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
          isArabic ? "تفاصيل الحجز" : "Booking Details",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isArabic
                                    ? "معلومات الملعب"
                                    : "Stadium Information",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "eras-itc-bold",
                                ),
                              ),
                              if (stadiumData['images']?.isNotEmpty == true)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    stadiumData['images'][0],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.stadium,
                            stadiumData['name'] ?? 'Unknown Stadium',
                            isArabic ? "اسم الملعب" : "Stadium Name",
                          ),
                          const SizedBox(height: 12),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Player Info Card
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
                                isArabic
                                    ? "معلومات اللاعب"
                                    : "Player Information",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "eras-itc-bold",
                                ),
                              ),
                              if (playerData['profileImage'] != null)
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      NetworkImage(playerData['profileImage']),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.person,
                            playerData['username'] ?? 'Unknown Player',
                            isArabic ? "اسم اللاعب" : "Player Name",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.email,
                            playerData['email'] ?? 'N/A',
                            isArabic ? "البريد الإلكتروني" : "Email",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.phone,
                            playerData['phone'] ?? 'N/A',
                            isArabic ? "رقم الهاتف" : "Phone",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Booking Info Card
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
                            isArabic ? "معلومات الحجز" : "Booking Information",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "eras-itc-bold",
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.calendar_today,
                            widget.bookingData['matchDate'] ?? 'N/A',
                            isArabic ? "تاريخ المباراة" : "Match Date",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.access_time,
                            widget.bookingData['matchTime'] ?? 'N/A',
                            isArabic ? "وقت المباراة" : "Match Time",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.timer,
                            '${widget.bookingData['matchDuration'] ?? "1h  -  0m"}',
                            isArabic ? "مدة المباراة" : "Match Duration",
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            Icons.attach_money,
                            '${widget.bookingData['price'] ?? 0} EGP',
                            isArabic ? "السعر" : "Price",
                          ),
                          if (widget.bookingData['createdAt'] != null) ...[
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              Icons.access_time_filled,
                              DateFormat('dd/MM/yyyy HH:mm').format(
                                  (widget.bookingData['createdAt'] as Timestamp)
                                      .toDate()),
                              isArabic ? "تاريخ الحجز" : "Booking Date",
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Status Card
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
                            isArabic ? "حالة الحجز" : "Booking Status",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "eras-itc-bold",
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _getStatusColor(widget.bookingData['state'])
                                      .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getStatusIcon(widget.bookingData['state']),
                                  color: _getStatusColor(
                                      widget.bookingData['state']),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _getStatusText(
                                      widget.bookingData['state'], isArabic),
                                  style: TextStyle(
                                    color: _getStatusColor(
                                        widget.bookingData['state']),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: "eras-itc-bold",
                                  ),
                                ),
                              ],
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
}
