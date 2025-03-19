import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({super.key, required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  // edit username
  final dialogusercontroler = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  MyDialog(Map data, dynamic mykey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: dialogusercontroler,
                    maxLength: 20,
                    decoration: InputDecoration(
                        hintText: "${data[mykey]}")),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (mykey == 'phoneNumber' && dialogusercontroler.text.length != 11) {
                            showSnackBar(context, "Phone number must be 11 digits");
                          } else {
                            users
                                .doc(credential!.uid)
                                .update({mykey: dialogusercontroler.text});
                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 22),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 22),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Username: ${data['username']}",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "eras-itc-bold"),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {
                      MyDialog(data, 'username');
                    }, icon: Icon(Icons.edit)),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                          Expanded(
                            child: Center(
                              child: Text("Location: ${data['location']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "eras-itc-bold",
                              )),
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                        ],
                  ),
                  Text("Date of Birth: ${data['dateOfBirth']}",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "eras-itc-bold",
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                          Expanded(
                            child: Center(
                              child: Text("Phone Number: ${data['phoneNumber']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "eras-itc-bold",
                              )),
                            ),
                          ),
                          IconButton(onPressed: (){
                            MyDialog(data, 'phoneNumber');
                          }, icon: Icon(Icons.edit)),
                        ],
                  ),
                ]),
          );
        }

        return Text("loading");
      },
    );
  }
}
