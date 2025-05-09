import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';

class TicketCard extends StatelessWidget {
  final String stadiumName;
  final String? price;
  final String date;
  final String time;
  final bool isEnd;
  final String daysBefore;
  final double? width;

  const TicketCard({
    Key? key,
    required this.stadiumName,
    this.price,
    required this.date,
    required this.time,
    required this.isEnd,
    required this.daysBefore,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
          // Main ticket container
        Container(
          width: width,
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Stack(
            children: [
              // Faded football background, partially outside top-right
              Positioned(
                right: 0,
                top: 0,
                child: Opacity(
                  opacity: 0.010,
                  child: Icon(
                    Icons.sports_soccer,
                    size: 90,
                    color: mainColor,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Removed the left ball icon from here
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.stadium, color: Colors.green, size: 20),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                stadiumName.length > 14 ? stadiumName.substring(0, 14) : stadiumName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.green,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Price moved to a new row below
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.green, size: 15),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                date,
                                style: const TextStyle(fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Colors.green, size: 15),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Status and days before, compact and right-aligned
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          isEnd ? 'End' : 'Coming Soon',
                          style: TextStyle(
                            color: isEnd ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          daysBefore,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (price != null && price!.isNotEmpty) ...[
          Positioned(
            right: 20,
            bottom: 20,
            child: Text(
              '${price!}.00',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.green,
              ),
            ),
          ),
        ],
        
         // Ball icon outside top-left
        Positioned(
          top: -10,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: add_logo(40.0),
          ),
        ),
   
      ],
    );
  }
}
