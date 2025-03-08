import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

class Stadium extends StatelessWidget {
  // const Stadium({super.key});
  final String title;
  final String location;
  final String price;
  final String description;
  final String capacity;
  final bool isWaterAvailable;
  final bool isTrackAvailable;
  final bool isGrassNormal;
  final String timeStart;
  final String timeEnd;
  final List<String> days;
  final List<XFile> selectedImages;

  Stadium({
    required this.title,
    required this.location,
    required this.price,
    required this.description,
    required this.capacity,
    required this.isWaterAvailable,
    required this.isTrackAvailable,
    required this.isGrassNormal,
    required this.timeStart,
    required this.timeEnd,
    required this.days,
    required this.selectedImages,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Location: $location'),
          Text('Price: \$${price}'),
          Text('Description: $description'),
          Text('Capacity: $capacity'),
          Text('Water Available: ${isWaterAvailable ? "Yes" : "No"}'),
          Text('Track Available: ${isTrackAvailable ? "Yes" : "No"}'),
          Text('Grass Type: ${isGrassNormal ? "Normal" : "industry"}'),
          Text('Time: $timeStart - $timeEnd'),
          Text('Days: ${days.join(", ")}'),
          SizedBox(height: 8.0),
          Text('Selected Images:'),
          Column(
            children:
                selectedImages
                    .map((image) => Image.network(image.path))
                    .toList(),
          ),
        ],
      ),
    );
  }
}

List<Stadium> stadiums = [];

// ignore: must_be_immutable
class TestNewStadium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test New Stadium'),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              // Add your preview button functionality here
              Navigator.pushNamed(context, '/stdWon_addNewStadium');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [for (int i = 0; i < stadiums.length; i++) stadiums[i]],
          ),
        ),
      ),
    );
  }
}
