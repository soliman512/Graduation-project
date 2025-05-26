import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project_main/provider/language_provider.dart';

const Color mainColor = Color.fromARGB(255, 0, 185, 46);
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
Image logo = Image.asset('assets/welcome_signup_login/imgs/logo.png',
    fit: BoxFit.cover, width: 90.0, height: 90.0);

Image big_logo = Image.asset('assets/welcome_signup_login/imgs/logo.png',
    fit: BoxFit.cover, width: 100.0);

// Get text direction based on language
TextDirection getTextDirection(BuildContext context) {
  return Provider.of<LanguageProvider>(context, listen: false).isArabic 
      ? TextDirection.rtl 
      : TextDirection.ltr;
}

// Get governorate centers based on language
Map<String, List<String>> getGovernoratesCenters(BuildContext context) {
  final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
  
  if (isArabic) {
    return {
      'القاهرة': ['مدينة نصر', 'مصر الجديدة', 'المعادي', 'الزمالك', 'أخرى'],
      'الإسكندرية': ['المنتزة', 'الرمل', 'العامرية', 'العطارين', 'أخرى'],
      'الجيزة': ['الدقي', 'المهندسين', 'الهرم', '6 أكتوبر', 'أخرى'],
      'بورسعيد': ['بور فؤاد', 'العرب', 'المناخ', 'الضواحي', 'أخرى'],
      'الأقصر': ['الأقصر', 'أرمنت', 'إسنا', 'طيبة', 'أخرى'],
      'أسوان': ['أسوان', 'إدفو', 'كوم أمبو', 'نصر النوبة', 'أخرى'],
      // Add more Arabic translations as needed
    };
  } else {
    return egyptGovernoratesAndCenters; // Return the English version
  }
}

Image add_logo(double logoSize) {
  return Image.asset('assets/welcome_signup_login/imgs/logo.png',
      fit: BoxFit.cover, width: logoSize, height: logoSize);
}

//background image
Image backgroundImage = Image.asset(
    'assets/welcome_signup_login/imgs/Welcome.jpg',
    fit: BoxFit.cover,
    width: 90.0,
    height: 90.0);

//background image balls
Opacity backgroundImage_balls = Opacity(
    opacity: 0.02,
    child: Image.asset(
      'assets/sharedBackground.png',
      fit: BoxFit.fill,
    ));

//gradiant black background
Container blackBackground = Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
    Color.fromARGB(22, 27, 27, 27),
    Color(0xD3111111),
    Color.fromARGB(255, 0, 0, 0),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
);

