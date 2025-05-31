import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget buildSettingCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? mainColor,
                size: 24,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'eras-itc-demi',
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  // fontFamily: 'eras-itc-demi',
                  color: const Color.fromARGB(221, 189, 189, 189),
                ),
              ),
            ),
            Expanded(
              child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            ),
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isArabic ? 'الإعدادات' : 'Settings',
          style: TextStyle(
            fontFamily: 'eras-itc-demi',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: mainColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? 'Guest',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'eras-itc-demi',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Not signed in',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Divider(height: 1),

            // Account Section
            // buildSectionTitle(isArabic ? 'الحساب' : 'Account'),
            buildSettingCard(
              context: context,
              title: isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile',
              icon: Icons.person_outline,
              onTap: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            buildSettingCard(
              context: context,
              title: isArabic ? 'تغيير كلمة المرور' : 'Change Password',
              icon: Icons.lock_outline,
              onTap: () {
                // TODO: Implement password change
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isArabic ? 'قريباً' : 'Coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Preferences Section
            buildSectionTitle(isArabic ? 'التفضيلات' : 'Preferences'),
            buildSettingCard(
              context: context,
              title: isArabic ? 'اللغة' : 'Language',
              icon: Icons.language,
              onTap: () async {
                try {
                  final languageProvider =
                      Provider.of<LanguageProvider>(context, listen: false);
                  await languageProvider.toggleLanguage();

                  // Show feedback about the language change
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          languageProvider.isArabic
                              ? 'تم تغيير اللغة إلى العربية'
                              : 'Language changed to English',
                          style: TextStyle(fontFamily: 'eras-itc-bold'),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: mainColor,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isArabic
                              ? 'حدث خطأ أثناء تغيير اللغة'
                              : 'Error changing language',
                          style: TextStyle(fontFamily: 'eras-itc-bold'),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            buildSettingCard(
              context: context,
              title: isArabic ? 'الإشعارات' : 'Notifications',
              icon: Icons.notifications_outlined,
              onTap: () {
                // TODO: Implement notifications settings
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isArabic ? 'قريباً' : 'Coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Support Section
            buildSectionTitle(isArabic ? 'الدعم' : 'Support'),
            buildSettingCard(
              context: context,
              title: isArabic ? 'المساعدة' : 'Help & Support',
              icon: Icons.help_outline,
              onTap: () {
                // TODO: Implement help & support
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isArabic ? 'قريباً' : 'Coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            buildSettingCard(
              context: context,
              title: isArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                // TODO: Implement privacy policy
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isArabic ? 'قريباً' : 'Coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            buildSettingCard(
              context: context,
              title: isArabic ? 'تسجيل الخروج' : 'Sign Out',
              icon: Icons.logout,
              iconColor: Colors.red,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/Welcome',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
