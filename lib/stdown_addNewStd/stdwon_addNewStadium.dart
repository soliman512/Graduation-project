import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../constants/constants.dart';

class AddNewStadium extends StatefulWidget {
  const AddNewStadium({Key? key}) : super(key: key);

  @override
  State<AddNewStadium> createState() => _AddNewStadiumState();
}

class _AddNewStadiumState extends State<AddNewStadium> {
//water
  bool? isAvilable_Water;
  Color? waterAvilable = Color(0xff929292);
  Color? waterNotAvilable = Color(0xff929292);
//track
  bool? isAvilable_Track;
  Color? TrackAvilable = Color(0xff929292);
  Color? TrackNotAvilable = Color(0xff929292);
//grass
  bool? isAvilable_Grass;
  Color? GrassAvilable = Color(0xff929292);
  Color? GrassNotAvilable = Color(0xff929292);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,

        // leading: add_logo(10.0),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: 'eras-itc-bold'),
              children: [
                TextSpan(text: 'N', style: TextStyle(color: mainColor)),
                TextSpan(text: 'ew'),
                TextSpan(text: ' S', style: TextStyle(color: mainColor)),
                TextSpan(text: 'Tadium'),
              ]),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage_balls,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Images*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  //add image
                  Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0x8FF2F2F2),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: mainColor, width: 2.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/stdowner_addNewStadium/imgs/threeCards.png'),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 100.0, vertical: 12.0),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  'Add Image',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: greenGradientColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          Text(
                            '5MB maximum file size accepted \nin the following formats:  .jpg   .jpeg,   .png ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Stadium Name*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium name
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/sign.png'),
                      )),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Stadium Location*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium location
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/location.png'),
                      )),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    'Set Price*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  //stadium price
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/price.png'),
                      )),
                  SizedBox(
                    height: 32.0,
                  ),

                  //stadium description
                  Text(
                    'Description*',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Create_RequiredInput(
                        add_prefix: Image.asset(
                            'assets/stdowner_addNewStadium/imgs/desc.png'),
                      )),
                  SizedBox(
                    height: 84.0,
                  ),

                  //water
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Water*',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Wrap(
                        children: [
                          //avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: waterAvilable,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Water = true;
                                  setState(() {
                                    waterAvilable = mainColor;
                                    waterNotAvilable = Color(0xff929292);
                                  });
                                },
                                child: Text(
                                  'Avilable',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                          SizedBox(width: 6.0),
                          // not avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: waterNotAvilable,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Water = false;
                                  setState(() {
                                    waterAvilable = Color(0xff929292);
                                    waterNotAvilable = mainColor;
                                  });
                                },
                                child: Text('Not Avilable',
                                    style: TextStyle(fontSize: 14.0)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //track
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Track*',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Wrap(
                        children: [
                          //avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: TrackAvilable,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Track = true;
                                  setState(() {
                                    TrackAvilable = mainColor;
                                    TrackNotAvilable = Color(0xff929292);
                                  });
                                },
                                child: Text(
                                  'Avilable',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                          SizedBox(width: 6.0),
                          // not avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: TrackNotAvilable,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Track = false;
                                  setState(() {
                                    TrackAvilable = Color(0xff929292);
                                    TrackNotAvilable = mainColor;
                                  });
                                },
                                child: Text('Not Avilable',
                                    style: TextStyle(fontSize: 14.0)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //track
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grass*',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Wrap(
                        children: [
                          //avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: GrassAvilable,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Grass = true;
                                  setState(() {
                                    GrassAvilable = mainColor;
                                    GrassNotAvilable = Color(0xff929292);
                                  });
                                },
                                child: Text(
                                  'Avilable',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                          SizedBox(width: 6.0),
                          // not avilable
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: GrassNotAvilable,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  isAvilable_Grass = false;
                                  setState(() {
                                    GrassAvilable = Color(0xff929292);
                                    GrassNotAvilable = mainColor;
                                  });
                                },
                                child: Text('Not Avilable',
                                    style: TextStyle(fontSize: 14.0)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  //Capacity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Capacity*',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: 200.0,
                          // height: 30.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 18.0),
                            cursorColor: mainColor,
                            decoration: InputDecoration(
                              fillColor: Color(0x8FF2F2F2),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: mainColor, width: 2.0),
                              ),
                              hintText: 'Enter Capacity',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  //post, discard
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          'Discard',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 16.0)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.red, width: 2.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                        ),
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Create_GradiantGreenButton(
                          onButtonPressed: () {},
                          title: 'Post',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
