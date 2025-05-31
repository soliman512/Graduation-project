import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_main/payment/done.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/stripe_payment/payment_manger.dart';
// import 'package:graduation_project_main/stripe_payment/payment_manger.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();

  final String stadiumID;

  Payment({
    required this.stadiumID,
  });
}

class _PaymentState extends State<Payment> with TickerProviderStateMixin {
  double testCost = 200.0;
  // inputs controller
  String matchDate = '';
  String matchTime = '';
  String matchDuration = '';
  double calcCost = 0.0;
  double matchCost = 0.0;
  String paymentWay = '';
  bool creditCard = false;
  bool fawry = false;
  bool cash = false;

  bool isFormValid() {
    return matchDate.isNotEmpty &&
        matchTime.isNotEmpty &&
        matchDuration.isNotEmpty;
  }

  // Check if the selected time slot is already booked
  Future<bool> isTimeSlotAvailable() async {
    try {
      // Query Firestore for bookings on the same day and stadium
      final QuerySnapshot bookingsOnSameDay = await FirebaseFirestore.instance
          .collection('bookings')
          .where('stadiumID', isEqualTo: widget.stadiumID)
          .where('matchDate', isEqualTo: matchDate)
          .get();
      
      print('Found ${bookingsOnSameDay.docs.length} bookings on the same day for this stadium');
      
      // If no bookings on this day, the slot is available
      if (bookingsOnSameDay.docs.isEmpty) {
        print('No existing bookings found, time slot is available');
        return true;
      }
      
      // Parse the selected time (e.g., "10:30 AM")
      final bool isPM = matchTime.toLowerCase().contains('pm');
      final String timeWithoutAmPm = matchTime.replaceAll(RegExp(r'[\s]*[AaPp][Mm]'), '');
      final List<String> timeParts = timeWithoutAmPm.split(':');
      
      if (timeParts.length != 2) {
        print('Invalid time format: $matchTime');
        return false; // Invalid time format
      }
      
      int bookingHours = int.parse(timeParts[0]);
      int bookingMinutes = int.parse(timeParts[1].trim());
      
      // Convert to 24-hour format if PM
      if (isPM && bookingHours < 12) {
        bookingHours += 12;
      } else if (!isPM && bookingHours == 12) {
        bookingHours = 0;
      }
      
      print('Booking time (24h format): $bookingHours:$bookingMinutes');
      
      // Parse the duration (e.g., "1h  -  30m")
      String durationStr = matchDuration.replaceAll('h  -  ', ':').replaceAll('m', '');
      final List<String> durationParts = durationStr.split(':');
      if (durationParts.length != 2) {
        print('Invalid duration format: $matchDuration');
        return false; // Invalid duration format
      }
      
      final int durationHours = int.parse(durationParts[0]);
      final int durationMinutes = int.parse(durationParts[1]);
      print('Duration: $durationHours hours, $durationMinutes minutes');
      
      // Calculate the end time of the booking
      final int bookingEndHours = (bookingHours + durationHours + (bookingMinutes + durationMinutes) ~/ 60) % 24;
      final int bookingEndMinutes = (bookingMinutes + durationMinutes) % 60;
      print('Booking end time (24h format): $bookingEndHours:$bookingEndMinutes');
      
      // Convert times to minutes for easier comparison
      final int newBookingStartMinutes = bookingHours * 60 + bookingMinutes;
      final int newBookingEndMinutes = newBookingStartMinutes + durationHours * 60 + durationMinutes;
      print('New booking: $newBookingStartMinutes - $newBookingEndMinutes (in minutes from midnight)');
      
      // Check each booking for time overlap
      for (var doc in bookingsOnSameDay.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print('Checking existing booking: ${data.toString()}');
        
        // Get existing booking time
        final String existingTimeStr = data['matchTime'];
        print('Existing time string: $existingTimeStr');
        
        // Skip if time format is invalid
        if (!existingTimeStr.toLowerCase().contains('am') && 
            !existingTimeStr.toLowerCase().contains('pm')) {
          print('Existing booking has invalid time format (no AM/PM), skipping');
          continue;
        }
        
        final bool existingIsPM = existingTimeStr.toLowerCase().contains('pm');
        final String existingTimeWithoutAmPm = existingTimeStr.replaceAll(RegExp(r'[\s]*[AaPp][Mm]'), '');
        final List<String> existingTimeParts = existingTimeWithoutAmPm.split(':');
        
        if (existingTimeParts.length != 2) {
          print('Existing booking has invalid time format (not HH:MM), skipping');
          continue;
        }
        
        int existingHours = int.parse(existingTimeParts[0]);
        int existingMinutes = int.parse(existingTimeParts[1].trim());
        
        // Convert to 24-hour format if PM
        if (existingIsPM && existingHours < 12) {
          existingHours += 12;
        } else if (!existingIsPM && existingHours == 12) {
          existingHours = 0;
        }
        
        print('Existing time (24h format): $existingHours:$existingMinutes');
        
        // Get existing booking duration
        final String existingDurationStr = data['matchDuration'];
        print('Existing duration string: $existingDurationStr');
        
        // Parse the duration (e.g., "1h  -  30m")
        String existingDurStr = existingDurationStr.replaceAll('h  -  ', ':').replaceAll('m', '');
        final List<String> existingDurationParts = existingDurStr.split(':');
        if (existingDurationParts.length != 2) {
          print('Existing booking has invalid duration format, skipping');
          continue;
        }
        
        final int existingDurationHours = int.parse(existingDurationParts[0]);
        final int existingDurationMinutes = int.parse(existingDurationParts[1]);
        print('Existing duration: $existingDurationHours hours, $existingDurationMinutes minutes');
        
        // Calculate total minutes for existing booking
        final int existingStartMinutes = existingHours * 60 + existingMinutes;
        final int existingEndMinutes = existingStartMinutes + existingDurationHours * 60 + existingDurationMinutes;
        print('Existing booking: $existingStartMinutes - $existingEndMinutes (in minutes from midnight)');
        
        // Check for overlap
        bool hasOverlap = false;
        
        // Case 1: New booking starts during existing booking
        if (newBookingStartMinutes >= existingStartMinutes && 
            newBookingStartMinutes < existingEndMinutes) {
          print('OVERLAP: New booking starts during existing booking');
          hasOverlap = true;
        }
        
        // Case 2: New booking ends during existing booking
        if (newBookingEndMinutes > existingStartMinutes && 
            newBookingEndMinutes <= existingEndMinutes) {
          print('OVERLAP: New booking ends during existing booking');
          hasOverlap = true;
        }
        
        // Case 3: New booking completely covers existing booking
        if (newBookingStartMinutes <= existingStartMinutes && 
            newBookingEndMinutes >= existingEndMinutes) {
          print('OVERLAP: New booking completely covers existing booking');
          hasOverlap = true;
        }
        
        if (hasOverlap) {
          print('Time slot is not available due to overlap');
          return false; // Time slot is not available
        }
      }
      
      print('No time conflicts found, slot is available');
      return true;
    } catch (e) {
      print('Error checking time slot availability: $e');
      return false; // If there's an error, assume the slot is not available
    }
  }

