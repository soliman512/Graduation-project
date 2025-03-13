import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/stadiums/stadiums.dart';
import 'package:graduation_project_lastversion/stdown_addNewStd/editStadium.dart';

class HomeStdTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Student Test'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              for (var stadium in stadiums)
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditStadium(stadium: stadium,) ));
                  },
                  child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Name: ${stadium.title}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('Location: ${stadium.location}'),
                    SizedBox(height: 5),
                    Text('Price: ${stadium.price}'),
                    SizedBox(height: 10),
                    Image.file(
                          File(stadium.selectedImages[0].path),
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
