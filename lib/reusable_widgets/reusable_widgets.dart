import 'package:flutter/material.dart';
import '../../constants/constants.dart';

//statful widget for the drawer
class Create_Drawer extends StatefulWidget {
  const Create_Drawer({Key? key}) : super(key: key);

  @override
  State<Create_Drawer> createState() => _Create_DrawerState();
}

class _Create_DrawerState extends State<Create_Drawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.only(right: 112.0),
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
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage:
                  AssetImage('assets/home_loves_tickets_top/imgs/person_2.png'),
              backgroundColor: Colors.grey[300],
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
              Container(
                height: 2.0,
                color: mainColor,
                width: 40.0,
              ),
              //username
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Belal_789',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'eras-itc-bold',
                      fontSize: 24.0),
                ),
              ),
              //second line
              Container(
                height: 2.0,
                color: mainColor,
                width: 40.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          //email
          Text(
            'belal789@gmail.com',
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
          // 0 : Home option
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  drawerOptions[0]['widtOfOption'] =
                      widthOfDrawer_SelectedOption;
                  drawerOptions[1]['widtOfOption'] = 10.0;
                  drawerOptions[2]['widtOfOption'] = 10.0;
                  drawerOptions[3]['widtOfOption'] = 10.0;
                });
              },
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: drawerOptions[0]['widtOfOption'],
                height: 10.0,
                decoration: BoxDecoration(
                    gradient: greenGradientColor,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              title: Row(
                children: [
                  Image.asset(
                    'assets/home_loves_tickets_top/imgs/Vector_drawerHome.png',
                    width: 24.0,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          // 1 : profile option
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  drawerOptions[0]['widtOfOption'] = 10.0;
                  drawerOptions[1]['widtOfOption'] =
                      widthOfDrawer_SelectedOption;
                  drawerOptions[2]['widtOfOption'] = 10.0;
                  drawerOptions[3]['widtOfOption'] = 10.0;
                });
              },
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: drawerOptions[1]['widtOfOption'],
                height: 10.0,
                decoration: BoxDecoration(
                    gradient: greenGradientColor,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              title: Row(
                children: [
                  Image.asset(
                    'assets/home_loves_tickets_top/imgs/Vector_drawerProfile.png',
                    width: 24.0,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          // 2 : settings option
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  drawerOptions[0]['widtOfOption'] = 10.0;
                  drawerOptions[1]['widtOfOption'] = 10.0;
                  drawerOptions[2]['widtOfOption'] =
                      widthOfDrawer_SelectedOption;
                  drawerOptions[3]['widtOfOption'] = 10.0;
                });
              },
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: drawerOptions[2]['widtOfOption'],
                height: 10.0,
                decoration: BoxDecoration(
                    gradient: greenGradientColor,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              title: Row(
                children: [
                  drawerOptions[2]['icon'],
                  SizedBox(
                    width: 20.0,
                  ),
                  drawerOptions[2]['title']
                ],
              ),
            ),
          ),
          // 3 : log_out option
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  drawerOptions[0]['widtOfOption'] = 10.0;
                  drawerOptions[1]['widtOfOption'] = 10.0;
                  drawerOptions[2]['widtOfOption'] = 10.0;
                  drawerOptions[3]['widtOfOption'] =
                      widthOfDrawer_SelectedOption;
                });
              },
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: drawerOptions[3]['widtOfOption'],
                height: 10.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF570000),
                      Color(0xFF920000),
                      Color(0xFFCE0000),
                      Color(0xFFE00101),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              title: Row(
                children: [
                  Image.asset(
                    'assets/home_loves_tickets_top/imgs/vector_drawerLog_out.png',
                    width: 24.0,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),

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
    );
  }
}

//statful widget for the appbar
class Create_AppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(80.0);

  RichText title;
  Create_AppBar({
    required this.title,
  });

  @override
  State<Create_AppBar> createState() => _Create_AppBarState();
}

class _Create_AppBarState extends State<Create_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.0,
// foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      backgroundColor: Color(0xFFFFFFFF),
//bars
      leading: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              setState(() {
                Scaffold.of(context).openDrawer();
              });
            },
            icon: Image.asset("assets/home_loves_tickets_top/imgs/bars.png"),
            iconSize: 24.0,
          );
        }),
      ),

// notifications
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Welcome');
            },
            icon: Image.asset(
                "assets/home_loves_tickets_top/imgs/notifications.png"),
            iconSize: 24.0,
          ),
        )
      ],

//title "vamonos"
      title: widget.title,

      centerTitle: true,
    );
  }
}