  Map<String, dynamic>? stadiumData; // متغير يخزن بيانات الاستاد

  // Function to get unavailable time slots for the selected date
  Future<List<String>> getAvailableTimeSlots() async {
    List<String> unavailableTimes = [];
    
    try {
      // Query Firestore for bookings on the same day and stadium
      final QuerySnapshot bookingsOnSameDay = await FirebaseFirestore.instance
          .collection('bookings')
          .where('stadiumID', isEqualTo: widget.stadiumID)
          .where('matchDate', isEqualTo: matchDate)
          .get();
      
      print('Found ${bookingsOnSameDay.docs.length} bookings on the same day for this stadium');
      
      // If no bookings on this day, all times are available
      if (bookingsOnSameDay.docs.isEmpty) {
        return unavailableTimes;
      }
      
      // Process each booking to find unavailable times
      for (var doc in bookingsOnSameDay.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        // Get existing booking time
        final String existingTimeStr = data['matchTime'];
        print('Existing time string: $existingTimeStr');
        
        // Skip if time format is invalid
        if (!existingTimeStr.toLowerCase().contains('am') && 
            !existingTimeStr.toLowerCase().contains('pm')) {
          print('Existing booking has invalid time format (no AM/PM), skipping');
          continue;
        }
        
        // Parse the existing booking time
        final bool existingIsPM = existingTimeStr.toLowerCase().contains('pm');
        final String existingTimeWithoutAmPm = existingTimeStr.replaceAll(RegExp(r'[\s]*[AaPp][Mm]'), '');
        final List<String> existingTimeParts = existingTimeWithoutAmPm.split(':');
        
        if (existingTimeParts.length != 2) {
          print('Existing booking has invalid time format (not HH:MM), skipping');
          continue;
        }
        
        int existingHours = int.parse(existingTimeParts[0]);
        int existingMinutes = int.parse(existingTimeParts[1].trim());
        
        // Convert to 24-hour format if PM
        if (existingIsPM && existingHours < 12) {
          existingHours += 12;
        } else if (!existingIsPM && existingHours == 12) {
          existingHours = 0;
        }
        
        // Get existing booking duration
        final String existingDurationStr = data['matchDuration'];
        print('Existing duration string: $existingDurationStr');
        
        // Parse the duration (e.g., "1h  -  30m")
        String existingDurStr = existingDurationStr.replaceAll('h  -  ', ':').replaceAll('m', '');
        final List<String> existingDurationParts = existingDurStr.split(':');
        if (existingDurationParts.length != 2) {
          print('Existing booking has invalid duration format, skipping');
          continue;
        }
        
        final int existingDurationHours = int.parse(existingDurationParts[0]);
        final int existingDurationMinutes = int.parse(existingDurationParts[1]);
        
        // Calculate total minutes for existing booking
        final int existingStartMinutes = existingHours * 60 + existingMinutes;
        final int existingEndMinutes = existingStartMinutes + existingDurationHours * 60 + existingDurationMinutes;
        
        // Mark all 30-minute slots within this booking as unavailable
        for (int timeInMinutes = existingStartMinutes; timeInMinutes < existingEndMinutes; timeInMinutes += 30) {
          if (timeInMinutes % 30 != 0) continue; // Only consider 30-minute intervals
          
          int hours = timeInMinutes ~/ 60;
          int minutes = timeInMinutes % 60;
          
          // Convert to 12-hour format with AM/PM
          String period = hours >= 12 ? 'PM' : 'AM';
          int displayHours = hours % 12;
          if (displayHours == 0) displayHours = 12;
          
          String formattedTime = '$displayHours:${minutes.toString().padLeft(2, '0')} $period';
          unavailableTimes.add(formattedTime);
          print('Marked as unavailable: $formattedTime');
        }
      }
      
      return unavailableTimes;
    } catch (e) {
      print('Error getting available time slots: $e');
      return unavailableTimes;
    }
  }

