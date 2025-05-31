<<<<<<< HEAD
// Import Flutter core packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:graduation_project_main/payment/payment.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graduation_project_main/shared/aboutApp.dart';
import 'package:graduation_project_main/stripe_payment/stripe_keys.dart';
// import 'package:graduation_project_main/stdown_addNewStd/stdown_editStadium.dart';
import 'package:graduation_project_main/welcome_signup_login/recorve%20account/RecoverAcountSTU.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/addAccountImage_owner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

// Import Firebase configuration
import 'package:graduation_project_main/firebase_options.dart';

// Import providers
import 'package:graduation_project_main/provider/google_signin.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

// Import localization packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

// Import splash screen
import 'welcome_signup_login/splash/Splash.dart';

// Import screens
// Welcome and Authentication screens
import 'welcome_signup_login/Welcome.dart';
import 'welcome_signup_login/loginPages/loginStadium.dart';
import 'welcome_signup_login/loginPages/loginPlayer.dart';
import 'welcome_signup_login/signUpPages/signup_Pg1_Player.dart';
import 'welcome_signup_login/signUpPages/signup_Pg2_Player.dart';
import 'welcome_signup_login/signUpPages/signup_Pg1_stdowner.dart';
// import 'welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'welcome_signup_login/signUpPages/addAccountImage_player.dart';
import 'welcome_signup_login/recorve account/RecorveAcount.dart';

// Home screens
import 'home_loves_tickets_top/home/Home.dart';
import 'home_loves_tickets_top/loves/Favourites.dart';
import 'home_loves_tickets_top/tickets/Tickets.dart';
import 'home_loves_tickets_top/profileplayer.dart';
import 'home_loves_tickets_top/edit_profile.dart';

// Stadium owner screens
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';
import 'package:graduation_project_main/Home_stadium_owner/Ticket.dart';
import 'stdown_addNewStd/stdwon_addNewStadium.dart';

// Other screens
// import 'stadium_information_player_pg/stadium_information_player_pg.dart';
import 'no_internetConnection/no_internetConnection.dart';

/// Main function that initializes the application
/// Initializes Firebase and Supabase before running the app
Future<void> main() async {
  Stripe.publishableKey = ApiKeys.publishableKey;
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with project credentials
  Supabase.initialize(
      url: "https://htoxbuyjqsxyxnhrdepl.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0b3hidXlqcXN4eXhuaHJkZXBsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3ODk5OTAsImV4cCI6MjA1NzM2NTk5MH0.LgR8CpDcpXkOOZ14K1YZs6cS6SViQMy9JKskjSLuoOg");

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize language provider
  final languageProvider = LanguageProvider();
  await languageProvider.initLanguage();

  // Run the application
  runApp(MyApp(languageProvider: languageProvider));
}

/// Root widget of the application
/// Sets up providers and defines the main navigation structure
class MyApp extends StatelessWidget {
  final LanguageProvider languageProvider;

  const MyApp({Key? key, required this.languageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            locale: languageProvider.currentLocale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            home: Splash(),
            routes: {
              '/splash': (context) => Splash(),
              '/Welcome': (context) => Welcome(),
              '/login_player': (context) => Login_player(),
              '/login_stadium': (context) => Login_Stadiumonwer(),
              '/Recorve_account': (context) => Recorve_Account(),
              '/Recorve_account_STU': (context) => Recorve_Account_STU(),
              '/sign_up_pg1_player': (context) => Signup_pg1_player(),
              '/addAccountImage_player': (context) => addAccountImage_player(),
              '/sign_up_pg2_player': (context) => Signup_pg2_player(),
              '/sign_up_pg1_stdowner': (context) => Signup_pg1_StdOwner(),
              '/addAccountImage_owner': (context) => addAccountImage_owner(),
              '/home_owner': (context) => Home_Owner(),
              '/ticket_owner': (context) => Tickets_Owner(),
              '/home': (context) => Home(),
              '/favourites': (context) => Favourites(),
              '/tickets': (context) => Tickets(),
              '/profilepage': (context) => ProfilePlayer(),
              '/edit_profile': (context) => EditProfile(),
              '/stdWon_addNewStadium': (context) => AddNewStadium(),
              // '/payment': (context) => Payment(
              //       stadiumID: ,
              //     ),
              '/no_internetConnection': (context) => NoInternetConnection(),
              '/aboutApp': (context) => AboutApp(),
            },
          );
        },
      ),
=======
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:welcome_signup_login/Edit_Stadium_stdOwner/EditStadium_stdowner.dart';

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
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
    );
  }
}
