<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/payment/payment.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

class Stadium_info_playerPG extends StatefulWidget {
  final String stadiumName;
  final String stadiumPrice;
  final String stadiumLocation;
  final bool isWaterAvailbale;
  final bool isTrackAvailable;
  final bool isGrassNormal;
  final String capacity;
  final String description;
  final String stadiumID;
  final String stadiumtitle;

  Stadium_info_playerPG({
    required this.stadiumtitle,
    required this.stadiumName,
    required this.stadiumPrice,
    required this.stadiumLocation,
    required this.isWaterAvailbale,
    required this.isTrackAvailable,
    required this.isGrassNormal,
    required this.capacity,
    required this.description,
    required this.stadiumID,
  });
=======
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Stadium_info_playerPG(),
  ));
}

class Stadium_info_playerPG extends StatefulWidget {
  Stadium_info_playerPG({key});
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958

  @override
  State<Stadium_info_playerPG> createState() => _Stadium_info_playerPGState();
}

<<<<<<< HEAD
class _Stadium_info_playerPGState extends State<Stadium_info_playerPG>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool isFavorite = false;
  bool _isContainerVisible = true;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  DocumentSnapshot? stadiumData;
  bool isLoading = true; // to manage loading
  String? errorMessage; // to manage error message

  List<String> images = [];

  Future<void> checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final favDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.stadiumtitle)
        .get();

    setState(() {
      isFavorite = favDoc.exists;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
    // inizialize the page controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // inizialize SlideAnimation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // fetch data from Firestore
    fetchStadiumData();
  }

  // check if the stadium is favorite or not
  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    final isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.stadiumtitle);

    if (isFavorite) {
      await favRef.delete();
      showSnackBar(
          context,
          isArabic
              ? "تم إزالة ${widget.stadiumtitle} من المفضلة"
              : "${widget.stadiumtitle} removed from favorites");
    } else {
      await favRef.set({
        'title': widget.stadiumtitle,
        'location': widget.stadiumLocation,
        'price': widget.stadiumPrice,
        'rating':
            5, // Default rating or you can add a rating field to the widget
        'imagePath':
            'assets/stadium_information_player_pg/imgs/stadium_1.jpg', // Use appropriate image path
      });
      showSnackBar(
          context,
          isArabic
              ? "تم إضافة ${widget.stadiumtitle} إلى المفضلة"
              : "${widget.stadiumtitle} added to favorites");
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> fetchStadiumData() async {
    final isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('stadiums')
          .doc(widget.stadiumID)
          .get();
      if (!mounted) return;
      setState(() {
        if (doc.exists) {
          stadiumData = doc;
          images = List<String>.from((doc.data()?['images'] ?? []));
        } else {
          errorMessage =
              isArabic ? 'لا يوجد بيانات للاستادم' : 'no stadium data';
        }
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = isArabic ? 'حدث خطأ \n: $e' : 'error \n: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    if (!mounted) return;
    if (visibilityInfo.visibleFraction == 0 && _isContainerVisible) {
      setState(() {
        _isContainerVisible = false;
      });
      _animationController.forward();
    } else if (visibilityInfo.visibleFraction > 0 && !_isContainerVisible) {
      setState(() {
        _isContainerVisible = true;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic;
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // images slider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: images.isNotEmpty
                              ? images.map((imgUrl) {
                                  return imgUrl.startsWith('http')
                                      ? Image.network(imgUrl, fit: BoxFit.cover)
                                      : Image.asset(imgUrl, fit: BoxFit.cover);
                                }).toList()
                              : [
                                  Image.asset(
                                      'assets/cards_home_player/imgs/test.jpg',
                                      fit: BoxFit.cover)
                                ],
                        ),
                        // favorite icon
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              toggleFavorite();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 28,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.isNotEmpty ? images.length : 1,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: _currentPage == index ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? mainColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // stadium name
                Text(
                  widget.stadiumName,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: "eras-itc-demi",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                //  price and rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20.0),
                        Text(
                          '${widget.stadiumPrice}.00 LE',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "eras-itc-bold",
                            color: mainColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 15),
                          ],
                        ),
                        const Text(
                          "5.0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 161, 161, 161),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // location
                Row(
                  children: [
                    const SizedBox(width: 20.0),
                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                    Text(
                      widget.stadiumLocation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                VisibilityDetector(
                  key: const Key('unique-key-visibleForButton'),
                  onVisibilityChanged: _onVisibilityChanged,
                  child: SizedBox(
                    height: 50.0,
                    child: Create_GradiantGreenButton(
                      content: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isArabic ? 'الحجز الآن' : 'book now',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "eras-itc-bold",
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Transform.rotate(
                              angle: 0.785,
                              child: const Icon(
                                Icons.confirmation_num_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onButtonPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:
                                  (context) => /* TODO: Replace with your PaymentPage widget */
                                      Payment(
                                          stadiumID: widget.stadiumID,
)),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),

                // description
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        isArabic ? 'الوصف' : 'description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 60.0),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 120.0),
                Container(
                  width: double.infinity,
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.black,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        child: Transform.rotate(
                          angle: 0.785,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: greenGradientColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Transform.rotate(
                              angle: -0.785,
                              child: const Icon(Icons.auto_awesome,
                                  size: 29, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.water_drop,
                                    size: 29, color: mainColor),
                                const SizedBox(height: 6),
                                Text(
                                  widget.isWaterAvailbale
                                      ? isArabic
                                          ? 'متاح'
                                          : 'Available'
                                      : isArabic
                                          ? 'غير متاح'
                                          : 'Unavailable',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.track_changes,
                                    size: 29, color: mainColor),
                                const SizedBox(height: 6),
                                Text(
                                  widget.isTrackAvailable
                                      ? isArabic
                                          ? 'متاح'
                                          : 'Available'
                                      : isArabic
                                          ? 'غير متاح'
                                          : 'Unavailable',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Icon(Icons.grass, size: 29, color: mainColor),
                                const SizedBox(height: 6),
                                Text(
                                  widget.isGrassNormal
                                      ? isArabic
                                          ? 'طبيعي'
                                          : 'natural'
                                      : isArabic
                                          ? 'صناعي'
                                          : 'artificial',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.group, size: 29, color: mainColor),
                                const SizedBox(height: 6),
                                Text(
                                  widget.capacity,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.isWaterAvailbale
                                ? isArabic
                                    ? '  متاح ماء'
                                    : 'water is avalablie'
                                : isArabic
                                    ? ' غير متاح ماء'
                                    : 'no water ',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            '${widget.capacity} ${isArabic ? 'لاعب' : 'players'}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            widget.isTrackAvailable
                                ? isArabic
                                    ? ' مسار الجري متاح'
                                    : 'running track'
                                : isArabic
                                    ? ' مسار الجري غير متاح'
                                    : 'no running track',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            widget.isGrassNormal
                                ? isArabic
                                    ? 'عشب طبيعي'
                                    : 'natural grass'
                                : isArabic
                                    ? 'عشب صناعي'
                                    : 'artificial grass',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),

                // work days and times
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        isArabic ? 'وقت العمل والأيام' : 'work time and days',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40.0),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: mainColor.withOpacity(0.3),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(13),
                                      topRight: Radius.circular(13),
                                    ),
                                  ),
                                  child: Text(
                                    isArabic ? 'وقت العمل' : 'Work Time',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "eras-itc-demi",
                                      color: mainColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Provider.of<LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'من'
                                                  : 'From',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (stadiumData?.data() as Map<
                                                  String,
                                                  dynamic>?)?['startTime'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Provider.of<LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'الى'
                                                  : 'To',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (stadiumData?.data() as Map<
                                                  String,
                                                  dynamic>?)?['endTime'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Provider.of<LanguageProvider>(
                                                          context)
                                                      .isArabic
                                                  ? 'الأيام'
                                                  : 'Days',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              ' • ' +
                                                  (stadiumData?.data() as Map<
                                                              String,
                                                              dynamic>?)?[
                                                          'workingDays']
                                                      ?.join('\n • '),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                // comments
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        isArabic ? 'المراجعات' : 'reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40.0),
                // messages
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('stadiums')
                      .doc(widget.stadiumID)
                      .collection('reviews')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final isArabic =
                        Provider.of<LanguageProvider>(context, listen: false)
                            .isArabic;
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    final reviews = snapshot.data!.docs;
                    if (reviews.isEmpty) {
                      return Text(
                          isArabic ? 'لا يوجد مراجعات' : 'No reviews yet');
                    }
                    return Column(
                      children: reviews.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: mainColor.withOpacity(0.2), width: 2),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: data['userImage'] != null
                                    ? NetworkImage(data['userImage'])
                                    : AssetImage(
                                            "assets/stadium_information_player_pg/imgs/person.jpeg")
                                        as ImageProvider,
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['username'] ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Row(
                                    children: [
                                      for (int i = 0;
                                          i < (data['rating'] ?? 0).round();
                                          i++)
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        data['rating']?.toString() ?? '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data['comment'] ?? '',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.stadiumPrice + '.00',
                                style: const TextStyle(
                                  color: Color(0xff00B92E),
                                  fontSize: 32.0,
                                  fontFamily: 'eras-itc-bold',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                ' LE',
                                style: TextStyle(
                                  color: Color(0xff00B92E),
                                  fontSize: 16.0,
                                  fontFamily: 'eras-itc-bold',
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
=======
class _Stadium_info_playerPGState extends State<Stadium_info_playerPG> {
  double sendCommentClose = 25.0;
  TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
//choose date of match
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                  //chhose date of match
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Choose date of match",
                      style: TextStyle(
                        // fontFamily: "eras-itc-bold",
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: "eras-itc-demi",
                        // fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

//date
              SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
//choose day
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xADADAD)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xFF000000)),
                            // side: BorderSide(color: Colors.green, width: 0.5),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Day",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
                            ),
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                          ),
                        ),
                      ),
                    ),
<<<<<<< HEAD
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => /* TODO: Replace with your PaymentPage widget */
                                        Payment(
                                          stadiumID: widget.stadiumID,
                                        )),
                          );
                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            gradient: greenGradientColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Book",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'eras-itc-bold',
                                fontSize: 24.0,
                              ),
=======
                    SizedBox(
                      width: 16.0,
                    ),
//choose time
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xADADAD)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xFF000000)),
                            // side: BorderSide(color: Colors.green, width: 0.5),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
//choose duration
                    Expanded(
                      child: Container(
                        width: 110.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xADADAD)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xFF000000)),
                            // side: BorderSide(color: Colors.green, width: 0.5),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color(0xff00B92E), width: 0.5)),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "eras-itc-light",
                              fontWeight: FontWeight.w700,
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
<<<<<<< HEAD
            ),
          ),
        ],
      ),
    );
=======
              SizedBox(height: 49.0),
//comments
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                  //chhose date of match
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        // fontFamily: "eras-itc-bold",
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: "eras-itc-demi",
                        // fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 202, 202, 202),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
//add comment
              Container(
                width: double.infinity,
                // height: 40.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Color(0x9DD9D9D9),
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextField(
                  controller: _commentController,
                  onChanged: (s) {
                    setState(() {
                      if (_commentController.text.isEmpty) {
                        sendCommentClose = 25.0;
                      } else {
                        sendCommentClose = 0.0;
                      }
                    });
                  },
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontFamily: "eras-itc-demi",
                  ),
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  cursorColor: Color(0xff00B92E),
                  autocorrect: true,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffix: Stack(
                        children: [
                          //send
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(CircleBorder()),
                                // padding:
                                // MaterialStateProperty.all(EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff00B92E)),
                              ),
                              child: Icon(
                                Icons.send_rounded,
                                size: 16,
                                color: Color(0xFFFFFFFF),
                              )),

                          //close send
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.only(left: 15.0),
                            width: sendCommentClose,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF00B92E),
                              shape: BoxShape.circle,
                            ),
                            child: null,
                          ),
                        ],
                      ),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(right: 12.0),
                        child: Image.asset(
                            'assets/stadium_information_player_pg/imgs/comment.png'),
                      ),
                      hintText: 'Add Comment',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black45,
                        fontFamily: "eras-itc-light",
                      )),
                ),
              ),
              SizedBox(height: 16.0),
