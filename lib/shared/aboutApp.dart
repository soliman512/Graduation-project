import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward();
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 34.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          backgroundImage,
          blackBackground,
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 1000),
              child: SlideTransition(
                position: _offsetAnimation,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 200.0),
                      Center(child: add_logo(110.0)),
                      const SizedBox(height: 10.0),
                      Add_AppName(font_size: 30.0, align: TextAlign.center, color: Colors.white),
                      const SizedBox(height: 20.0),
                      const Text(
                        'version: 1.0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'eras-itc-light',
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      const Divider(color: Color.fromARGB(20, 255, 255, 255)),
                      const SizedBox(height: 60.0),

                      _buildTextBlock(
                        icon: Icons.info_outline,
                        title: 'About',
                        content:
                            'Stadium Book is a smart and user-friendly mobile application designed to help football enthusiasts find and book nearby football fields with ease.',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.featured_play_list_rounded,
                        title: 'Features',
                        content:
                            '• Browse available football fields near you\n\n'
                            '• View real-time availability and book instantly\n\n'
                            '• Secure online payment system\n\n'
                            '• Rate and review stadiums\n\n'
                            '• Dashboard for owners',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.rocket_launch_rounded,
                        title: 'Mission',
                        content:
                            '• Simplify field booking\n\n'
                            '• Help both players and owners\n\n'
                            '• Seamless platform',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.help_outline_rounded,
                        title: 'How it Works',
                        content:
                            '• Register, search & book\n\n'
                            '• Instant confirmation\n\n'
                            '• Manage bookings easily',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.privacy_tip_rounded,
                        title: 'Privacy Policy',
                        content:
                            '• Your data is secure\n\n'
                            '• Used only to improve experience\n\n'
                            '• Full policy in app',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.gavel_rounded,
                        title: 'Terms & Conditions',
                        content:
                            '• Read and accept\n\n'
                            '• Covers usage, cancelation, rights\n\n'
                            '• Available inside app',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.contact_support_rounded,
                        title: 'Contact Us',
                        content:
                            '• Email: support@stadiumbook.app\n\n'
                            '• Phone: +20-xxx-xxx-xxxx',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.code_rounded,
                        title: 'Development',
                        content:
                            '• Built with Flutter\n\n'
                            '• Uses Firebase and Supabase\n\n'
                            '• Created by tech students',
                      ),

                      const SizedBox(height: 60.0),
                      _buildTextBlock(
                        icon: Icons.public_rounded,
                        title: 'Follow Us',
                        content:
                            '• Facebook: @StadiumBookApp\n\n'
                            '• Instagram: @stadiumbook\n\n'
                            '• Twitter: @stadiumbook',
                      ),

                      const SizedBox(height: 60.0),

                      // Check for Update Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          icon: const Icon(Icons.update, size: 16.0,),
                          label: const Text(
                            'Check for Update',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            // Handle update logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('You are on the latest version!')),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBlock({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 30.0, color: Colors.white),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8.0),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
