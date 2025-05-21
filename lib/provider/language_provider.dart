import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  // Default language is English
  Locale _currentLocale = Locale('en');
  
  Locale get currentLocale => _currentLocale;
  
  // Initialize the language provider
  Future<void> initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('language_code') ?? 'en';
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
  
  // Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (_currentLocale.languageCode == 'en') {
      _currentLocale = Locale('ar');
      await prefs.setString('language_code', 'ar');
    } else {
      _currentLocale = Locale('en');
      await prefs.setString('language_code', 'en');
    }
    
    notifyListeners();
  }
  
  // Check if the current language is Arabic
  bool get isArabic => _currentLocale.languageCode == 'ar';
}
