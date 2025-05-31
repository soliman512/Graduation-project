import 'package:flutter/material.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  //about variables
  Image openedAbout = Image.asset(
    'assets/welcome_signup_login/imgs/icons8-about-100.png',
    width: 30.0,
  );
  Image closedAbout = Image.asset(
    'assets/welcome_signup_login/imgs/close-about.png',
    width: 30.0,
  );
  Image aboutState = Image.asset(
    'assets/welcome_signup_login/imgs/icons8-about-100.png',
    width: 30.0,
  );

  bool visibleForAbout = false;

  int aboutDuration = 500;
  double WidthForabout = 0.0;
  double aboutBackOpacity = 0;
  double marginAnimatedAbouts = 1000;
  double aboutAppMarginTop = 1000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // leading: Icon(Icons.storm_outlined,size: 30, color: Color(0xffffffff),),
          // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
          automaticallyImplyLeading: false,

          toolbarHeight: 80.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              setState(() {
                if (aboutState == openedAbout) {
                  // aboutBackOpacity = 1;
                  aboutState = closedAbout;
                  marginAnimatedAbouts = 18.0;
                  aboutAppMarginTop = 60.0;
                  visibleForAbout = true;
                  WidthForabout = double.infinity;
                } else {
                  // aboutBackOpacity = 0;
                  aboutState = openedAbout;
                  marginAnimatedAbouts = 1000;
                  aboutAppMarginTop = 1000;
                  visibleForAbout = false;
                  WidthForabout = 0.0;
                }
              });

              // Navigator.pushNamed(context, '/no_internetConnection');
            },
            icon: aboutState,
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Toggle between English and Arabic
                final languageProvider =
                    Provider.of<LanguageProvider>(context, listen: false);
                languageProvider.toggleLanguage();

                // Show a snackbar to indicate the language change
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      languageProvider.isArabic
                          ? 'Language changed to English'
                          : 'تم تغيير اللغة إلى العربية',
                      style: TextStyle(fontFamily: 'eras-itc-bold'),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: mainColor,
                  ),
                );
              },
              icon: Icon(Icons.language, color: Color(0xFFFFFFFF)),
            ),
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 180.0),
                    //logo, name, and description
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        big_logo,
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Add_AppName(
                              font_size: 32.0,
                              align: TextAlign.left,
                              color: Color(0xffffffff),
                            ),
                            SizedBox(height: 12.0),
                            Container(
                              width: 200,
                              child: TypeWriterText(
                                text: Text(
                                  Provider.of<LanguageProvider>(context)
                                          .isArabic
                                      ? 'احجز أفضل الملاعب أو كن الأفضل فيها'
                                      : 'Book the best fields or be the best of them',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 12.0,
                                    fontFamily:
                                        Provider.of<LanguageProvider>(context)
                                                .isArabic
                                            ? 'Cairo'
                                            : 'eras-itc-demi',
                                  ),
                                  textAlign:
                                      Provider.of<LanguageProvider>(context)
                                              .isArabic
                                          ? TextAlign.right
                                          : TextAlign.left,
                                ),
                                duration: Duration(milliseconds: 50),
                                repeat: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 200,
                              child: TypeWriterText(
                                text: Text(
                                  Provider.of<LanguageProvider>(context)
                                          .isArabic
                                      ? 'واستمتع بخدمة لا مثيل لها'
                                      : 'and enjoy an unmatched service',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 12.0,
                                    fontFamily:
                                        Provider.of<LanguageProvider>(context)
                                                .isArabic
                                            ? 'Cairo'
                                            : 'eras-itc-demi',
                                  ),
                                  textAlign:
                                      Provider.of<LanguageProvider>(context)
                                              .isArabic
                                          ? TextAlign.right
                                          : TextAlign.left,
                                ),
                                duration: Duration(milliseconds: 50),
                                repeat: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 180.0),
                    Center(
                        child: Text(
                            Provider.of<LanguageProvider>(context).isArabic
                                ? 'ابدأ كـ'
                                : 'start as',
                            style: TextStyle(
                              fontFamily: Provider.of<LanguageProvider>(context)
                                      .isArabic
                                  ? 'Cairo'
                                  : 'eras-itc-bold',
                              color: Colors.white,
                              fontSize: 20.0,
                            ))),
                    SizedBox(
                      height: 38,
                    ),
                    //stadium owner button
                    Create_GradiantGreenButton(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Provider.of<LanguageProvider>(context).isArabic
                                ? 'مالك ملعب'
                                : 'Stadium Owner',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 22.0,
                              fontFamily: Provider.of<LanguageProvider>(context)
                                      .isArabic
                                  ? 'Cairo'
                                  : 'eras-itc-bold',
                            ),
                          ),
                          Image.asset(
                            'assets/welcome_signup_login/imgs/stadiumownOption.png',
                            width: 46.0,
                          ),
                        ],
                      ),
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/login_stadium');
                      },
                    ),

                    SizedBox(height: 28.0),

                    //player button
                    Create_GradiantGreenButton(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Provider.of<LanguageProvider>(context).isArabic
                                ? 'لاعب'
                                : 'player',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 22.0,
                              fontFamily: Provider.of<LanguageProvider>(context)
                                      .isArabic
                                  ? 'Cairo'
                                  : 'eras-itc-bold',
                            ),
                          ),
                          Image.asset(
                            'assets/welcome_signup_login/imgs/playerOption.png',
                            width: 46.0,
                          ),
                        ],
                      ),
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/login_player');
                      },
                    ),
                  ],
                ),
              ),
            ),

            // about
            Stack(
              children: [
                //about body
                AnimatedContainer(
                  duration: Duration(microseconds: 500),
                  width: WidthForabout,
                  color: Color(0xE0000000),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 86.0),
                        //stadium owner
                        AnimatedContainer(
                          duration: Duration(milliseconds: aboutDuration),
                          width: double.infinity,
                          height: 150.0,
                          margin: EdgeInsets.only(left: marginAnimatedAbouts),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(500.0),
                              bottomLeft: Radius.circular(500.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //stadium owner
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'مالك ملعب'
                                        : 'Stadium Owner',
                                    style: TextStyle(
                                      color: Color(0xff00B92E),
                                      fontSize: 24.0,
                                      fontFamily:
                                          Provider.of<LanguageProvider>(context)
                                                  .isArabic
                                              ? 'Cairo'
                                              : 'eras-itc-bold',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                //stadium owner info
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 34.0,
                                  ),
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'يمكن لمالكي الملاعب عرض ملاعبهم في التطبيق، مما يتيح للاعبين الحجز مباشرة منهم وإدارة الحجوزات بسهولة.'
                                        : 'Field owners can list their fields in the app, allowing players to book directly from them and manage reservations easily.',
                                    style: TextStyle(
                                      color: Color(0xff00B92E),
                                      fontSize: 14.0,
                                      fontFamily: 'eras-itc-demi',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 60.0),
                        // player
                        AnimatedContainer(
                          duration: Duration(milliseconds: aboutDuration),
                          width: double.infinity,
                          height: 150.0,
                          margin: EdgeInsets.only(right: marginAnimatedAbouts),
                          decoration: BoxDecoration(
                            gradient: greenGradientColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(500.0),
                              bottomRight: Radius.circular(500.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //player
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'لاعب'
                                        : 'Player',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 24.0,
                                      fontFamily:
                                          Provider.of<LanguageProvider>(context)
                                                  .isArabic
                                              ? 'Cairo'
                                              : 'eras-itc-bold',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                //player info
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 34.0,
                                  ),
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'يمكن للاعبين المسجلين في التطبيق حجز الملاعب، لعب المباريات، والاستمتاع بمزايا المنصة.'
                                        : "Players who register in the application will have access to book fields, play games, and enjoy the platform's features.",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14.0,
                                      fontFamily: 'eras-itc-demi',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // about application
                        AnimatedContainer(
                          duration: Duration(milliseconds: aboutDuration),
                          width: double.infinity,
                          height: 300.0,
                          margin: EdgeInsets.fromLTRB(
                            6.0,
                            aboutAppMarginTop,
                            6.0,
                            6.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //img ( logo )
                                Image.asset(
                                  'assets/welcome_signup_login/imgs/logo.png',
                                  width: 80.0,
                                ),
                                //name ( vamonos )
                                Container(
                                  width: double.infinity,
                                  // margin:
                                  // EdgeInsets.only(top: 34.0, bottom: 16.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: "eras-itc-bold",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24.0,
                                      ),
                                      children: [
                                        TextSpan(text: "V"),
                                        TextSpan(
                                          text: "á",
                                          style: TextStyle(
                                            color: Color(0xff00B92E),
                                          ),
                                        ),
                                        TextSpan(text: "monos"),
                                      ],
                                    ),
                                  ),
                                ),

                                //player info
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(20.0),
                                  child: Text(
                                    Provider.of<LanguageProvider>(context)
                                            .isArabic
                                        ? 'تطبيق فامونوس هو منصتك الشاملة لحجز الملاعب الرياضية بسهولة وسرعة. سواء كنت مالك ملعب أو لاعب، نوفر لك تجربة فريدة لإدارة الحجوزات، التواصل، والاستمتاع بالرياضة في أي وقت وأي مكان.'
                                        : 'Vamonos is your all-in-one platform for booking sports fields easily and quickly. Whether you are a field owner or a player, we provide you with a unique experience to manage reservations, communicate, and enjoy sports anytime and anywhere.',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 16.0,
                                      fontFamily:
                                          Provider.of<LanguageProvider>(context)
                                                  .isArabic
                                              ? 'Cairo'
                                              : 'eras-itc-bold',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
