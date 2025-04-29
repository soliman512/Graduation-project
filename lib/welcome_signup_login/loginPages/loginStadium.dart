import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';

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
    color: const Color.fromARGB(158, 44, 44, 44),
  );
  Icon showPasswordState = Icon(
    Icons.visibility,
    color: mainColor,
  );
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                Navigator.pushNamed(context, '/Welcome');
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
                    //logo
                    add_logo(80.0),
                    // title
                    Add_AppName(
                        font_size: 34.0,
                        align: TextAlign.center,
                        color: Colors.black),
                    //specific user
                    Text("stadium owner",
                        style: TextStyle(
                            color: Color.fromARGB(111, 0, 0, 0),
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            fontFamily: 'eras-itc-light')),
                    //just for space
                    SizedBox(
                      height: 60.0,
                    ),

                    //email address
                    Create_Input(
                      onChange: (value) {
                        this.email.text = value;
                      },
                      // controller: email,
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
                      height: 26.0,
                    ),

                    //password
                    Create_Input(
                      onChange: (value) {
                        this.password.text = value;
                      },
                      // controller: password,
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
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Recorve_account');
                        },
                        style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.transparent),
                            foregroundColor:
                                WidgetStateProperty.all(Color(0xffffffff))),
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
                      height: 40,
                    ),

                    //login
                    SizedBox(
                      height: 50.0,
                      child: Create_GradiantGreenButton(
                          content: Text(
                            'login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontFamily: 'eras-itc-bold'),
                          ),
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/home_owner');
                          }),
                    ),
                    SizedBox(
                      height: 26.0,
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
                          height: 1.0,
                          width: 145.0,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    //another ways to login
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 34.0),
                      width: double.infinity,
                      // alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // spacing: ,
                        children: [
                          //google
                          Expanded(
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/welcome_signup_login/imgs/google.png",
                                      width: 32.0
                                    ),
                                    Text('google',
                                        style: TextStyle(
                                            color: Color(0xFFFF3D00),
                                            fontSize: 18.0)),
                                  ],
                                ),
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(2),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.0),
                          //facebook
                          Expanded(
                            child: SizedBox(
                              height:60.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Wrap(
                                  children: [
                                    Image.asset(
                                      "assets/welcome_signup_login/imgs/facebook.png",
                                      width: 32.0,
                                    ),
                                    Text('facebook',
                                        style: TextStyle(
                                            color: Color(0xFF0680DD),
                                            fontSize: 18.0)),
                                  ],
                                ),
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(2),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60.0),
                    //don't have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('don\'t have account? ',style: TextStyle(color:Colors.black, fontSize:16.0,fontWeight: FontWeight.w300)),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, '/sign_up_pg1_stdowner');
                        }, child: Text('sign up', style: TextStyle(color:mainColor, fontSize:16.0, )))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
