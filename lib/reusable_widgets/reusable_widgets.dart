import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


class StadiumCard extends StatefulWidget {
  final String title;
  final String location;
  final String price;
  final int rating;
  final List<String> selectedImages;
  final VoidCallback? onTap;

  StadiumCard({
    Key? key,
    this.onTap,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.selectedImages,
  }) : super(key: key);

  @override
  State<StadiumCard> createState() => _StadiumCardState();
}

class _StadiumCardState extends State<StadiumCard> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final favDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.title)
        .get();

    setState(() {
      isFavorite = favDoc.exists;
    });
  }

  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.title);

    if (isFavorite) {
      await favRef.delete();
      showSnackBar(context, Provider.of<LanguageProvider>(context, listen: false).isArabic ? "تم إزالة ${widget.title} من المفضلة" : "${widget.title} removed from favorites");
    } else {
      await favRef.set({
        'title': widget.title,
        'location': widget.location,
        'price': widget.price,
        'rating': widget.rating,
        'imagePath': widget.selectedImages[0],
      });
      showSnackBar(context, Provider.of<LanguageProvider>(context, listen: false).isArabic ? "تم إضافة ${widget.title} إلى المفضلة" : "${widget.title} added to favorites");
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  String trimText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 130.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: widget.selectedImages.isNotEmpty &&
                              widget.selectedImages[0].startsWith('http')
                          ? Image.network(widget.selectedImages[0],
                              fit: BoxFit.cover)
                          : Image.asset(
                              widget.selectedImages.isNotEmpty
                                  ? widget.selectedImages[0]
                                  : 'assets/cards_home_player/imgs/test.jpg',
                              fit: BoxFit.cover),
                    ),
                  ),
                  // Favorite icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: toggleFavorite,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          gradient: greenGradientColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.title.length > 14
                            ? widget.title.substring(0, 14) + '...'
                            : widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "eras-itc-bold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Text(
                      "${widget.price}.00 .LE",
                      style: TextStyle(
                        fontSize: 13,
                        color: mainColor,
                        fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // location & rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 13, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          trimText(widget.location, 20),
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 128, 128),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(children: [
                      Text(
                        "${widget.rating}.0",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      for (int i = 0; i < widget.rating; i++)
                        Icon(Icons.star,
                            color: const Color.fromARGB(255, 255, 217, 0),
                            size: 15),
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  DrawerItem({required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "eras-itc-demi",
                    color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}

//statful widget for the drawer
class Create_Drawer extends StatefulWidget {
  final bool refreshData;
  
  const Create_Drawer({Key? key, this.refreshData = false}) : super(key: key);

  @override
  State<Create_Drawer> createState() => _Create_DrawerState();
}

class _Create_DrawerState extends State<Create_Drawer> {
  String? username;
  String? profileImageUrl;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  
  @override
  void didUpdateWidget(Create_Drawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh data if the refreshData flag is true
    if (widget.refreshData) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    final isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Get user data from Firestore
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        if (docSnapshot.exists) {
          final userData = docSnapshot.data();
          
          // Get user data
          String? newUsername = userData?['username'];
          String? newProfileImageUrl = userData?['profileImage'];
          
          // Only update state if there are actual changes to avoid unnecessary rebuilds
          if (newUsername != username || newProfileImageUrl != profileImageUrl) {
            setState(() {
              // Make sure we always display the username from Firestore if available
              username = newUsername;
              if (username == null || username!.isEmpty) {
                username = user.displayName ?? user.email?.split('@')[0] ?? 'User';
              }
              profileImageUrl = newProfileImageUrl;
              print('Updated profile image URL: $profileImageUrl');
            });
          }
        } else {
          // If document doesn't exist but user is logged in
          setState(() {
            username = user.displayName ?? user.email?.split('@')[0] ?? 'User';
          });
        }
      } catch (e) {
        print('Error loading user data: $e');
        // Fallback to Firebase user data if Firestore fails
        setState(() {
          username = user.displayName ?? user.email?.split('@')[0] ?? 'User';
        });
      }
    } else {
      // User is not logged in
      setState(() {
        username = 'Guest';
      });
    }
  }

  // Future<void> _loadUserData() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;

  //   // جرب تجيب من owners (صاحب ملعب)
  //   var doc = await FirebaseFirestore.instance.collection('owners').doc(user.uid).get();
  //   if (doc.exists) {
  //     setState(() {
  //       username = doc['username'] ?? 'Guest';
  //       profileImage = doc['profileImage'];
  //     });
  //     return;
  //   }

  //   // لو مش صاحب ملعب، جرب من users (لاعب)
  //   doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  //   if (doc.exists) {
  //     setState(() {
  //       username = doc['username'] ?? 'Guest';
  //       profileImage = doc['profileImage'];
  //     });
  //     return;
  //   }

  //   // لو مفيش بيانات
  //   setState(() {
  //     username = 'Guest';
  //     profileImage = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // User Google
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final userr = FirebaseAuth.instance.currentUser;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(14.0, 10.0, 24.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              //user image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: mainColor, width: 3.0),
                ),
                child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 60.0,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: ClipOval(
                        child: Image.network(
                          profileImageUrl!,
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading profile image: $error');
                            return Icon(Icons.person, size: 60, color: mainColor);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                                color: mainColor,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : userr != null && userr.photoURL != null
                    ? CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(userr.photoURL!),
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      )
                    : CircleAvatar(
                        radius: 60.0,
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        child: Icon(Icons.person_outline_rounded,
                            size: 80, color: mainColor),
                      ),
              ),
              SizedBox(
                height: 20.0,
              ),

              //username and line
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //first line
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 2.0,
                      color: mainColor,
                      width: 40.0,
                    ),
                  ),
                  //username
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        username ?? 'Guest',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'eras-itc-bold',
                            fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  //second line
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 2.0,
                      color: mainColor,
                      width: 40.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              //email
              Text(
                userr?.email ?? 'gust@gmail.com',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                  fontFamily: 'eras-itc-light',
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70.0,
              ),
              //options:
              Row(
                children: [
                  SizedBox(width: 40.0),
                  Expanded(
                    child: DrawerItem(
                        title: isArabic ? "الرئيسية" : "Home",
                        icon: Image.asset(
                            "assets/home_loves_tickets_top/imgs/Vector_drawerHome.png",
                            width: 30.0),
                        onTap: () {}),
                  ),
                  SizedBox(width: 32.0),
                  Expanded(
                    child: DrawerItem(
                        title: isArabic ? "الملف الشخصي" : "Profile",
                        icon: Image.asset(
                            "assets/home_loves_tickets_top/imgs/Vector_drawerProfile.png",
                            width: 30.0),
                        onTap: () {
                          Navigator.pushNamed(context, '/profilepage');
                        }),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  SizedBox(width: 40.0),
                  Expanded(
                    child: DrawerItem(
                        title: isArabic ? "تسجيل الخروج" : "Logout",
                        icon: Image.asset(
                            "assets/home_loves_tickets_top/imgs/vector_drawerLog_out.png",
                            width: 30.0),
                        onTap: () {
                          Navigator.pushNamed(context, '/Welcome');
                        }),
                  ),
                  SizedBox(width: 32.0),
                  Expanded(
                    child: DrawerItem(
                        title: isArabic ? "عن التطبيق" : "About us",
                        icon: Icon(Icons.info, size: 30.0, color: mainColor),
                        onTap: () {
                          Navigator.pushNamed(context, '/aboutApp');
                        }),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.1),
                      height: constraints.maxHeight * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: mainColor.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/home_loves_tickets_top/imgs/Vector_drawerSettings.png",
                              width: constraints.maxWidth * 0.1),
                          SizedBox(
                              width:
                                  constraints.maxWidth * 0.05),
                          Text(
                            isArabic ? "الإعدادات" : "Settings",
                            style: TextStyle(
                                fontSize: constraints.maxWidth * 0.025,
                                fontFamily: "eras-itc-demi",
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 40.0),
              SizedBox(height: 32.0),

              //ball img
              Expanded(
                child: Stack(
                  // clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -90.0,
                      bottom: -90.0,
                      child: Center(
                        // top: 0,
                        child: Image.asset(
                          'assets/home_loves_tickets_top/imgs/ball.png',
                          width: 238.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Back button
        Positioned(
          top: 30,
          right: 30,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Create_AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(80.0);

  Widget title;
  VoidCallback notificationState;
  Create_AppBar({
    required this.title,
    required this.notificationState,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.0,
      elevation: 0,
      backgroundColor: Color(0xFFFFFFFF),
      scrolledUnderElevation: 0,
      //bars
      leading: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Image.asset("assets/home_loves_tickets_top/imgs/bars.png",
                width: 24.0),
            iconSize: 16.0,
          );
        }),
      ),

      // notifications
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: notificationState,
            icon: Image.asset(
                "assets/home_loves_tickets_top/imgs/notifications.png",
                width: 24.0),
          ),
        )
      ],

      //title "vamonos"
      title: title,

      centerTitle: true,
    );
  }
}

//gradiant green button
class Create_GradiantGreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      // bottom: 124.0,
      // left: 30,
      decoration: BoxDecoration(
        gradient: greenGradientColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        onPressed: onButtonPressed,
        child: content,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }

  final Widget content;
  final VoidCallback onButtonPressed;
  Create_GradiantGreenButton({
    required this.content,
    required this.onButtonPressed,
  });
}

