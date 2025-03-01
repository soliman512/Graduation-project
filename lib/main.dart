
import 'package:flutter/material.dart';
import 'package:graduation_project_lastversion/Edit_Stadium_stdOwner/EditStadium_stdowner.dart';
import 'package:graduation_project_lastversion/home_loves_tickets_top/home/Home.dart';
import 'package:graduation_project_lastversion/home_loves_tickets_top/loves/Favourites.dart';
import 'package:graduation_project_lastversion/home_loves_tickets_top/tickets/Tickets.dart';
import 'package:graduation_project_lastversion/no_internetConnection/no_internetConnection.dart';
import 'package:graduation_project_lastversion/payment/payment.dart';
import 'package:graduation_project_lastversion/stadium_information_player_pg/stadium_information_player_pg.dart';
import 'package:graduation_project_lastversion/stdown_addNewStd/stdwon_addNewStadium.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/Welcome.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/login_signup%20page/login_signupPlayer.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/login_signup%20page/login_signupStdOwner.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/loginPages/loginStadium.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/loginPages/loginPlayer.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/signUpPages/signup_Pg1_Player.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/signUpPages/signup_Pg2_Player.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/signUpPages/signup_Pg1_stdowner.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/signUpPages/signup_pg3_stdowner_stdinfo.dart';
import 'package:graduation_project_lastversion/welcome_signup_login/recorve%20account/RecorveAcount.dart';

void main() {
  runApp(MyApp());
}

//useful icons and images:


RichText appNameLogo = RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
      style: TextStyle(
          color: Color(0xffffffff),
          fontFamily: "eras-itc-bold",
          fontWeight: FontWeight.w900,
          fontSize: 48.0),
      children: [
        TextSpan(text: "V"),
        TextSpan(text: "á", style: TextStyle(color: Color(0xff00B92E))),
        TextSpan(text: "monos"),
      ]),
);



//drawer options

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: Welcome(),
      initialRoute: '/Welcome',
      routes: {
        '/Welcome': (context) => Welcome(), //done
//login and signup
        '/login_signup_player': (context) => Login_Signup_player(), //done
        '/login_signup_stdOwner': (context) => Login_Signup_stdOwner(), //done

        '/login_player': (context) => Login_player(), //done
        '/login_stadium': (context) => Login_Stadiumonwer(), //done

        '/Recorve_account': (context) => Recorve_Account(),

        '/sign_up_pg1_player': (context) => Signup_pg1_player(),
        '/sign_up_pg2_player': (context) => Signup_pg2_player(),

        '/sign_up_pg1_stdowner': (context) => Signup_pg1_StdOwner(),
        '/sign_up_pg2_stdowner': (context) => Signup_pg2_StdOwner(),
        '/signup_pg3_stdowner_stdinfo': (context) => Signup_pg3_StdOwner_stdInfo(),

// Booking Successful

        // '/booking_successful': (context) => BookingSuccessful(),

// home_loves_tickets_top
        '/home': (context) => Home(),
        '/favourites': (context) => Favourites(),
        '/tickets': (context) => Tickets(),

//stadium information player show:
        '/stadium_information_player_pg': (context) => Stadium_info_playerPG(),
//payment
        '/payment': (context) => Payment(),



// stadium owner
        '/stdWon_addNewStadium' : (context) => AddNewStadium(),
        '/stdown_editStadium' : (context) => EditStadium_stdown(),


//no internet connection
         '/no_internetConnection': (context) => NoInternetConnection(),
      },
    );
  }
}
