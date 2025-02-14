import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../reusable_widgets/reusable_widgets.dart';

class Signup_pg2_player extends StatefulWidget {
  @override
  State<Signup_pg2_player> createState() => _Signup_pg2_playerState();
}

class _Signup_pg2_playerState extends State<Signup_pg2_player> {
  Icon checkBox = Icon(
    Icons.check_box_outline_blank,
    size: 20.0,
    color: Color(0xFF161616),
  );
  Icon checkedBox = Icon(
    Icons.check_box,
    size: 20.0,
    color: Color(0xff00B92E),
  );
  Icon checkBoxState = Icon(
    Icons.check_box_outline_blank,
    size: 20.0,
    color: Color(0xFF161616),
  );

  bool visiblePassword = true;
  Icon unShowPassword = Icon(Icons.visibility);
  Icon showPassword = Icon(Icons.visibility_off);
  Icon showPasswordState = Icon(Icons.visibility);

  bool confirm_passwordVisible = true;
  Icon unShowConfirm = Icon(Icons.visibility);
  Icon ShowConfirm = Icon(Icons.visibility_off);
  Icon showConfirmState = Icon(Icons.visibility);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar
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
                Navigator.pushNamed(context, '/sign_up_pg1_player');
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
                    Text("Player",
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

                    SizedBox(
                      height: 70.0,
                    ),
                    //inputs:

                    //username
                    Create_Input(
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hintText: "Email",
                      addPrefixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    //password
                    Create_Input(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: "Password",
                      addPrefixIcon: Icon(
                        Icons.password_rounded,
                        color: mainColor,
                      ),
                      isPassword: visiblePassword,
                      addSuffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                            showPasswordState =
                                showPasswordState == showPassword
                                    ? unShowPassword
                                    : showPassword;
                          });
                        },
                        icon: showPasswordState,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //confirm password
                    Create_Input(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: "Confirm Password",
                      addPrefixIcon: Icon(
                        Icons.check_circle_outlined,
                        color: mainColor,
                      ),
                      isPassword: confirm_passwordVisible,
                      addSuffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirm_passwordVisible = !confirm_passwordVisible;
                            showConfirmState = showConfirmState == ShowConfirm
                                ? unShowConfirm
                                : ShowConfirm;
                          });
                        },
                        icon: showConfirmState,
                        color: mainColor,
                      ),
                    ),

                    //check terms

                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (checkBoxState == checkBox) {
                                  checkBoxState = checkedBox;
                                } else {
                                  checkBoxState = checkBox;
                                }
                              });
                            },
                            icon: checkBoxState,
                          ),
                          Text("Agree to terms and conditions")
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 60.0,
                    ),
                    //sign up
                    Create_GradiantGreenButton(
                        title: 'Sign up',
                        onButtonPressed: () {
                          Navigator.pushNamed(context, '/home');
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
