import 'package:flutter/material.dart';

class Cardss extends StatelessWidget {
  const Cardss({key});

  Widget buildCard({
    required BuildContext context,
    required String title,
    required String location,
    required String imageUrl,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/book');
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.green, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
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
              padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff00B92E),
                        fontFamily: "myfont",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "myfont",
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        color: const Color.fromARGB(255, 130, 128, 128),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cards"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: buildCard(
                    context: context,
                    title: "Barca",
                    location: "Assiut_Al-Azhar",
                    imageUrl: "assets/imgs/120316-ملعب-خماسى--(2).jpg",
                    price: "EGP 300.00",
                  ),
                  margin: EdgeInsets.only(bottom: 16.0),
                ),
                SizedBox(height: 16),
                buildCard(
                  context: context,
                  title: "Wembley",
                  location: "New Assiut_suzan",
                  imageUrl:
                      "assets/imgs/251123-BFCA3674-9133-44F9-9BE9-8F5433D236E6.jpeg",
                  price: "EGP 250.00",
                ),
                SizedBox(height: 16),
                buildCard(
                  context: context,
                  title: "Camp Nou",
                  location: "Barcelona_Spain",
                  imageUrl:
                      "assets/imgs/pngtree-the-camp-nou-stadium-in-barcelona-spain-sport-nou-angle-photo-image_4879020.jpg",
                  price: "EGP 1200.00",
                ),
                SizedBox(height: 16),
                buildCard(
                    context: context,
                    title: "Anfield",
                    location: "Liverpool_England",
                    imageUrl: "assets/imgs/Liverpool-Banner-1.jpg",
                    price: "EGP 1000.00"),
                SizedBox(height: 16),
                buildCard(
                    context: context,
                    title: "Emirates",
                    location: "London_England",
                    imageUrl:
                        "assets/imgs/photo-1686053246042-43acf5121d86.jpg",
                    price: "EGP 1250.00"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
