import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/constants/constants.dart';

class Payment extends StatelessWidget {
  // const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 28,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Discard Payment"),
                    content:
                        Text("Are you sure you want to discard the payment?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text("Return"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Navigate back
                        },
                        child: Text("Discard",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/payment/imgs/tickets.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.8),
                ),
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
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                    Text(
                      "200.LE",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: "eras-itc-demi"),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: mainColor,
                      size: MediaQuery.of(context).size.width * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Assiut-new assiut city-suzan",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: mainColor,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "3.8",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontFamily: "eras-itc-demi"),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "(218)",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 124, 124, 124),
                            fontSize: MediaQuery.of(context).size.width * 0.027,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'booking details',
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
                
                // Container(
                //   padding:
                //       EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                //   decoration: BoxDecoration(
                //     color: Colors.transparent,
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       color: const Color.fromARGB(80, 0, 185, 46),
                //       width: MediaQuery.of(context).size.width * 0.0017,
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Column(
                //         children: [
                //           Text(
                //             "Day",
                //             style: TextStyle(
                //               color: mainColor,
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.04,
                //               fontFamily: "eras-itc-demi",
                //             ),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.02,
                //           ),
                //           Text(
                //             "Friday",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //           Text(
                //             "6/5/2025",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           Text(
                //             "Time",
                //             style: TextStyle(
                //                 color: mainColor,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.04,
                //                 fontFamily: "eras-itc-demi"),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.04,
                //           ),
                //           Text(
                //             "2:30",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           Text(
                //             "Duration",
                //             style: TextStyle(
                //                 color: mainColor,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.04,
                //                 fontFamily: "eras-itc-demi"),
                //           ),
                //           SizedBox(
                //             height: MediaQuery.of(context).size.width * 0.02,
                //           ),
                //           Text(
                //             "1:30",
                //             style: TextStyle(
                //               color: const Color.fromARGB(255, 0, 0, 0),
                //               fontSize:
                //                   MediaQuery.of(context).size.width * 0.03,
                //             ),
                //           ),
                //           Text(
                //             "hour",
                //             style: TextStyle(
                //                 color: const Color.fromARGB(255, 0, 0, 0),
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.03,
                //                 fontFamily: "light"),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                

 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
