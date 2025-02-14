import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Payment());
}

class Payment extends StatelessWidget {
  // const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      home: Scaffold(
        
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/payment/imgs/stdBack.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/payment/imgs/4213475_arrow_back_left_return_icon.png',
                            height: 40,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/stadium_information_player_pg');
                          },
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'v',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33,
                                  fontFamily: "light",
                                ),
                              ),
                              TextSpan(
                                text: 'á',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 19, 197, 25),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33,
                                  fontFamily: "light",
                                ),
                              ),
                              TextSpan(
                                text: 'monos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33,
                                  fontFamily: "light",
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/payment/imgs/icons8-notification-322.png',
                            height: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.06,
                              height: MediaQuery.of(context).size.width * 0.06,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/payment/imgs/icons8-stadium-100_1_(1).png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              "wembley",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 197, 25),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "light"),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3),
                            Text(
                              "200.LE",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 197, 25),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "light"),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.06,
                              height: MediaQuery.of(context).size.width * 0.06,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/payment/imgs/icons8-location-1001.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              "Assiut _ new assiut city _ suzan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontFamily: "light"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 19, 197, 25),
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "3.8",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: "light"),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "(218)",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.027,
                                      fontFamily: "light"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.06),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.0017,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Day",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontFamily: "light",
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    "Friday",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: "light",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "6/5/2025",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontFamily: "light"),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontFamily: "light"),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    "2:30",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: "light",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Pm",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontFamily: "light"),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontFamily: "light"),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    "1:30 hour",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "light"),
                                  ),
                                  Text(
                                    "hour",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontFamily: "light"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.08,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.62,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                const Color.fromARGB(
                                                        255, 241, 7, 7)
                                                    .withOpacity(0.9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            shadowColor:
                                                Colors.black.withOpacity(0.9),
                                            elevation: 10,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.24,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Image.asset(
                                                  'assets/payment/imgs/icons8-vodafone-100.png',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              const Text(
                                                'Vodafone',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "light",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            shadowColor:
                                                Colors.black.withOpacity(0.9),
                                            elevation: 10,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.24,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Image.asset(
                                                  'assets/payment/imgs/images(1).png',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'INSTAPAY',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 100, 18, 121),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "light",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                const Color.fromARGB(
                                                        255, 255, 127, 8)
                                                    .withOpacity(0.83),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            shadowColor:
                                                Colors.black.withOpacity(0.3),
                                            elevation: 10,
                                            fixedSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.24,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Image.asset(
                                                  'assets/payment/imgs/unnamed.png',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'Orange',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "light",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.09),
                              Text(
                                "Cash number",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 8, 92, 1),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.019,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "light",
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.023),
                              TextField(
                                keyboardType: TextInputType.phone,
                                controller:
                                    TextEditingController(text: '01012345678'),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 38, 228, 0),
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Number...',
                                  hintStyle: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                                cursorColor: Colors.green,
                                style: const TextStyle(fontFamily: "light"),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:  EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width * 0.1, top: 9, bottom: 3),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.059,
                                    width: MediaQuery.of(context).size.height *
                                        0.026,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/payment/imgs/Group127(1).png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.013,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      "Pay half the amount before booking.",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "light"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 252, 249, 249)
                                          .withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 39, 185, 2),
                                        width: 0.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: Offset(4, 4),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "100",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "light",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              Center(
                                child: const Text(
                                  "Make sure to enter the \n data correctly and carefully.",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 8, 92, 1),
                                      fontSize: 14,
                                      fontFamily: "light"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.017),
                              Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4CAF50),
                                            Color(0xFF2C6B2F),
                                          ],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Confirm Booking",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "light"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
