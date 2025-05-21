import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:graduation_project_main/constants/constants.dart';
import 'package:graduation_project_main/provider/language_provider.dart';
import 'package:graduation_project_main/reusable_widgets/reusable_widgets.dart';
import 'package:graduation_project_main/welcome_signup_login/signUpPages/shared/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();
  String? dateOfBirth;
  DateTime? selectedDate;
  File? imgPath;
  firebase_auth.User? user;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      fetchUserData();
    }
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      
      if (docSnapshot.exists) {
        setState(() {
          userData = docSnapshot.data();
          usernameController.text = userData?['username'] ?? '';
          phoneNumberController.text = userData?['phoneNumber'] ?? '';
          locationController.text = userData?['location'] ?? '';
          dateOfBirth = userData?['dateOfBirth'];
          if (dateOfBirth != null && dateOfBirth!.isNotEmpty) {
            try {
              selectedDate = DateTime.parse(dateOfBirth!);
            } catch (e) {
              print('Error parsing date: $e');
            }
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('User document does not exist');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  // Upload image
  Future<void> uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  // Save profile data
  Future<void> saveProfileData() async {
     final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
    if (user == null) return;
    
    setState(() {
      isSaving = true;
    });

    try {
      // Prepare data to update
      Map<String, dynamic> dataToUpdate = {
        'username': usernameController.text,
        'phoneNumber': phoneNumberController.text,
        'location': locationController.text,
      };
      
      if (dateOfBirth != null) {
        dataToUpdate['dateOfBirth'] = dateOfBirth;
      }

      // Upload new image if selected
      if (imgPath != null) {
        final SupabaseClient supabase = Supabase.instance.client;
        final String uniqueFileName = '${user!.uid}_${DateTime.now().millisecondsSinceEpoch}.png';

        try {
          // Upload the image to Supabase storage
          final String fullPath = await supabase.storage.from('photo').upload(
                'public/$uniqueFileName',
                imgPath!,
                fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
              );

          // Get the public URL of the uploaded image with cache-busting parameter
          String url = supabase.storage.from('photo').getPublicUrl('public/$uniqueFileName');
          // Add a timestamp parameter to prevent caching issues
          url = '$url?t=${DateTime.now().millisecondsSinceEpoch}';
          
          print('Image uploaded successfully. URL: $url');
          
          // Add the image URL to the data to update
          dataToUpdate['profileImage'] = url;
        } catch (e) {
          print('Error uploading image: $e');
          showSnackBar(context, isArabic ? "خطأ في تحميل الصورة: $e" : "Error uploading image: $e");
        }
      }

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(dataToUpdate);
          
      // Profile has been successfully updated

      showSnackBar(context, isArabic ? "تم تحديث الملف الشخصي بنجاح" : "Profile updated successfully");
      
      // Add a small delay to ensure Firestore update is complete before returning
      await Future.delayed(Duration(milliseconds: 500));
      
      // Force refresh of the drawer by popping with a refresh flag
      // This ensures the drawer will reload user data when we return
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
showSnackBar(context, isArabic ? "خطأ في تحديث الملف الشخصي: $e" : "Error updating profile: $e");
     } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: isArabic ? 'اختر تاريخ الميلاد' : 'Select Date of Birth',
      cancelText: isArabic ? 'إلغاء' : 'Cancel',
      confirmText: isArabic ? 'تأكيد' : 'OK',
      builder: (context, child) {
        // Use a simpler approach without Directionality widget
        return Theme(
          data: Theme.of(context).copyWith(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirth = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
      return Scaffold(
         backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
        titleSpacing: 8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
            isArabic ? "تعديل " : "Edit ",
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
             fontSize: 20,
                fontFamily: 'eras-itc-bold',
             
            ),
          ),
            Text(
              isArabic ? "الملف" : "pro",
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 122, 0),
              ),
            ),
            Text(
              isArabic ? "الشخصي" : "file",
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
           
            
          ],
        ),
         
          toolbarHeight: 80.0,
          elevation: 0,
          backgroundColor: Color(0x00),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/welcome_signup_login/imgs/back.png",
              color: Color(0xFF000000),
              width: 30,
              height: 30,
            ),
          ),
        ),
        body: Stack(
          children: [
            backgroundImage_balls,
            Center(
              child: CircularProgressIndicator(color: mainColor),
            ),
          ],
        ),
      );
    }
final bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         centerTitle: true,
        titleSpacing: 13,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
            isArabic ? "تعديل " : "Edit ",
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
             fontSize: 20,
                fontFamily: 'eras-itc-bold',
             
            ),
          ),
            Text(
              isArabic ? "الملف" : "pro",
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 122, 0),
              ),
            ),
            Text(
              isArabic ? "الشخصي" : "file",
              style: TextStyle(
                fontSize:  23,
                fontFamily: 'eras-itc-bold',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Color(0x00),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/welcome_signup_login/imgs/back.png",
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage_balls,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              // Profile Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: mainColor,
                    width: 2.5,
                  ),
                ),
                child: Stack(
                  children: [
                    if (imgPath != null)
                      ClipOval(
                        child: Image.file(
                          imgPath!,
                          width: 154.0,
                          height: 154.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (userData != null && userData!['profileImage'] != null)
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 225, 225, 225),
                        radius: 77.0,
                        backgroundImage: NetworkImage(userData!['profileImage']),
                      )
                    else
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 225, 225, 225),
                        radius: 77.0,
                        backgroundImage: AssetImage(
                            "assets/welcome_signup_login/imgs/avatar.png"),
                      ),
                    Positioned(
                      bottom: -6,
                      right: -1,
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: mainColor,
                            width: 1.5,
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: uploadImage2Screen,
                          icon: Icon(Icons.add_a_photo),
                          iconSize: 20,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              
              // Section Title
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              //   margin: EdgeInsets.only(bottom: 20),
              //   decoration: BoxDecoration(
              //     gradient: greenGradientColor,
              //     borderRadius: BorderRadius.circular(15),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.2),
              //         blurRadius: 4,
              //         offset: Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   child: Text(
              //     "Edit Your Information",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontFamily: 'eras-itc-bold',
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              
              // Form fields - using the app's style
              Create_Input(
                controller: usernameController,
                isPassword: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hintText: isArabic ? "اسم المستخدم" : "Username",
                addPrefixIcon: Icon(
                  Icons.person,
                  color: mainColor,
                ),
              ),
              SizedBox(height: 20),
              
              Create_Input(
                controller: phoneNumberController,
                isPassword: false,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                hintText: isArabic ? "رقم الهاتف" : "Phone Number",
                addPrefixIcon: Icon(
                  Icons.phone,
                  color: mainColor,
                ),
              ),
              SizedBox(height: 20),
              
              Create_Input(
                onChange: (value) {
                  locationController.text = value;
                },
                on_tap: () {
                  BottomPicker(
                    items: isArabic
                        ? getEgyptGovernoratesWidgets(context)
                        : egyptGovernoratesWidgets,
                    height: 600.0,
                    titlePadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    buttonContent: Icon(Icons.navigate_next_rounded,
                        color: Colors.white, size: 22.0),
                    buttonPadding: 10.0,
                    buttonStyle: BoxDecoration(
                      gradient: greenGradientColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    pickerTextStyle:
                        TextStyle(fontSize: 20.0, color: Colors.black),
                    pickerTitle: Text(isArabic ? "اختر المحافظة" : "Select Governorate",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 24.0)),
                    pickerDescription: Text(
                        isArabic ? "اختر المحافظة التي تعيش فيها" : "Choose the governorate where you are located",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                    onSubmit: (selectedIndex) {
                      String governorate = isArabic
                          ? getEgyptGovernorates(context)[selectedIndex]
                          : egyptGovernorates[selectedIndex];
                      String citySelected = governorate;
                      
                      // Navigator.pop(context);

                      Future.delayed(Duration(milliseconds: 300), () {
                        // Start place picker
                        List<Widget> placeWidgets =
                            egyptGovernoratesAndCenters[citySelected]!
                                .map((place) => Center(
                                      child: Text(
                                        place,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ))
                                .toList();

                        BottomPicker(
                          items: placeWidgets,
                          height: 600.0,
                          titlePadding:
                              EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          buttonContent: Icon(Icons.navigate_next_rounded,
                              color: Colors.white, size: 22.0),
                          buttonPadding: 10.0,
                          buttonStyle: BoxDecoration(
                            gradient: greenGradientColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          pickerTextStyle: TextStyle(
                              fontSize: 20.0, color: Colors.black),
                          pickerTitle: Text(isArabic ? "اختر المكان" : "Select Place",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24.0)),
                          pickerDescription: Text(
                              isArabic ? "اختر المكان الذي تعيش فيه" : "Choose the place where you are located",
                              style:
                                  TextStyle(fontWeight: FontWeight.w400)),
                          onSubmit: (selectedPlaceIndex) {
                            String placeSelected = egyptGovernoratesAndCenters[
                                citySelected]![selectedPlaceIndex];
                            
                            Future.delayed(Duration(milliseconds: 300), () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  TextEditingController neighborhoodEnterd = TextEditingController();
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          20,
                                      top: 20,
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(isArabic ? "أدخل الحي" : "Enter Neighborhood",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        SizedBox(height: 15),
                                        Create_RequiredInput(
                                          onChange: (value) {
                                            neighborhoodEnterd.text = value;
                                          },
                                          lableText:
                                                  isArabic ? "أدخل الحي" : "Enter your neighborhood",
                                          initValue:
                                              neighborhoodEnterd.text,
                                          textInputType: TextInputType.text,
                                          add_prefix: Icon(
                                              Icons.location_on,
                                              color: mainColor),
                                        ),
                                        SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              locationController.text =
                                                  '$citySelected - $placeSelected - ${neighborhoodEnterd.text}';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: greenGradientColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24,
                                                vertical: 12),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        ).show(context);
                      });
                    },
                  ).show(context);
                },
                controller: locationController,
                isPassword: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                isReadOnly: true,
                hintText: isArabic ? "الموقع" : "Location",
                addPrefixIcon: Icon(
                  Icons.location_on,
                  color: mainColor,
                ),
              ),
              SizedBox(height: 20),
              
              // Date of Birth
              Create_Input(
                controller: TextEditingController(
                  text: selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : ''
                ),
                on_tap: () => _selectDate(context),
                isReadOnly: true,
                isPassword: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hintText: isArabic ? "تاريخ الميلاد" : "Date of Birth",
                addPrefixIcon: Icon(
                  Icons.calendar_today,
                  color: mainColor,
                ),
              ),
              SizedBox(height: 40),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Create_GradiantGreenButton(
                  onButtonPressed: isSaving ? () {} : saveProfileData,
                  content: isSaving
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              isArabic ? "حفظ التغييرات" : "Save Changes",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'eras-itc-bold',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 20),
              
              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Create_WhiteButton(
                  onButtonPressed: () {
                    Navigator.pop(context);
                  },
                  title: isArabic ? "إلغاء" : "Cancel",
                ),
              ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}