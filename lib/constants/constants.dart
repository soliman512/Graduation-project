import 'package:flutter/material.dart';

const Color mainColor = Color(0xff00B92E);
const LinearGradient greenGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xff005706),
    Color(0xff007211),
    Color(0xff00911E),
    Color(0xff00B92E),
  ],
);
//logo
Image logo = Image.asset('../../assets/welcome_signup_login/imgs/logo.png',
    fit: BoxFit.cover, width: 90.0, height: 90.0);

Image big_logo = Image.asset('../../assets/welcome_signup_login/imgs/logo.png',
    fit: BoxFit.cover, width: 158.0, height: 158.0);

Image add_logo(double logoSize) {
  return Image.asset('../../assets/welcome_signup_login/imgs/logo.png',
      fit: BoxFit.cover, width: logoSize, height: logoSize);
}

//background image
Image backgroundImage = Image.asset(
    '../../assets/welcome_signup_login/imgs/welcome.jpg',
    fit: BoxFit.cover,
    width: 90.0,
    height: 90.0);

//background image balls
Opacity backgroundImage_balls = Opacity(
    opacity: 0.08,
    child: Image.asset(
      '../../../assets/sharedBackground.png',
      fit: BoxFit.fill,
    ));

//gradiant black background
Container blackBackground = Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
    Color(0x00000000),
    Color(0x86000000),
    Color(0xBE000000),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
);

//drawer options
List drawerOptions = [
  // 0 : Home
  {
    'icon': Image.asset(
        '../../../assets/home_loves_tickets_top/imgs/Vector_drawerHome.png'),
    'title': Text(
      'Home',
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
    'widtOfOption': 80.0
  },
  // 1 : Profile
  {
    'icon': Image.asset(
        '../../../assets/home_loves_tickets_top/imgs/Vector_drawerProfile.png'),
    'title': Text(
      'Profile',
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
    'widtOfOption': 10.0
  },
  // 2 : Settings
  {
    'icon': Image.asset(
        '../../../assets/home_loves_tickets_top/imgs/vector_drawerSettings.png'),
    'title': Text(
      'Settings',
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
    'widtOfOption': 10.0
  },
  // 3 : Log out
  {
    'icon': Image.asset(
        '../../../assets/home_loves_tickets_top/imgs/vector_drawerLog_out.png'),
    'title': Text(
      'Log out',
      style: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
    'widtOfOption': 10.0
  },
];
double widthOfDrawer_SelectedOption = 80.0;

// items until complete database

// location/cities

List<String> egyptGovernorates = [
  'Cairo',
  'Alexandria',
  'Giza',
  'Port Said',
  'Luxor',
  'Aswan',
  'Asyut',
  'Beheira',
  'Beni Suef',
  'Dakahlia',
  'Damietta',
  'Faiyum',
  'Gharbia',
  'Ismailia',
  'Kafr El Sheikh',
  'Matruh',
  'Minya',
  'Monufia',
  'New Valley',
  'North Sinai',
  'Qalyubia',
  'Qena',
  'Red Sea',
  'Sharqia',
  'Sohag',
  'South Sinai',
  'Suez',
];

Map<String, List<String>> egyptGovernoratesAndCenters = {
  'Cairo': ['Nasr City', 'Heliopolis', 'Maadi', 'Zamalek'],
  'Alexandria': ['Montaza', 'Raml', 'Amreya', 'Attarin'],
  'Giza': ['Dokki', 'Mohandessin', 'Haram', '6th of October'],
  'Port Said': ['Port Fouad', 'El Arab', 'El Manakh', 'El Dawahy'],
  'Luxor': ['Luxor', 'Armant', 'Esna', 'Tiba'],
  'Aswan': ['Aswan', 'Edfu', 'Kom Ombo', 'Nasr El Nuba'],
  'Asyut': [
    'Asyut',
    'Dairut',
    'Manfalut',
    'Abnub',
    'New Assiut City',
    'Abo Teej'
  ],
  'Beheira': ['Damanhour', 'Kafr El Dawwar', 'Rashid', 'Edku'],
  'Beni Suef': ['Beni Suef', 'Nasser', 'Ihnasia', 'Biba'],
  'Dakahlia': ['Mansoura', 'Talkha', 'Mit Ghamr', 'Dekernes'],
  'Damietta': ['Damietta', 'Faraskur', 'Kafr Saad', 'Zarqa'],
  'Faiyum': ['Faiyum', 'Sinnuris', 'Tamiya', 'Ibsheway'],
  'Gharbia': ['Tanta', 'El Mahalla El Kubra', 'Kafr El Zayat', 'Zifta'],
  'Ismailia': ['Ismailia', 'Qantara East', 'Qantara West', 'Fayed'],
  'Kafr El Sheikh': ['Kafr El Sheikh', 'Desouk', 'Baltim', 'Sidi Salem'],
  'Matruh': ['Marsa Matruh', 'El Alamein', 'Sallum', 'Siwa'],
  'Minya': ['Minya', 'Beni Mazar', 'Maghagha', 'Mallawi'],
  'Monufia': ['Shibin El Kom', 'Menouf', 'Ashmoun', 'Sadat City'],
  'New Valley': ['Kharga', 'Dakhla', 'Farafra', 'Balat'],
  'North Sinai': ['Arish', 'Sheikh Zuweid', 'Rafah', 'Bir al-Abed'],
  'Qalyubia': ['Banha', 'Qalyub', 'Shubra El Kheima', 'Tukh'],
  'Qena': ['Qena', 'Nag Hammadi', 'Qus', 'Abu Tesht'],
  'Red Sea': ['Hurghada', 'Safaga', 'Quseer', 'Marsa Alam'],
  'Sharqia': ['Zagazig', 'Belbeis', 'Minya El Qamh', 'Abu Hammad'],
  'Sohag': ['Sohag', 'Akhmim', 'Girga', 'Tahta'],
  'South Sinai': ['Sharm El Sheikh', 'Dahab', 'Nuweiba', 'Taba'],
  'Suez': ['Arbaeen', 'Ganayen', 'Attaka', 'Faisal'],
};
List<String>? placesOfCityOnSelected;
String? citySelected;
String? placeSelected;
TextEditingController neighborhoodEnterd = TextEditingController();
