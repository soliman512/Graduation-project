import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/constants/constants.dart';
import 'package:graduation_project_lastversion/reusable_widgets/reusable_widgets.dart';

class Login_Stadiumonwer extends StatefulWidget {
  @override
  State<Login_Stadiumonwer> createState() => _Login_StadiumonwerState();
}

class _Login_StadiumonwerState extends State<Login_Stadiumonwer> {
  bool visiblePassword = true;
  Icon unShowPassword = Icon(
    Icons.visibility,
    color: mainColor,
  );
  Icon showPassword = Icon(
    Icons.visibility_off,
    color: mainColor,
  );
  Icon showPasswordState = Icon(
    Icons.visibility,
    color: mainColor,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar
          appBar: AppBar(
            centerTitle: true,
            title: Text("login",
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
              icon: Image.asset("assets/welcome_signup_login/imgs/back.png"),
              color: Color(0xff000000),
            ),
            // icon: Image.asset("aassets/welcome_signup_login/imgs/ligh back.png"),

            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Colors.transparent,
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
                    Text("stadium owner",
                        style: TextStyle(
                          color: Color(0xB6000000),
                          // fontFamily: "eras-itc-bold",
                          fontWeight: FontWeight.w200,
                          fontSize: 20.0,
                        )),
                    //just for space
                    SizedBox(
                      height: 10.0,
                    ),
                    //logo
                    logo,
                    //just for space
                    SizedBox(
                      height: 52.0,
                    ),

                    //email address
                    Create_Input(
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: "Email Address",
                      addPrefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: mainColor,
                      ),
                    ),
                    //just for space
                    SizedBox(
                      height: 30.0,
                    ),

                    //password
                    Create_Input(
                      isPassword: visiblePassword,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: "Password",
                      addPrefixIcon: Icon(Icons.lock_outline, color: mainColor),
                      addSuffixIcon: IconButton(
                        icon: showPasswordState,
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                            showPasswordState =
                                showPasswordState == showPassword
                                    ? unShowPassword
                                    : showPassword;
                          });
                        },
                      ),
                    ),
                    //forgot
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(23, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Recorve_account');
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xffffffff))),
                        child: Text("Forgot your password ?",
                            style: TextStyle(
                                color: Color(0xff004FFB),
                                fontFamily: "eras-itc-demi",
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w900,
                                fontSize: 12.0)),
                      ),
                    ),

                    SizedBox(
                      height: 56,
                    ),

                    //login
                    Create_GradiantGreenButton(
                        title: 'Login',
                        onButtonPressed: () {
                          Navigator.pushNamed(context, '/stdWon_addNewStadium');
                        }),
                    SizedBox(
                      height: 40.0,
                    ),

                    // or line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Color(0xD7000000),
                          // thickness: 1,
                          // indent: 16.0,
                          // endIndent: 30.0,
                          height: 1.0,
                          width: 145.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                color: Color(0xff00B92E),
                                fontFamily: 'eras-itc-demi'),
                          ),
                        ),
                        Container(
                          color: Color(0xD7000000),
                          // thickness: 1,
                          // indent: 16.0,
                          // endIndent: 30.0,
                          height: 1.0,
                          width: 145.0,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30.0,
                    ),

                    //another ways to login
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // spacing: ,
                        children: [
                          //google
                          Container(
                            width: 100.0,
                            // margin: EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFFFF0000),
                                width: 2,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Image.asset(
                                "assets/welcome_signup_login/imgs/google.png",
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xffffffff))),
                            ),
                          ),

                          //twitter
                          Container(
                            width: 80.0,
                            // margin: EdgeInsets.only(left: 20.0),
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF000000),
                                width: 2,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Image.asset(
                                "assets/welcome_signup_login/imgs/icons8-twitter-100.png",
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xffffffff))),
                            ),
                          ),

                          //facebook
                          Container(
                            width: 100.0,
                            // margin: EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF0077FF),
                                width: 2,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Image.asset(
                                "assets/welcome_signup_login/imgs/facebook.png",
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xffffffff))),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