  Future<void> getStudentData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('stadiums')
        .doc(widget.stadiumID)
        .get();
    setState(() {
      stadiumData = doc.data() as Map<String, dynamic>;
    });
  }

  @override
  void initState() {
    super.initState();
    getStudentData();
  }

  // Function to check if a specific duration is available for the selected time
  Future<List<Map<String, dynamic>>> getAvailableDurations() async {
    List<Map<String, dynamic>> durationOptions = [];
    
    // If no time is selected, all durations are available
    if (matchTime.isEmpty) {
      // Generate all possible duration options (1h to 6h with 30min intervals)
      for (int hour = 1; hour <= 6; hour++) {
        for (int minute = 0; minute < 60; minute += 30) {
          // Allow booking from 1 hour
          String durationText = "${hour}h  -  ${minute}m";
          durationOptions.add({
            'hours': hour,
            'minutes': minute,
            'text': durationText,
            'isAvailable': true
          });
        }
      }
      return durationOptions;
    }
    
    try {
      // Parse the selected time
      final bool isPM = matchTime.toLowerCase().contains('pm');
      final String timeWithoutAmPm = matchTime.replaceAll(RegExp(r'[\s]*[AaPp][Mm]'), '');
      final List<String> timeParts = timeWithoutAmPm.split(':');
      
      if (timeParts.length != 2) {
        print('Invalid time format: $matchTime');
        return durationOptions;
      }
      
      int bookingHours = int.parse(timeParts[0]);
      int bookingMinutes = int.parse(timeParts[1].trim());
      
      // Convert to 24-hour format if PM
      if (isPM && bookingHours < 12) {
        bookingHours += 12;
      } else if (!isPM && bookingHours == 12) {
        bookingHours = 0;
      }
      
      // Calculate booking start time in minutes from midnight
      final int bookingStartMinutes = bookingHours * 60 + bookingMinutes;
      
      // Query Firestore for bookings on the same day and stadium
      final QuerySnapshot bookingsOnSameDay = await FirebaseFirestore.instance
          .collection('bookings')
          .where('stadiumID', isEqualTo: widget.stadiumID)
          .where('matchDate', isEqualTo: matchDate)
          .get();
      
      // Calculate the end times of all existing bookings
      List<Map<String, int>> existingBookingTimes = [];
      
      for (var doc in bookingsOnSameDay.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        // Skip our own time slot
        if (data['matchTime'] == matchTime) continue;
        
        // Parse existing booking time
        final String existingTimeStr = data['matchTime'];
        final bool existingIsPM = existingTimeStr.toLowerCase().contains('pm');
        final String existingTimeWithoutAmPm = existingTimeStr.replaceAll(RegExp(r'[\s]*[AaPp][Mm]'), '');
        final List<String> existingTimeParts = existingTimeWithoutAmPm.split(':');
        
        if (existingTimeParts.length != 2) continue;
        
        int existingHours = int.parse(existingTimeParts[0]);
        int existingMinutes = int.parse(existingTimeParts[1].trim());
        
        // Convert to 24-hour format
        if (existingIsPM && existingHours < 12) {
          existingHours += 12;
        } else if (!existingIsPM && existingHours == 12) {
          existingHours = 0;
        }
        
        // Parse duration
        final String existingDurationStr = data['matchDuration'];
        String existingDurStr = existingDurationStr.replaceAll('h  -  ', ':').replaceAll('m', '');
        final List<String> existingDurationParts = existingDurStr.split(':');
        if (existingDurationParts.length != 2) continue;
        
        final int existingDurationHours = int.parse(existingDurationParts[0]);
        final int existingDurationMinutes = int.parse(existingDurationParts[1]);
        
        // Calculate start and end times in minutes
        final int existingStartMinutes = existingHours * 60 + existingMinutes;
        final int existingEndMinutes = existingStartMinutes + existingDurationHours * 60 + existingDurationMinutes;
        
        existingBookingTimes.add({
          'start': existingStartMinutes,
          'end': existingEndMinutes
        });
      }
      
      // Generate all possible duration options (1h to 6h with 30min intervals)
      for (int hour = 1; hour <= 6; hour++) {
        for (int minute = 0; minute < 60; minute += 30) {
          // Allow booking from 1 hour
          
          // Calculate end time for this duration
          final int durationInMinutes = hour * 60 + minute;
          final int bookingEndMinutes = bookingStartMinutes + durationInMinutes;
          
          // Check if this duration would overlap with any existing booking
          bool isAvailable = true;
          for (var booking in existingBookingTimes) {
            // Check for overlap
            final int startTime = booking['start'] as int;
            final int endTime = booking['end'] as int;
            if (bookingEndMinutes > startTime && bookingStartMinutes < endTime) {
              isAvailable = false;
              break;
            }
          }
          
          // Check if booking would extend past midnight (not allowed)
          if (bookingEndMinutes > 24 * 60) {
            isAvailable = false;
          }
          
          String durationText = "${hour}h  -  ${minute}m";
          durationOptions.add({
            'hours': hour,
            'minutes': minute,
            'text': durationText,
            'isAvailable': isAvailable
          });
        }
      }
      
      return durationOptions;
    } catch (e) {
      print('Error checking available durations: $e');
      return durationOptions;
    }
  }

  void showDurationPicker(BuildContext context) {
    // First check if we have a time selected
    if (matchTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Provider.of<LanguageProvider>(context, listen: false).isArabic
              ? 'الرجاء اختيار الوقت أولاً'
              : 'Please select a time first'
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
    // Get available durations
    getAvailableDurations().then((durationOptions) {
      // Close loading dialog
      Navigator.of(context).pop();
      
      final isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
      
      // Show custom duration picker dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              isArabic ? 'اختر مدة الحجز' : 'Select Duration',
              style: TextStyle(
                fontFamily: 'eras-itc-demi',
                fontSize: 18.0,
                color: mainColor,
              ),
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isArabic 
                      ? 'المدد الرمادية غير متاحة للحجز' 
                      : 'Gray durations are unavailable for booking',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.0,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: durationOptions.length,
                      itemBuilder: (context, index) {
                        final option = durationOptions[index];
                        final bool isAvailable = option['isAvailable'];
                        final String durationText = option['text'];
                        
                        return GestureDetector(
                          onTap: isAvailable 
                            ? () {
                                // Calculate cost
                                final hours = option['hours'] as int;
                                final minutes = option['minutes'] as int;
                                calcCost = testCost * (hours + minutes / 60);
                                
                                // Set the selected duration and close dialog
                                setState(() {
                                  matchDuration = durationText;
                                  matchCost = calcCost;
                                });
                                Navigator.of(context).pop();
                              }
                            : () {
                                // Show message that duration is unavailable
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isArabic
                                        ? 'هذه المدة غير متاحة للحجز'
                                        : 'This duration is unavailable for booking'
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: isAvailable 
                                ? greenGradientColor 
                                : null,
                              color: isAvailable 
                                ? null 
                                : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              durationText,
                              style: TextStyle(
                                color: isAvailable 
                                  ? Colors.white 
                                  : Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
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
                  isArabic ? 'إلغاء' : 'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (stadiumData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 28,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(isArabic ? "إلغاء الدفع" : "Discard Payment"),
                    content: Text(isArabic
                        ? "هل أنت متأكد من إلغاء الدفع؟"
                        : "Are you sure you want to discard the payment?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(isArabic ? "عودة" : "Return"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text(isArabic ? "إلغاء" : "Discard",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(
                      color: mainColor.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width * 0.0017,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // date
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchDate.isNotEmpty
                                        ? matchDate
                                        : "Select date",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: matchDate.isNotEmpty
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // time from : to
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchTime.isNotEmpty
                                        ? matchTime
                                        : "Select time",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: matchTime.isNotEmpty
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // duration
                              Row(
                                children: [
                                  Icon(Icons.timelapse,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchDuration.isNotEmpty
                                        ? matchDuration
                                        : "Select duration",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: matchDuration.isNotEmpty
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // cost
                              Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      color: mainColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    matchCost > 0
                                        ? "$matchCost LE"
                                        : "Select cost",
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 14,
                                      color: (matchCost.toString().isNotEmpty &&
                                              matchCost > 0)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Expanded(
                        child: Image.asset('assets/payment/imgs/tickets.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.3),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.09,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.width * 0.06,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/payment/stadium-icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      stadiumData!['name'],
                      style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                    Spacer(),
                    Text(
                      stadiumData!['price'].toString() + '.00 LE',
                      style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: mainColor,
                      size: MediaQuery.of(context).size.width * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      stadiumData!['location'],
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: mainColor,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                        SizedBox(width: 5),
                        Text(
                          stadiumData!['rating'].toString(),
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontFamily: "eras-itc-demi"),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "(218)",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 124, 124, 124),
                            fontSize: MediaQuery.of(context).size.width * 0.027,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'booking details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40.0),

                // date, time, duration
                // payment way: fawary, credit card, cashr
                Create_RequiredInput(
                  isReadOnly: true,
                  initValue: matchDate,
                  add_prefix:
                      Icon(Icons.calendar_today, color: mainColor, size: 18.0),
                  textInputType: TextInputType.text,
                  lableText: "match date",
                  onTap: () {
                    BottomPicker.date(
                        pickerTitle: Text(
                          "Select Date within the next 30 days",
                          style: TextStyle(
                              fontFamily: 'eras-itc-demi', fontSize: 14.0),
                        ),
                        titlePadding: EdgeInsets.only(
                          top: 4.0,
                          left: 4.0,
                        ),
                        minDateTime: DateTime.now(),
                        maxDateTime:
                            DateTime.now().add(const Duration(days: 30)),
                        initialDateTime:
                            DateTime.now().add(const Duration(days: 1)),
                        onSubmit: (selectedDate) {
                          setState(() {
                            matchDate =
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                          });
                        },
                        buttonStyle: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(10),
                        )).show(context);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Create_RequiredInput(
                        isReadOnly: true,
                        initValue: matchTime,
                        add_prefix: Icon(Icons.access_time,
                            color: mainColor, size: 18.0),
                        textInputType: TextInputType.text,
                        lableText: "time",
                        onTap: () {
                          // First check if we have a date selected
                          if (matchDate.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isArabic
                                    ? 'الرجاء اختيار التاريخ أولاً'
                                    : 'Please select a date first'
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          
                          // Show loading indicator
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          
                          // Get all bookings for this stadium on this date
                          getAvailableTimeSlots().then((unavailableTimes) {
                            // Close loading dialog
                            Navigator.of(context).pop();
                            
                            // Show custom time picker dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    isArabic ? 'اختر الوقت' : 'Select Time',
                                    style: TextStyle(
                                      fontFamily: 'eras-itc-demi',
                                      fontSize: 18.0,
                                      color: mainColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Container(
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          isArabic 
                                            ? 'الأوقات الرمادية غير متاحة للحجز' 
                                            : 'Gray times are unavailable for booking',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: GridView.builder(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 2.0,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                            itemCount: 36, // 6 AM to 11:30 PM in 30-minute intervals
                                            itemBuilder: (context, index) {
                                              // Calculate time from index
                                              int hour = (index ~/ 2) + 6; // Start from 6 AM
                                              int minute = (index % 2) * 30;
                                              
                                              // Format time for display
                                              int displayHour = hour % 12;
                                              if (displayHour == 0) displayHour = 12;
                                              String period = hour >= 12 ? 'PM' : 'AM';
                                              String formattedTime = '$displayHour:${minute.toString().padLeft(2, '0')} $period';
                                              
                                              // Check if this time is unavailable
                                              bool isUnavailable = unavailableTimes.contains(formattedTime);
                                              
                                              return GestureDetector(
                                                onTap: isUnavailable 
                                                  ? () {
                                                      // Show message that time is unavailable
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            isArabic
                                                              ? 'هذا الوقت غير متاح للحجز'
                                                              : 'This time is unavailable for booking'
                                                          ),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  : () {
                                                      // Set the selected time and close dialog
                                                      setState(() {
                                                        matchTime = formattedTime;
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: isUnavailable 
                                                      ? null 
                                                      : greenGradientColor,
                                                    color: isUnavailable 
                                                      ? Colors.grey[300] 
                                                      : null,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    formattedTime,
                                                    style: TextStyle(
                                                      color: isUnavailable 
                                                        ? Colors.grey[600] 
                                                        : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                                        isArabic ? 'قفل' : 'Close',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Create_RequiredInput(
                        isReadOnly: true,
                        initValue: matchDuration,
                        add_prefix:
                            Icon(Icons.timelapse, color: mainColor, size: 18.0),
                        textInputType: TextInputType.text,
                        lableText: "duration",
                        onTap: () => showDurationPicker(context),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40.0),
                // AnimatedContainer(
                //   duration: Duration(milliseconds: 300),
                //   padding: EdgeInsets.all(16.0),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       color: mainColor.withOpacity(0.2),
                //       width: 1,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.08),
                //         blurRadius: 4,
                //         offset: Offset(0, 2),
                //       ),
                //     ],
                //   ),
                //   child: AnimatedSize(
                //     duration: Duration(milliseconds: 300),
                //     curve: Curves.easeInOut,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Flexible(
                //           flex: creditCard ? 3 : 1,
                //           child: GestureDetector(
                //             onTap: () async {},
                //             child: AnimatedContainer(
                //               duration: Duration(milliseconds: 300),
                //               curve: Curves.ease,
                //               decoration: BoxDecoration(
                //                 gradient:
                //                     creditCard ? greenGradientColor : null,
                //                 color: creditCard ? null : Colors.transparent,
                //                 borderRadius: BorderRadius.circular(8),
                //               ),
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 10, horizontal: 0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.credit_card,
                //                       color: creditCard
                //                           ? Colors.white
                //                           : mainColor),
                //                   SizedBox(width: 8),
                //                   AnimatedSwitcher(
                //                     duration: Duration(milliseconds: 300),
                //                     transitionBuilder: (child, animation) =>
                //                         FadeTransition(
                //                             opacity: animation, child: child),
                //                     child: creditCard
                //                         ? Text(
                //                             "Credit Card",
                //                             key: ValueKey('creditCard'),
                //                             style: TextStyle(
                //                               fontFamily: 'eras-itc-demi',
                //                               fontSize: 14,
                //                               color: Colors.white,
                //                             ),
                //                           )
                //                         : SizedBox(width: 0, height: 0),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 8),
                //         Flexible(
                //           flex: fawry ? 3 : 1,
                //           child: GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 creditCard = false;
                //                 fawry = true;
                //                 cash = false;
                //                 paymentWay = "Fawry";
                //               });
                //             },
                //             child: AnimatedContainer(
                //               duration: Duration(milliseconds: 300),
                //               curve: Curves.ease,
                //               decoration: BoxDecoration(
                //                 gradient: fawry ? greenGradientColor : null,
                //                 color: fawry ? null : Colors.transparent,
                //                 borderRadius: BorderRadius.circular(8),
                //               ),
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 10, horizontal: 0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.account_balance_wallet,
                //                       color: fawry ? Colors.white : mainColor),
                //                   SizedBox(width: 8),
                //                   AnimatedSwitcher(
                //                     duration: Duration(milliseconds: 300),
                //                     transitionBuilder: (child, animation) =>
                //                         FadeTransition(
                //                             opacity: animation, child: child),
                //                     child: fawry
                //                         ? Text(
                //                             "Fawry",
                //                             key: ValueKey('fawry'),
                //                             style: TextStyle(
                //                               fontFamily: 'eras-itc-demi',
                //                               fontSize: 14,
                //                               color: Colors.white,
                //                             ),
                //                           )
                //                         : SizedBox(width: 0, height: 0),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 8),
                //         Flexible(
                //           flex: cash ? 3 : 1,
                //           child: GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 creditCard = false;
                //                 fawry = false;
                //                 cash = true;
                //                 paymentWay = "Cash";
                //               });
                //             },
                //             child: AnimatedContainer(
                //               duration: Duration(milliseconds: 300),
                //               curve: Curves.ease,
                //               decoration: BoxDecoration(
                //                 gradient: cash ? greenGradientColor : null,
                //                 color: cash ? null : Colors.transparent,
                //                 borderRadius: BorderRadius.circular(8),
                //               ),
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 10, horizontal: 0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Icon(Icons.money,
                //                       color: cash ? Colors.white : mainColor),
                //                   SizedBox(width: 8),
                //                   AnimatedSwitcher(
                //                     duration: Duration(milliseconds: 300),
                //                     transitionBuilder: (child, animation) =>
                //                         FadeTransition(
                //                             opacity: animation, child: child),
                //                     child: cash
                //                         ? Text(
                //                             "Cash",
                //                             key: ValueKey('cash'),
                //                             style: TextStyle(
                //                               fontFamily: 'eras-itc-demi',
                //                               fontSize: 14,
                //                               color: Colors.white,
                //                             ),
                //                           )
                //                         : SizedBox(width: 0, height: 0),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                // Visibility(
                //   visible: isFormValid(),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => Done()),
                //         );
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: mainColor,
                //         padding: EdgeInsets.symmetric(vertical: 15),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //       ),
                //       child: Text(
                //         'Continue',
                //         style: TextStyle(
                //           fontFamily: 'eras-itc-demi',
                //           fontSize: 16,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // SizedBox(height: 20),
                Create_GradiantGreenButton(
                    content: Text("verify booking",
                        style: TextStyle(
                            fontFamily: 'eras-itc-demi', fontSize: 18.0)),
                    onButtonPressed: () async {
                      if (!isFormValid()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
                        return;
                      }
                      
                      // Check if the selected time slot is available
                      final isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
                      final bool isAvailable = await isTimeSlotAvailable();
                      if (!isAvailable) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isArabic
                                ? 'هذا الوقت محجوز بالفعل. يرجى اختيار وقت آخر.'
                                : 'This time slot is already booked. Please choose another time.'
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      
                      // Show a message that we're proceeding with the booking
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isArabic
                              ? 'جاري المتابعة مع الحجز...'
                              : 'Proceeding with booking...'
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      );
                      
                      // Get username from email
                      final email =
                          FirebaseAuth.instance.currentUser?.email ?? '';
                      final username = email.split('@')[0];

                      final bookingDoc = await FirebaseFirestore.instance
                          .collection("bookings")
                          .add({
                        "stadiumID": widget.stadiumID,
                        "playerID": FirebaseAuth.instance.currentUser?.uid,
                        "matchDate": matchDate,
                        "matchTime": matchTime,
                        "matchDuration": matchDuration,
                        "matchCost": matchCost,
                        "isRated": false,
                      });
                      setState(() {
                        creditCard = true;
                        fawry = false;
                        cash = false;
                        paymentWay = "Credit Card";
                      });
                      // استدعاء دالة الدفع
                      try {
                        bool paymentSuccess = await PaymentManger.makePayment(
                          double.parse(stadiumData!['price'].toString()).toInt(),
                          "EGP",
                        );
                        if (paymentSuccess) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Done(
                                bookID: bookingDoc.id,
                                matchTime: matchTime,
                                matchDate: matchDate,
                                stadiumID: widget.stadiumID,
                                matchCost: matchCost.toString(),
                                matchDuration: matchDuration,
                              ),
                            ),
                          );
                        } else {
                          // المستخدم عمل Cancel أو قفل شاشة الدفع
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Payment cancelled by user.')),
                          );
                        }
                      } catch (e) {
                        // لو حصل Error حقيقي في الدفع
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Payment failed: $e')),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