//statdium card
Widget buildCard({
  required BuildContext context,
  required String title,
  required String location,
  required String imageUrl,
  required String price,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/stadium_information_player_pg');
    },
    child: Container(
      width: 360.0,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: mainColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 130.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xffFFCC00), size: 15),
                      SizedBox(width: 1),
                      Icon(Icons.star, color: Color(0xffFFCC00), size: 15),
                      SizedBox(width: 1),
                      Icon(Icons.star, color: Color(0xffFFCC00), size: 15),
                      SizedBox(width: 1),
                      Icon(Icons.star, color: Color(0xffFFCC00), size: 15),
                      SizedBox(width: 1),
                      Icon(Icons.star, color: Color(0xffFFCC00), size: 15),
                      SizedBox(
                        width: 1,
                      ),
                      Text(
                        "5.5",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      price,
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "eras-itc-bold",
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 13,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Text(
                      location,
                      style: TextStyle(
                        color: Color.fromARGB(255, 130, 128, 128),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    ),
  );
}

//gradiant green button
class Create_GradiantGreenButton extends StatefulWidget {
  @override
  State<Create_GradiantGreenButton> createState() =>
      _Create_GradiantGreenButtonState();

  String title;
  VoidCallback onButtonPressed;
  Create_GradiantGreenButton(
      {required this.title, required this.onButtonPressed});
}

class _Create_GradiantGreenButtonState
    extends State<Create_GradiantGreenButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 40.0,
      // bottom: 124.0,
      // left: 30,
      decoration: BoxDecoration(
          gradient: greenGradientColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: ElevatedButton(
        onPressed: widget.onButtonPressed,
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "eras-itc-bold",
            // letterSpacing: 2,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ButtonStyle(
          // shape: MaterialStateProperty.all(
          //     RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(15))),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          // padding: MaterialStateProperty.all(EdgeInsets.all(5)),
        ),
      ),
    );
  }
}

//white button
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
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(Color(0xff006607)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),

          // padding: MaterialStateProperty.all(EdgeInsets.all(5)),
        ),
      ),
    );
  }
}

//text field ( input )
class Create_Input extends StatefulWidget {
  Widget? addPrefixIcon;
  Widget? addSuffixIcon;
  String? hintText;
  bool isPassword;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  bool isReadOnly;
  VoidCallback? on_tap;
  String? initValue;
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
  });
  @override
  State<Create_Input> createState() => _Create_InputState();
}