//comment box
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                // height: double.,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xff00B92E),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      // spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(
                        0,
                        2,
                      ),
                    ),
                  ],
                ),
                child: Wrap(
                  // clipBehavior: Clip.none,
                  children: [
                    //userimg, username, time
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              //user image
                              Container(
                                // top: 3,
                                // left: 10,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/stadium_information_player_pg/imgs/person.jpeg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              //username
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "ahmed_789",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "eras-itc-demi",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100.0,
                              ),
                              Positioned(
                                right: 16.0,
                                child: Text(
                                  "3:45 pm",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "eras-itc-light",
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // top: 43,
                      // left: 9,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Amazing experience! The field was in perfect condition, and the facilities were top-notch. We had a great time playing here Highly recommend it!",
                        style: TextStyle(
                          fontSize: 12.0,
                          // fontWeight: FontWeight.bold,
                          // fontFamily: "eras-itc-light",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star, color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_half,
                            color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_border,
                            color: Color(0xffFFCC00), size: 16),
                        Icon(Icons.star_border,
                            color: Color(0xffFFCC00), size: 16),
                        Text(
                          "2.5",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 134, 133, 133),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 20,
                // spreadRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  // width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 221, 221, 221),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '200,0',
                          style: TextStyle(
                              color: Color(0xff00B92E),
                              fontSize: 32.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' .LE',
                          style: TextStyle(
                              color: Color(0xff00B92E),
                              fontSize: 16.0,
                              fontFamily: 'eras-itc-bold',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff005706),
                          Color(0xff007211),
                          Color(0xff00911E),
                          Color(0xff00B92E),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      "Book",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: "eras-itc-bold",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
>>>>>>> 8f7a51607a3d57faccecdb29623811b92fbba958
  }
}
