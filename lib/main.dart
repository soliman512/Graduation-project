// Import Flutter core packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graduation_project_main/stdown_addNewStd/stdown_editStadium.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

// Import Firebase configuration
import 'package:graduation_project_main/firebase_options.dart';

// Import providers
import 'package:graduation_project_main/provider/google_signin.dart';

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
import 'welcome_signup_login/signUpPages/signup_pg2_stdowner.dart';
import 'welcome_signup_login/signUpPages/addAccountImage_player.dart';
import 'welcome_signup_login/verify/verifyemail.dart';
import 'welcome_signup_login/recorve account/RecorveAcount.dart';

// Home screens
import 'home_loves_tickets_top/home/Home.dart';
import 'home_loves_tickets_top/loves/Favourites.dart';
import 'home_loves_tickets_top/tickets/Tickets.dart';
import 'home_loves_tickets_top/profileplayer.dart';

// Stadium owner screens
import 'package:graduation_project_main/Home_stadium_owner/Home_owner.dart';
import 'package:graduation_project_main/Home_stadium_owner/Ticket.dart';
import 'stdown_addNewStd/stdwon_addNewStadium.dart';

// Other screens
import 'stadium_information_player_pg/stadium_information_player_pg.dart';
import 'payment/payment.dart';
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

  // Run the application
  runApp(MyApp());
}

/// Root widget of the application
/// Sets up providers and defines the main navigation structure
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide Google Sign-In functionality throughout the app
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // StreamBuilder to handle authentication state changes
        home: StreamBuilder<firebase_auth.User?>(
          stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Show loading indicator while checking auth state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            // Show error message if something went wrong
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text("Something went wrong"),
                ),
              );
            }

            // Handle authenticated user
            if (snapshot.hasData) {
              firebase_auth.User? user = snapshot.data;
              // Redirect to email verification if needed
              if (user != null && !user.emailVerified) {
                return VerifyEmailPage();
              }
              return Home();
            }

            // Show welcome screen for unauthenticated users
            return Welcome();
          },
        ),

        // Define all available routes in the application
        routes: {
          '/splash': (context) => Splash(),
          // Welcome and Authentication routes
          '/Welcome': (context) => Welcome(),
          '/login_player': (context) => Login_player(),
          '/login_stadium': (context) => Login_Stadiumonwer(),
          '/Recorve_account': (context) => Recorve_Account(),

          // Player signup routes
          '/sign_up_pg1_player': (context) => Signup_pg1_player(),
          '/addAccountImage_player': (context) => addAccountImage_player(),
          '/sign_up_pg2_player': (context) => Signup_pg2_player(),

          // Stadium owner signup routes
          '/sign_up_pg1_stdowner': (context) => Signup_pg1_StdOwner(),
          '/sign_up_pg2_stdowner': (context) => Signup_pg2_StdOwner(),

          // Stadium owner routes
          '/home_owner': (context) => Home_Owner(),
          '/ticket_owner': (context) => Tickets_Owner(),

          // Main app routes
          '/home': (context) => Home(),
          '/favourites': (context) => Favourites(),
          '/tickets': (context) => Tickets(),
          '/profilepage': (context) => ProfilePlayer(),

          // Stadium information and management
          '/stadium_information_player_pg': (context) =>
              Stadium_info_playerPG(),
          '/stdWon_addNewStadium': (context) => AddNewStadium(),
          '/stdown_editStadium': (context) => EditStadium_stdown(),

          // Payment and utility routes
          '/payment': (context) => Payment(),
          '/no_internetConnection': (context) => NoInternetConnection(),
        },
      ),
    );
  }
}
