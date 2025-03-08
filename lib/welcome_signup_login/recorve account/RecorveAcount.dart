import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';

class Recorve_Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar language
          appBar: AppBar(
            centerTitle: true,
            title: Text("Recorve account",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Welcome');
                  },
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
                    SizedBox(
                      height: 10.0,
                    ),
                    //logo
                    logo,
                    //please check:
                    Container(
                        margin: EdgeInsets.only(top: 29.0),
                        child: Text(
                          "Please check your email",
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: "eras-itc-bold"),
                        )),

                    Container(
                        margin: EdgeInsets.only(top: 6.0),
                        child: Text(
                          "We’ve sent a code to helloworld@gmail.com",
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        )),

//text Fields

                    Container(
                      // width: double.infinity,
                      margin: EdgeInsets.only(right: 15),
                      // alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // inputs

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xA8FFFFFF),
                              ),
                              height: 60.0,
                              width: 60.0,
                              margin: EdgeInsets.only(top: 81.0, left: 20.0),
                              child: TextField(
                                focusNode: FocusNode(),
                                // cursorHeight: 30.0,
                                showCursor: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w300),
                                textInputAction: TextInputAction.next,
                                maxLength: 1,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    focusColor: mainColor,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mainColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Color(0x28000000),
                                        width: 1.0,
                                      ),
                                    )),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xA8FFFFFF),
                              ),
                              height: 60.0,
                              width: 60.0,
                              margin: EdgeInsets.only(top: 81.0, left: 20.0),
                              child: TextField(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                showCursor: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w300),
                                textInputAction: TextInputAction.next,
                                maxLength: 1,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusColor: mainColor,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mainColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Color(0x28000000),
                                        width: 1.0,
                                      ),
                                    )),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xA8FFFFFF),
                              ),
                              height: 60.0,
                              width: 60.0,
                              margin: EdgeInsets.only(top: 81.0, left: 20.0),
                              child: TextField(
                                // cursorHeight: 30.0,
                                showCursor: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w300),
                                textInputAction: TextInputAction.next,
                                maxLength: 1,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    focusColor: mainColor,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mainColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Color(0x28000000),
                                        width: 1.0,
                                      ),
                                    )),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xA8FFFFFF),
                              ),
                              height: 60.0,
                              width: 60.0,
                              margin: EdgeInsets.only(top: 81.0, left: 20.0),
                              child: TextField(
                                // cursorHeight: 30.0,
                                showCursor: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w300),
                                textInputAction: TextInputAction.done,
                                maxLength: 1,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.length == 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                    focusColor: mainColor,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mainColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Color(0x28000000),
                                        width: 1.0,
                                      ),
                                    )),
                              ),
                            ),
                          ]),
                    ),

                    SizedBox(
                      height: 74.0,
                    ),
                    //login
                    Create_GradiantGreenButton(
                      title: 'Verify',
                      onButtonPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
