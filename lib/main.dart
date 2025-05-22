// Import Flutter core packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project_main/payment/payment.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graduation_project_main/shared/aboutApp.dart';
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
    );
  }
}
