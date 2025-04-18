import 'package:flutter/material.dart';
import 'package:graduation_project_main/welcome_signup_login/Welcome.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isStart = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() => isStart = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Center(child: Image.asset('assets/splashBackground.png')),
          // animated container
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            color: const Color.fromARGB(255, 255, 255, 255),
            width: double.infinity,
            height: isStart ? 0 : MediaQuery.of(context).size.height,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  height: isStart ? 0.0 : 100.0,
                  child: null,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 140.0,
                  child: add_logo(115.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Add_AppName(
                      font_size: 30.0,
                      align: TextAlign.center,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
