import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';

class Signup_pg1_StdOwner extends StatelessWidget {
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
                Navigator.pushNamed(context, '/login_signup_stdOwner');
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
                    // title
                    Add_AppName(
                        font_size: 34.0,
                        align: TextAlign.center,
                        color: Colors.black),
                    //specific user
                    Text("Stadium owner",
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

                    //username
                    Create_Input(
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.none,
                        hintText: "Username",
                        addPrefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: mainColor,
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    //phone
                    Create_Input(
                        isPassword: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        hintText: "Phone Number",
                        addPrefixIcon: Icon(Icons.phone, color: mainColor)),
                    SizedBox(
                      height: 20.0,
                    ),
                    //date birh
                    GestureDetector(
                      onTap: () {},
                      child: Create_Input(
                          isReadOnly: true,
                          isPassword: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          hintText: "Date of birth",
                          addPrefixIcon:
                              Icon(Icons.calendar_today, color: mainColor)),
                    ),
                    SizedBox(
                      height: 55.0,
                    ),

                    //next
                    Create_GradiantGreenButton(
                        title: 'Next',
                        onButtonPressed: () {
                          Navigator.pushNamed(
                              context, '/signup_pg3_stdowner_stdinfo');
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
