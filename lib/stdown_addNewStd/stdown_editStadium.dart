import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';
// import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';
// import 'package:image_picker/image_picker.dart';

class EditStadium_stdown extends StatefulWidget {
  final StadiumCard stadiumSelectedToEdit;
  EditStadium_stdown(this.stadiumSelectedToEdit);

  @override
  State<EditStadium_stdown> createState() => _EditStadium_stdownState();
}

class _EditStadium_stdownState extends State<EditStadium_stdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontFamily: 'eras-itc-bold',
            ),
            children: [
              TextSpan(text: 'E', style: TextStyle(color: mainColor)),
              TextSpan(text: 'dit'),
              TextSpan(text: ' S', style: TextStyle(color: mainColor)),
              TextSpan(text: 'Tadium'),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60.0),
              Container(
                width: double.infinity,
                height: 300.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Wrap(
                  spacing: 10.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/no_internetConnection');
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: mainColor.withOpacity(0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/editstadium_stdown/imgs/addNewImg.png',
                            ),
                            Text(
                              'add Images',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (int i = 0;
                        i < widget.stadiumSelectedToEdit.selectedImages.length;
                        i++)
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Image.asset(
                          widget.stadiumSelectedToEdit.selectedImages[i] as String,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
