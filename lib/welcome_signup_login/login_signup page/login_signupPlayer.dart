import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Login_Signup_player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        //app bar language
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Welcome');
            },
            icon: Image.asset(
              "assets/welcome_signup_login/imgs/back.png",
              color: Color(0xffffffff),
            ),
            // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
          ),
          toolbarHeight: 80.0,
          elevation: 0,
          backgroundColor: Color(0x00),
          //language
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.language,
                  color: Color(0xFFFFFFFF),
                )),
          ],
        ),

        body: Stack(
          fit: StackFit.expand,
          children: [
            //background
            backgroundImage,

            //shadow gradient
            blackBackground,
            //body
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //logo
                    SizedBox(
                      height: 180.0,
                    ),
                    big_logo,
                    // title
                    Add_AppName(
                        font_size: 48.0,
                        align: TextAlign.center,
                        color: Colors.white),
                    SizedBox(
                      height: 180.0,
                    ),

                    //login
                    Create_GradiantGreenButton(
                      title: "login",
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/login_player');
                      },
                    ),
                    SizedBox(
                      height: 28.0,
                    ),

                    //sign up
                    Create_WhiteButton(
                      title: 'Sign up',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/sign_up_pg1_player');
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
