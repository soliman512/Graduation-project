import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../constants/constants.dart';

class EditStadium_stdown extends StatefulWidget {
  const EditStadium_stdown({Key? key}) : super(key: key);

  @override
  State<EditStadium_stdown> createState() => _EditStadium_stdownState();
}

class _EditStadium_stdownState extends State<EditStadium_stdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  fontFamily: 'eras-itc-bold'),
              children: [
                TextSpan(text: 'E', style: TextStyle(color: mainColor)),
                TextSpan(text: 'dit'),
                TextSpan(text: ' S', style: TextStyle(color: mainColor)),
                TextSpan(text: 'Tadium'),
              ]),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/stdWon_addNewStadium');
            },
            icon: Image.asset('assets/welcome_signup_login/imgs/back.png')),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 25.0, 10.0, 25.0),
            padding: EdgeInsets.only(top: 6.0),
            height: 30.0,
            width: 60.0,
            decoration: BoxDecoration(
                gradient: greenGradientColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text('Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        )),
                  ),
                  Image.asset('assets/editstadium_stdown/imgs/bi_save.png'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Wrap(
                spacing: 10.0,
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: greenGradientColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/editstadium_stdown/imgs/addNewImg.png'),
                        Text('add new Image',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w200)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
