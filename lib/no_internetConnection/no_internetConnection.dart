import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';

=======
import 'package:welcome_signup_login/constants/constants.dart';
import 'package:welcome_signup_login/reusable_widgets/reusable_widgets.dart';
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
=======
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
<<<<<<< HEAD
                Text(isArabic ? "لا يوجد اتصال بالإنترنت" : "No Internet Connection",
=======
                Text('No Internet Connection',
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontFamily: 'eras-itc-bold')),
                SizedBox(height: 20.0),
                Text(
<<<<<<< HEAD
                  isArabic ? "يرجى التحقق من اتصالك بالإنترنت \n و الضغط على إعادة التحميل لعرض بياناتك \n و جميع البيانات الجديدة" : "please check your internet connection \nand press reload to show your \nData and all the new",
=======
                  'please check your internet connection \nand press reload to show your \nData and all the new',
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
<<<<<<< HEAD
                      Text(isArabic ? "إعادة التحميل" : "Reconnect",
=======
                      Text('Reconnect',
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
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
