import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../reusable_widgets/reusable_widgets.dart';

class Signup_pg2_StdOwner extends StatefulWidget {
  @override
  State<Signup_pg2_StdOwner> createState() => _Signup_pg2_StdOwnerState();
}

class _Signup_pg2_StdOwnerState extends State<Signup_pg2_StdOwner> {
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

  bool confirm_passwordVisible = true;
  Icon unShowConfirm = Icon(
    Icons.visibility,
    color: mainColor,
  );
  Icon ShowConfirm = Icon(
    Icons.visibility_off,
    color: mainColor,
  );
  Icon showConfirmState = Icon(
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
            title: Text("sign up",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup_pg3_stdowner_stdinfo');
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
                    SizedBox(
                      height: 70.0,
                    ),

                    //inputs:
                    //email
                    Create_Input(
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: "Email Address",
                        addPrefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: mainColor,
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    //password
                    Create_Input(
                        isPassword: visiblePassword,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Password",
                        addPrefixIcon:
                            Icon(Icons.password_rounded, color: mainColor),
                        addSuffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (showPasswordState == showPassword) {
                                  showPasswordState = unShowPassword;
                                  visiblePassword = true;
                                } else {
                                  showPasswordState = showPassword;
                                  visiblePassword = false;
                                }
                              });
                            },
                            icon: showPasswordState)),
                    SizedBox(
                      height: 20.0,
                    ),

                    //confirm password
                    Create_Input(
                        isPassword: confirm_passwordVisible,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        hintText: "Confirm password",
                        addPrefixIcon:
                            Icon(Icons.check_circle_outline, color: mainColor),
                        addSuffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (showConfirmState == ShowConfirm) {
                                  showConfirmState = unShowConfirm;
                                  confirm_passwordVisible = true;
                                } else {
                                  showConfirmState = ShowConfirm;
                                  confirm_passwordVisible = false;
                                }
                              });
                            },
                            icon: showConfirmState)),

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
                    //just for spacing
                    SizedBox(
                      height: 40.0,
                    ),
                    //sign up
                    Create_GradiantGreenButton(
                      title: 'Sign up',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
