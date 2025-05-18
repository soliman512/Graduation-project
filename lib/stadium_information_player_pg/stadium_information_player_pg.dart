import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/payment/payment.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

  @override
  State<Stadium_info_playerPG> createState() => _Stadium_info_playerPGState();
}

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

    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.stadiumtitle);

    if (isFavorite) {
      await favRef.delete();
      showSnackBar(context, "${widget.stadiumtitle} removed from favorites");
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
      showSnackBar(context, "${widget.stadiumtitle} added to favorites");
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> fetchStadiumData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('stadiums')
          .doc(widget.stadiumID)
          .get();
      setState(() {
        if (doc.exists) {
          stadiumData = doc;
        } else {
          errorMessage = 'no stadium data';
        }
        isLoading = false; // fetch completed
      });
    } catch (e) {
      setState(() {
        errorMessage = 'error \n: $e';
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
                          children: [
                            for (int i = 0; i < 4; i++)
                              Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/cards_home_player/imgs/test.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                              4,
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
                            const Text(
                              'book now',
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
                                          stadiumName: widget.stadiumName,
                                          stadiumPrice: widget.stadiumPrice,
                                          stadiumLocation:
                                              widget.stadiumLocation)),
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
                        'description',
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
                                      ? 'Available'
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
                                      ? 'Available'
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
                                  widget.isGrassNormal ? 'normal' : 'industry',
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
                                ? 'water is available'
                                : 'no water',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            '${widget.capacity} players',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            widget.isTrackAvailable
                                ? 'running track'
                                : 'no running track',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            widget.isGrassNormal
                                ? 'grass is normal'
                                : 'grass is industry',
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
                        'work time and days',
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
                                    'Work Time',
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
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'From',
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
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'To',
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
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Days',
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
                        'reviews',
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
                for (int i = 0; i < 4; i++) ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(38, 0, 185, 46),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromARGB(14, 0, 0, 0),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  "assets/stadium_information_player_pg/imgs/person.jpeg"),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Esther Howard",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'eras-itc-demi',
                              ),
                            ),
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffFFCC00),
                                    size: 16,
                                  ),
                                const SizedBox(width: 4),
                                Text(
                                  "5.5",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Container(
                          height: 80,
                          width: 1,
                          color: Colors.black12,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This should give you the exact structure shown in the image. Let me know if you need further adjustments!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
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
                          ),
                        ),
                      ),
                    ),
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
                                            stadiumName: widget.stadiumName,
                                            stadiumPrice: widget.stadiumPrice,
                                            stadiumLocation:
                                                widget.stadiumLocation)),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