//drawer options - uses LanguageProvider directly
List getDrawerOptions(BuildContext context) {
  final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
  
  return [
    // 0 : Home
    {
      'icon':
          Image.asset('assets/home_loves_tickets_top/imgs/Vector_drawerHome.png'),
      'title': Text(
        isArabic ? 'الرئيسية' : 'Home',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      'widtOfOption': 80.0
    },
    // 1 : Profile
    {
      'icon': Image.asset(
          'assets/home_loves_tickets_top/imgs/Vector_drawerProfile.png'),
      'title': Text(
        isArabic ? 'الملف الشخصي' : 'Profile',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      'widtOfOption': 10.0
    },
    // 2 : Settings
    {
      'icon': Image.asset(
        'assets/home_loves_tickets_top/imgs/vector_drawerSettings.png',
        fit: BoxFit.contain,
      ),
      'title': Text(
        isArabic ? 'الإعدادات' : 'Settings',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      'widtOfOption': 10.0
    },
    // 3 : Log out
    {
      'icon': Image.asset(
          'assets/home_loves_tickets_top/imgs/vector_drawerLog_out.png'),
      'title': Text(
        isArabic ? 'تسجيل الخروج' : 'Log out',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      'widtOfOption': 10.0
    },
  ];
}

// Keep this for backward compatibility
List drawerOptions = [
  // 0 : Home
  {
    'icon':
        Image.asset('assets/home_loves_tickets_top/imgs/Vector_drawerHome.png'),
    'title': Builder(builder: (context) {
      final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
      return Text(
        isArabic ? 'الرئيسية' : 'Home',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      );
    }),
    'widtOfOption': 80.0
  },
  // 1 : Profile
  {
    'icon': Image.asset(
        'assets/home_loves_tickets_top/imgs/Vector_drawerProfile.png'),
    'title': Builder(builder: (context) {
      final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
      return Text(
        isArabic ? 'الملف الشخصي' : 'Profile',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      );
    }),
    'widtOfOption': 10.0
  },
  // 2 : Settings
  {
    'icon': Image.asset(
        'assets/home_loves_tickets_top/imgs/vector_drawerSettings.png'),
    'title': Builder(builder: (context) {
      final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
      return Text(
        isArabic ? 'الإعدادات' : 'Settings',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      );
    }),
    'widtOfOption': 10.0
  },
  // 3 : Log out
  {
    'icon': Image.asset(
        'assets/home_loves_tickets_top/imgs/vector_drawerLog_out.png'),
    'title': Builder(builder: (context) {
      final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
      return Text(
        isArabic ? 'تسجيل الخروج' : 'Log out',
        style: TextStyle(color: Colors.black, fontSize: 18.0),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      );
    }),
    'widtOfOption': 10.0
  },
];
double widthOfDrawer_SelectedOption = 80.0;

// items until complete database

// location/cities

// Function to get localized governorates list based on context - uses LanguageProvider directly
List<String> getEgyptGovernorates(BuildContext context) {
  final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
  
  if (isArabic) {
    return [
      'القاهرة',
      'الإسكندرية',
      'الجيزة',
      'بورسعيد',
      'الأقصر',
      'أسوان',
      'أسيوط',
      'البحيرة',
      'بني سويف',
      'الدقهلية',
      'دمياط',
      'الفيوم',
      'الغربية',
      'الإسماعيلية',
      'كفر الشيخ',
      'مطروح',
      'المنيا',
      'المنوفية',
      'الوادي الجديد',
      'شمال سيناء',
      'القليوبية',
      'قنا',
      'البحر الأحمر',
      'الشرقية',
      'سوهاج',
      'جنوب سيناء',
      'السويس',
      'أخرى'
    ];
  } else {
    return [
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
      'Another'
    ];
  }
}

// For backward compatibility, keeping a static list
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
  'another'
];

Map<String, List<String>> egyptGovernoratesAndCenters = {
  'Cairo': ['Nasr City', 'Heliopolis', 'Maadi', 'Zamalek', 'another'],
  'Alexandria': ['Montaza', 'Raml', 'Amreya', 'Attarin', 'another'],
  'Giza': ['Dokki', 'Mohandessin', 'Haram', '6th of October', 'another'],
  'Port Said': ['Port Fouad', 'El Arab', 'El Manakh', 'El Dawahy', 'another'],
  'Luxor': ['Luxor', 'Armant', 'Esna', 'Tiba', 'another'],
  'Aswan': ['Aswan', 'Edfu', 'Kom Ombo', 'Nasr El Nuba', 'another'],
  'Asyut': [
    'Asyut',
    'Dairut',
    'Manfalut',
    'Abnub',
    'New Assiut City',
    'Abo Teej',
    'another'
  ],
  'Beheira': ['Damanhour', 'Kafr El Dawwar', 'Rashid', 'Edku', 'another'],
  'Beni Suef': ['Beni Suef', 'Nasser', 'Ihnasia', 'Biba', 'another'],
  'Dakahlia': ['Mansoura', 'Talkha', 'Mit Ghamr', 'Dekernes', 'another'],
  'Damietta': ['Damietta', 'Faraskur', 'Kafr Saad', 'Zarqa', 'another'],
  'Faiyum': ['Faiyum', 'Sinnuris', 'Tamiya', 'Ibsheway', 'another'],
  'Gharbia': [
    'Tanta',
    'El Mahalla El Kubra',
    'Kafr El Zayat',
    'Zifta',
    'another'
  ],
  'Ismailia': ['Ismailia', 'Qantara East', 'Qantara West', 'Fayed', 'another'],
  'Kafr El Sheikh': [
    'Kafr El Sheikh',
    'Desouk',
    'Baltim',
    'Sidi Salem',
    'another'
  ],
  'Matruh': ['Marsa Matruh', 'El Alamein', 'Sallum', 'Siwa', 'another'],
  'Minya': ['Minya', 'Beni Mazar', 'Maghagha', 'Mallawi', 'another'],
  'Monufia': ['Shibin El Kom', 'Menouf', 'Ashmoun', 'Sadat City', 'another'],
  'New Valley': ['Kharga', 'Dakhla', 'Farafra', 'Balat', 'another'],
  'North Sinai': ['Arish', 'Sheikh Zuweid', 'Rafah', 'Bir al-Abed', 'another'],
  'Qalyubia': ['Banha', 'Qalyub', 'Shubra El Kheima', 'Tukh', 'another'],
  'Qena': ['Qena', 'Nag Hammadi', 'Qus', 'Abu Tesht', 'another'],
  'Red Sea': ['Hurghada', 'Safaga', 'Quseer', 'Marsa Alam', 'another'],
  'Sharqia': ['Zagazig', 'Belbeis', 'Minya El Qamh', 'Abu Hammad', 'another'],
  'Sohag': ['Sohag', 'Akhmim', 'Girga', 'Tahta', 'another'],
  'South Sinai': ['Sharm El Sheikh', 'Dahab', 'Nuweiba', 'Taba', 'another'],
  'Suez': ['Arbaeen', 'Ganayen', 'Attaka', 'Faisal', 'another'],
  'another': [
    'another',
  ]
};
List<String>? placesOfCityOnSelected;
String? citySelected;
String? placeSelected;
TextEditingController neighborhoodEnterd = TextEditingController();


// Function to get localized governorate widgets - uses LanguageProvider directly
List<Widget> getEgyptGovernoratesWidgets(BuildContext context) {
  final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
  final TextDirection textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
  
  return getEgyptGovernorates(context).map((governorate) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          governorate,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          textDirection: textDirection,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }).toList();
}

// For backward compatibility, keeping a static list
List<Widget> egyptGovernoratesWidgets = egyptGovernorates.map((governorate) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        governorate,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}).toList();
// Function to get place widgets with proper text direction
List<Widget> getGovernmentPlacesWidgets(BuildContext context) {
  final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
  final TextDirection textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
  final governorateCenters = getGovernoratesCenters(context);
  
  // Get the appropriate key based on language
  String? key = citySelected;
  if (isArabic && citySelected != null) {
    // Find the Arabic equivalent of the selected city
    final englishGovernorates = egyptGovernorates;
    final arabicGovernorates = getEgyptGovernorates(context);
    final index = englishGovernorates.indexOf(citySelected!);
    if (index >= 0 && index < arabicGovernorates.length) {
      key = arabicGovernorates[index];
    }
  }
  
  return governorateCenters.containsKey(key)
      ? governorateCenters[key]!.map((place) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                place,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                textDirection: textDirection,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList()
      : []; // Return an empty list if the selected city doesn't exist in the map
}

// For backward compatibility
List<Widget> gevornmentPlacesWidgets = egyptGovernoratesAndCenters
        .containsKey(citySelected)
    ? egyptGovernoratesAndCenters[citySelected]!.map((place) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Builder(builder: (context) {
              final bool isArabic = Provider.of<LanguageProvider>(context).isArabic;
              final TextDirection textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
              return Text(
                place,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                textDirection: textDirection,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
          ),
        );
      }).toList()
    : []; // Return an empty list if the selected city doesn't exist in the map
