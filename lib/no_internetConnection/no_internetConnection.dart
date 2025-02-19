import 'package:flutter/material.dart';
import 'package:welcome_signup_login/constants/constants.dart';
import 'package:welcome_signup_login/reusable_widgets/reusable_widgets.dart';

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: 'eras-itc-bold'),
              children: [
                TextSpan(text: 'V'),
                TextSpan(text: 'á', style: TextStyle(color: mainColor)),
                TextSpan(text: 'monos'),
              ]),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/no_internet_connection/imgs/noInternet.png'),
            // SizedBox(height: 20.0),
            Column(
              children: [
                Text('No Internet Connection',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontFamily: 'eras-itc-bold')),
                SizedBox(height: 20.0),
                Text(
                  'please check your internet connection \nand press reload to show your \nData and all the new',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 80.0),
            GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 64.0),
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: greenGradientColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Reconnect',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'eras-itc-bold',
                              fontSize: 20.0)),
                      SizedBox(
                        width: 30.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20.0,
                        child: Icon(Icons.refresh_rounded,
                            color: mainColor, size: 30.0),
                      ),
                      SizedBox(width:10.0),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
