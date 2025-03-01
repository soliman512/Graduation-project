import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../reusable_widgets/reusable_widgets.dart';

class Signup_pg1_player extends StatefulWidget {
  @override
  State<Signup_pg1_player> createState() => _Signup_pg1_playerState();
}

class _Signup_pg1_playerState extends State<Signup_pg1_player> {
  // location visiblity and visibl of items on location
  bool visibleOfLocation = false;
  bool visibleOfPlace = false;
  bool visibleOfNeighborhood = false;
  bool visibleOfButton = false;
  bool checkInputs() {
    if (visibleOfPlace == true && visibleOfNeighborhood == true) {
      visibleOfButton = true;
      return true;
    }
    return false;
  }

  String? Location;
  void initValueOfLocation() {
    if (citySelected == null) {
      Location = "";
    } else {
      Location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: false,
          //app bar language
          appBar: AppBar(
            centerTitle: true,
            title: Text("sign up",
                style: TextStyle(
                  color: Color(0xFF000000),
                  // fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_signup_player');
              },
              icon: Image.asset(
                "assets/welcome_signup_login/imgs/back.png",
                color: Color(0xFF000000),
              ),
              // ic
              // icon: Image.asset("assets/welcome_signup_login/imgs/ligh back.png"),
            ),
            toolbarHeight: 80.0,
            elevation: 0,
            backgroundColor: Color(0x00),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFF000000),
                  )),
            ],
          ),
          body: Stack(
            children: [
              backgroundImage_balls,
              SingleChildScrollView(
                child: Column(children: [
                  // title
                  Add_AppName(
                      font_size: 34.0,
                      align: TextAlign.center,
                      color: Colors.black),
                  //specific user
                  Text("Player",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        // fontFamily: "eras-itc-bold",
                        fontWeight: FontWeight.w200,
                        fontSize: 20.0,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  //logo
                  logo,
                  SizedBox(
                    height: 70.0,
                  ),
                  //inputs:

                  //username
                  Create_Input(
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Username",
                    addPrefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  //phone
                  Create_Input(
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Phone Number",
                    addPrefixIcon: Icon(
                      Icons.phone,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //location
                  Create_Input(
                    initValue: Location,
                    on_tap: () {
                      setState(() {
                        visibleOfLocation = true;
                      });
                    },
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Location",
                    addPrefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //date birh
                  Create_Input(
                    isReadOnly: true,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Date of Birth",
                    addPrefixIcon: Icon(
                      Icons.date_range_rounded,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                  ),

                  //next
                  Create_GradiantGreenButton(
                      title: 'Next',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/sign_up_pg2_player');
                      })
                ]),
              ),

              //location
              Visibility(
                visible: visibleOfLocation,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: null,
                        padding: EdgeInsets.only(bottom: 20.0),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 150.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 100.0)
                            ],
                            color: Colors.white
                            // color: Colors.red
                            ),
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              //close location
                              Positioned(
                                // padding: EdgeInsets.only(right: 10.0, top: 10.0),
                                top: 10.0,
                                right: 10.0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visibleOfLocation = false;
                                    });
                                  },
                                  child: Icon(Icons.close_rounded,
                                      color: Colors.black, size: 30.0),
                                ),
                              ),
                              //inputs
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  //city
                                  ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.all(8.0),
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x7C000000),
                                              blurRadius: 10.0)
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/home_loves_tickets_top/imgs/city_Vector.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x7C000000),
                                                blurRadius: 10.0)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          onChanged: (String? cityValue) {
                                            setState(() {
                                              visibleOfPlace = true;
                                              citySelected = cityValue;
                                              placesOfCityOnSelected = null;
                                              placeSelected = null;
                                            });
                                            placesOfCityOnSelected =
                                                egyptGovernoratesAndCenters[
                                                    cityValue];
                                          },
                                          items: egyptGovernorates.map((city) {
                                            return DropdownMenuItem<String>(
                                              value: city,
                                              child: Text(city),
                                            );
                                          }).toList(),
                                          menuMaxHeight: 300.0,
                                          value: citySelected,
                                          hint: Text('select City'),
                                          icon: Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              size: 30.0,
                                              color: mainColor),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),
                                          alignment: Alignment.center,
                                          underline: null,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              
                                  //place
                                  Visibility(
                                    visible: visibleOfPlace,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0)
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x7C000000),
                                                    blurRadius: 10.0)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              items: placesOfCityOnSelected
                                                  ?.map((String place) {
                                                return DropdownMenuItem<String>(
                                                  child: Text(place),
                                                  value: place,
                                                );
                                              }).toList(),
                                              onChanged: (String? placeValue) {
                                                setState(() {
                                                  visibleOfNeighborhood = true;
                                                  placeSelected = placeValue;
                                                });
                                              },
                                              menuMaxHeight: 300.0,
                                              value: placeSelected,
                                              hint: Text('select place'),
                                              icon: Icon(
                                                  Icons
                                                      .arrow_drop_down_circle_outlined,
                                                  size: 30.0,
                                                  color: mainColor),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                              alignment: Alignment.center,
                                              underline: null,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              
                                  // //neighborhood
                                  Visibility(
                                    visible: visibleOfNeighborhood,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          padding: EdgeInsets.all(8.0),
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x7C000000),
                                                  blurRadius: 10.0)
                                            ],
                                          ),
                                          child: Image.asset(
                                            'assets/home_loves_tickets_top/imgs/nighborhood.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        title: Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0x7C000000),
                                                      blurRadius: 10.0)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            child: TextField(
                                              controller: neighborhoodEnterd,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  hintText: 'neighborhood'),
                                            )),
                                      ),
                                    ),
                                  ),
                              
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  // //button
                                  Visibility(
                                    visible: checkInputs(),
                                    child: Create_GradiantGreenButton(
                                        title: 'Done',
                                        onButtonPressed: () {
                                          setState(() {
                                            visibleOfLocation = false;
                                            initValueOfLocation();
                                          });
                                        }),
                                  )
                                ],
                              ),
                            
                            
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
