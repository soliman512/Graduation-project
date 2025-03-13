// import 'package:flutter/material.dart';
// import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

class AddStadium {
  final String title;
  final String location;
  final String price;
  final String description;
  final String capacity;
  bool isWaterAvailable;
  bool isTrackAvailable;
  bool isGrassNormal;
  String timeStart;
  String timeEnd;
  // List days;
  List<String> daysSelected = [];

  List<XFile> selectedImages = [];

  AddStadium({
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
    required this.daysSelected,
    required this.selectedImages,
  });
}

List<AddStadium> stadiums = [];