//white button
// ignore: must_be_immutable
class Create_WhiteButton extends StatelessWidget {
  String title;
  VoidCallback onButtonPressed;
  Create_WhiteButton({required this.title, required this.onButtonPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 40.0,
      // bottom: 192.0,
      // left: 30,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: ElevatedButton(
        onPressed: onButtonPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            // color: Color(0xff006607),
            fontFamily: "eras-itc-bold",
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ButtonStyle(
          // shape: MaterialStateProperty.all(
          //     RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(15))),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Color(0xff006607)),
          shadowColor: WidgetStateProperty.all(Colors.transparent),

          // padding: MaterialStateProperty.all(EdgeInsets.all(5)),
        ),
      ),
    );
  }
}

//text field ( input )
// ignore: must_be_immutable
class Create_Input extends StatelessWidget {
  Widget? addPrefixIcon;
  Widget? addSuffixIcon;
  String? hintText;
  bool isPassword;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  bool isReadOnly;
  VoidCallback? on_tap;
  String? initValue;
  TextEditingController? controller;
  final Function? onChange;
  Create_Input({
    this.addPrefixIcon,
    this.addSuffixIcon,
    this.hintText,
    required this.isPassword,
    required this.keyboardType,
    required this.textInputAction,
    this.isReadOnly = false,
    this.on_tap,
    this.initValue,
    this.controller,
    this.onChange,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xC7FFFFFF),
      width: double.infinity,
      height: 50.0,
      child: TextField(
          onChanged: onChange as void Function(String)?,
          controller: controller,
          onTap: on_tap,
          readOnly: isReadOnly,
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 18.0,
              fontWeight: FontWeight.w400),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: isPassword,
          cursorColor: mainColor,
          decoration: InputDecoration(
            focusColor: mainColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            prefixIcon: addPrefixIcon,
            suffixIcon: addSuffixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            labelText: hintText,
            floatingLabelStyle: TextStyle(
              color: mainColor,
              fontSize: 12.0,
            ),
            labelStyle: TextStyle(
              color: Color(0x4F000000),
              fontSize: 20.0,
              fontFamily: 'eras-itc-light',
            ),
            hintStyle: TextStyle(
                color: Color(0x4F000000),
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x4F000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}

// app title (vamonos)

// ignore: must_be_immutable
class Add_AppName extends StatelessWidget {
  double font_size;
  TextAlign align;
  Color color;
  Add_AppName({
    required this.font_size,
    required this.align,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            fontFamily: "eras-itc-bold",
            fontWeight: FontWeight.w900,
            color: color,
            fontSize: font_size),
        children: [
          TextSpan(text: "V"),
          TextSpan(text: "á", style: TextStyle(color: mainColor)),
          TextSpan(text: "monos"),
        ],
      ),
    );
  }
}

// required input

// phone number

bool PhoneNumber(String phoneNumber) {
  if (phoneNumber.length == 11 &&
      (phoneNumber.startsWith("010") ||
          phoneNumber.startsWith("011") ||
          phoneNumber.startsWith("012") ||
          phoneNumber.startsWith("015"))) {
    return true;
  } else {
    return false;
  }
}

// required input
class Create_RequiredInput extends StatelessWidget {
  final Widget add_prefix;
  final Widget? add_suffix;
  final bool? isReadOnly;
  final String? initValue;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final TextInputType textInputType;
  final String lableText;
  Create_RequiredInput({
    required this.add_prefix,
    required this.textInputType,
    required this.lableText,
    this.add_suffix,
    this.isReadOnly,
    this.initValue,
    this.onTap,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      onTap: onTap,
      controller: TextEditingController(text: initValue),
      keyboardType: textInputType,
      readOnly: isReadOnly ?? false,
      maxLines: null,
      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      cursorColor: mainColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        labelText: lableText,
        labelStyle: TextStyle(
          color: Color.fromARGB(75, 0, 0, 0),
          fontSize: 15.0,
        ),
        floatingLabelStyle: TextStyle(color: mainColor, fontSize: 16.0),
        floatingLabelAlignment:
            FloatingLabelAlignment.center, // Center the label
        prefixIcon: add_prefix,
        suffix: add_suffix,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: mainColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color.fromARGB(75, 0, 0, 0),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
