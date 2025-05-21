import 'package:flutter/material.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 4),
    content: Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Image.asset(
              "assets/welcome_signup_login/imgs/logo.png",
              width: 30.0,
            ),
            Text(text),
          ],
        ),
      ),
    ),
    action: SnackBarAction(
        label: Provider.of<LanguageProvider>(context, listen: false).currentLocale.languageCode == 'ar' ? 'إغلاق' : 'Close', textColor: Color(0xff00B92E), onPressed: () {}),
  ));
}
