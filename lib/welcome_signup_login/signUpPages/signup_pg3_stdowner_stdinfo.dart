import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';

class Signup_pg3_StdOwner_stdInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar language
          appBar: AppBar(
            centerTitle: true,
            title: Text("sign up",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up_pg1_stdowner');
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
              // ic
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFF000000),
                  )),
            ],
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          // title
                          Add_AppName(
                              font_size: 34.0,
                              align: TextAlign.center,
                              color: Colors.black),

                          //specific user
                          Text("Stadium information",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                // fontFamily: "eras-itc-bold",
                                fontWeight: FontWeight.w200,
                                fontSize: 20.0,
                              )),

                          SizedBox(
                            height: 10.0,
                          ),
                          //logo
                          logo,
                          //just for spacing
                          SizedBox(
                            height: 70.0,
                          ),

                          //inputs:

                          //stadium name
                          Create_Input(
                              isPassword: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "Stadium name",
                              addPrefixIcon: Icon(
                                Icons.sports_soccer_outlined,
                                color: mainColor,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          //stadium location
                          Create_Input(
                              isPassword: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.none,
                              hintText: "Stadium loaction",
                              addPrefixIcon: Icon(
                                Icons.share_location,
                                color: mainColor,
                              )),
                          SizedBox(
                            height: 55.0,
                          ),

                          //next
                          Create_GradiantGreenButton(
                              title: 'Next',
                              onButtonPressed: () {
                                Navigator.pushNamed(
                                    context, '/sign_up_pg2_stdowner');
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