class _Create_InputState extends State<Create_Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 52.0),
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      color: Color(0xC7FFFFFF),
      width: double.infinity,
      height: 44.0,
      child: TextField(
          controller: TextEditingController(text: widget.initValue),
          onTap: widget.on_tap,
          readOnly: widget.isReadOnly,
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 18.0,
              fontWeight: FontWeight.w400),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword,
          cursorColor: mainColor,
          decoration: InputDecoration(
            focusColor: mainColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            prefixIcon: widget.addPrefixIcon,
            suffixIcon: widget.addSuffixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            hintText: widget.hintText,
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

// //Location

// class Create_LocationInputs extends StatefulWidget {
//   Create_LocationInputs({Key? key}) : super(key: key);

//   @override
//   State<Create_LocationInputs> createState() => _Create_LocationInputsState();
// }

// bool visibleOfLocation = false;
// bool visibleOfPlace = false;
// bool visibleOfNeighborhood = false;
// bool visibleOfButton = false;
// String? Location;

// class _Create_LocationInputsState extends State<Create_LocationInputs> {
//   // location visiblity and visibl of items on location

//   bool checkInputs() {
//     if (visibleOfPlace == true && visibleOfNeighborhood == true) {
//       visibleOfButton = true;
//       return true;
//     }
//     return false;
//   }

//   void initValueOfLocation() {
//     if (citySelected == null) {
//       Location = "";
//     } else {
//       Location = "$citySelected-$placeSelected-${neighborhoodEnterd.text}";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: visibleOfLocation,
//       child: Center(
//         child: Stack(
//           children: [
//             Container(
//               height: null,
//               padding: EdgeInsets.only(bottom: 20.0),
//               width: double.infinity,
//               margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 150.0),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.0),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black, blurRadius: 100.0)
//                   ],
//                   color: Colors.white
//                   // color: Colors.red
//                   ),
//               child: SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     //close location
//                     Positioned(
//                       // padding: EdgeInsets.only(right: 10.0, top: 10.0),
//                       top: 10.0,
//                       right: 10.0,
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             visibleOfLocation = false;
//                           });
//                         },
//                         child: Icon(Icons.close_rounded,
//                             color: Colors.black, size: 30.0),
//                       ),
//                     ),
//                     //inputs
//                     Column(
//                       // crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           height: 60.0,
//                         ),
//                         //city
//                         ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8.0),
//                             width: 40.0,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color(0x7C000000), blurRadius: 10.0)
//                               ],
//                             ),
//                             child: Image.asset(
//                               'assets/home_loves_tickets_top/imgs/city_Vector.png',
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           title: Container(
//                             width: double.infinity,
//                             margin: EdgeInsets.symmetric(horizontal: 20.0),
//                             height: 40.0,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color(0x7C000000),
//                                       blurRadius: 10.0)
//                                 ],
//                                 borderRadius: BorderRadius.circular(10.0)),
//                             child: Center(
//                               child: DropdownButton<String>(
//                                 onChanged: (String? cityValue) {
//                                   setState(() {
//                                     visibleOfPlace = true;
//                                     citySelected = cityValue;
//                                     placesOfCityOnSelected = null;
//                                     placeSelected = null;
//                                   });
//                                   placesOfCityOnSelected =
//                                       egyptGovernoratesAndCenters[cityValue];
//                                 },
//                                 items: egyptGovernorates.map((city) {
//                                   return DropdownMenuItem<String>(
//                                     value: city,
//                                     child: Text(city),
//                                   );
//                                 }).toList(),
//                                 menuMaxHeight: 300.0,
//                                 value: citySelected,
//                                 hint: Text('select City'),
//                                 icon: Icon(
//                                     Icons.arrow_drop_down_circle_outlined,
//                                     size: 30.0,
//                                     color: mainColor),
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18.0,
//                                 ),
//                                 alignment: Alignment.center,
//                                 underline: null,
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                           ),
//                         ),

//                         //place
//                         Visibility(
//                           visible: visibleOfPlace,
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 20.0),
//                             child: ListTile(
//                               leading: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 width: 40.0,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color(0x7C000000),
//                                         blurRadius: 10.0)
//                                   ],
//                                 ),
//                                 child: Image.asset(
//                                   'assets/home_loves_tickets_top/imgs/stash_pin-place.png',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               title: Container(
//                                 width: double.infinity,
//                                 margin: EdgeInsets.symmetric(horizontal: 20.0),
//                                 height: 40.0,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Color(0x7C000000),
//                                           blurRadius: 10.0)
//                                     ],
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: Center(
//                                   child: DropdownButton<String>(
//                                     items: placesOfCityOnSelected
//                                         ?.map((String place) {
//                                       return DropdownMenuItem<String>(
//                                         child: Text(place),
//                                         value: place,
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? placeValue) {
//                                       setState(() {
//                                         visibleOfNeighborhood = true;
//                                         placeSelected = placeValue;
//                                       });
//                                     },
//                                     menuMaxHeight: 300.0,
//                                     value: placeSelected,
//                                     hint: Text('select place'),
//                                     icon: Icon(
//                                         Icons.arrow_drop_down_circle_outlined,
//                                         size: 30.0,
//                                         color: mainColor),
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18.0,
//                                     ),
//                                     alignment: Alignment.center,
//                                     underline: null,
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         // //neighborhood
//                         Visibility(
//                           visible: visibleOfNeighborhood,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 20.0,
//                             ),
//                             child: ListTile(
//                               leading: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 width: 40.0,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color(0x7C000000),
//                                         blurRadius: 10.0)
//                                   ],
//                                 ),
//                                 child: Image.asset(
//                                   'assets/home_loves_tickets_top/imgs/nighborhood.png',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               title: Container(
//                                   width: double.infinity,
//                                   margin:
//                                       EdgeInsets.symmetric(horizontal: 20.0),
//                                   height: 40.0,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Color(0x7C000000),
//                                             blurRadius: 10.0)
//                                       ],
//                                       borderRadius:
//                                           BorderRadius.circular(10.0)),
//                                   child: TextField(
//                                     controller: neighborhoodEnterd,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 18.0,
//                                     ),
//                                     keyboardType: TextInputType.text,
//                                     textInputAction: TextInputAction.done,
//                                     decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding:
//                                             EdgeInsets.only(bottom: 10.0),
//                                         hintText: 'neighborhood'),
//                                   )),
//                             ),
//                           ),
//                         ),

//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         // //button
//                         Visibility(
//                           visible: checkInputs(),
//                           child: Create_GradiantGreenButton(
//                               title: 'Done',
//                               onButtonPressed: () {
//                                 setState(() {
//                                   visibleOfLocation = false;
//                                   initValueOfLocation();
//                                 });
//                               }),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// required input

class Create_RequiredInput extends StatelessWidget {
  Widget add_prefix;
  Widget? add_suffix = null;
  TextInputType textInputType;
  Create_RequiredInput({
    required this.add_prefix,
    this.add_suffix,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      maxLines: null,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      cursorColor: mainColor,
      decoration: InputDecoration(
        prefixIcon: add_prefix,
        suffix: add_suffix,
        fillColor: Color(0xB0F2F2F2),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: mainColor, width: 2.0)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black38, width: 2.0)),
      ),
    );
  }
}
