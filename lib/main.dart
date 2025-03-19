import 'package:flutter/material.dart';
import 'package:graduation_project_main/Edit_Stadium_stdOwner/EditStadium_stdowner.dart';
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';
import 'package:graduation_project_main/Home_stadium_owner/Ticket.dart';
import 'package:graduation_project_main/firebase_options.dart';
import 'package:graduation_project_main/home_loves_tickets_top/profileplayer.dart';
import 'package:graduation_project_main/provider/google_signin.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:graduation_project_main/welcome_signup_login/verify/verifyemail.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'home_loves_tickets_top/home/Home.dart';
import 'home_loves_tickets_top/loves/Favourites.dart';
import 'home_loves_tickets_top/tickets/Tickets.dart';
// import 'payment_successful_check/check_animation.dart';
import 'no_internetConnection/no_internetConnection.dart';
import 'payment/payment.dart';
import 'stadium_information_player_pg/stadium_information_player_pg.dart';
import 'stdown_addNewStd/stdwon_addNewStadium.dart';
import 'welcome_signup_login/Welcome.dart';
import 'welcome_signup_login/login_signup page/login_signupPlayer.dart';
import 'welcome_signup_login/login_signup page/login_signupStdOwner.dart';

import 'welcome_signup_login/loginPages/loginStadium.dart';
// import 'welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';

import 'welcome_signup_login/loginPages/loginPlayer.dart';

import 'welcome_signup_login/signUpPages//signup_Pg1_Player.dart';
import 'welcome_signup_login/signUpPages/signup_Pg2_Player.dart';

import 'welcome_signup_login/signUpPages/signup_Pg1_stdowner.dart';
import 'welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'welcome_signup_login/signUpPages/signup_pg3_stdowner_stdinfo.dart';
import 'welcome_signup_login/recorve account/RecorveAcount.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await supabase.Supabase.initialize(
    url: 'https://htoxbuyjqsxyxnhrdepl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0b3hidXlqcXN4eXhuaHJkZXBsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3ODk5OTAsImV4cCI6MjA1NzM2NTk5MH0.LgR8CpDcpXkOOZ14K1YZs6cS6SViQMy9JKskjSLuoOg',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<firebase_auth.User?>(
          stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Something went wrong"),
                ),
              );
            }
            if (snapshot.hasData) {
              firebase_auth.User? user = snapshot.data;
              if (user != null && !user.emailVerified) {
                return VerifyEmailPage();
              }
              return Home();
            }
            return Welcome();
          },
        ),
        // home: Welcome(),
        // initialRoute: '/home',
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
          '/home_owner': (context) => Home_Owner(),
          '/ticket_owner': (context) => Tickets_Owner(),

          // Booking Successful

          // '/booking_successful': (context) => BookingSuccessful(),

          // home_loves_tickets_top
          '/home': (context) => Home(),
          '/favourites': (context) => Favourites(),
          '/tickets': (context) => Tickets(),
          '/profilepage': (context) => ProfilePlayer(),

          //stadium information player show:
          '/stadium_information_player_pg': (context) =>
              Stadium_info_playerPG(),
          //payment
          '/payment': (context) => Payment(),

          // stadium owner
          '/stdWon_addNewStadium': (context) => AddNewStadium(),
          '/stdown_editStadium': (context) => EditStadium_stdown(),

          //no internet connection
          '/no_internetConnection': (context) => NoInternetConnection(),
        },
      ),
    );
  }
}
