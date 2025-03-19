import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Stadium_info_playerPG(),
  ));
}

class Stadium_info_playerPG extends StatefulWidget {
  Stadium_info_playerPG({key});

  @override
  State<Stadium_info_playerPG> createState() => _Stadium_info_playerPGState();
}

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
                          ),
                        ),
                      ),
                    ),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
  }
}
