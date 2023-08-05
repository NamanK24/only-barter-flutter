import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlybarter/views/bottom_nav_bar.dart';
import 'package:onlybarter/utils/text_field_decoration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../provider/user_type.dart';
import '../../utils/age.dart';
import '../../utils/colors.dart';
import '../../utils/database.dart';
import '../categories.dart';

class SignUp extends StatefulWidget {
  final String phone;
  const SignUp({super.key, required this.phone});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController phone = TextEditingController();
  TextEditingController brandName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController designation = TextEditingController();

  TextEditingController dobController = TextEditingController();
  final genderList = ["Male", "Female", "Other"];
  AgeDuration? age;
  String? genderSelected;
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void initState() {
    super.initState();
    phone.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserTypeProvider>(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              FadeInDown(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Only Barter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: blue,
                    ),
                  )),
              const SizedBox(height: 20),
              FadeInDown(
                child: const Text(
                  'Join Us!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userType.userType == 'Brand'
                  ? Column(
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 100),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: brandName,
                              style: const TextStyle(),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.copyright,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Brand Name',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: phone,
                              maxLength: 10,
                              style: const TextStyle(),
                              readOnly: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Phone Number',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                prefix: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '+91',
                                    style: TextStyle(),
                                  ),
                                ),
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: email,
                              style: const TextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: TextField(
                              controller: designation,
                              style: const TextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_3_rounded,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Designation',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: TextField(
                              controller: name,
                              style: const TextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Full name',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: TextField(
                              controller: website,
                              style: const TextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.link,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Website',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 100),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: name,
                              style: const TextStyle(),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Name',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: phone,
                              maxLength: 10,
                              style: const TextStyle(),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Phone Number',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                prefix: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '+91',
                                    style: TextStyle(),
                                  ),
                                ),
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: TextField(
                              controller: email,
                              style: const TextStyle(),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                counterText: '',
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 0),
                            child: TextFormField(
                              controller: dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'Select Date Of Birth',
                                hintStyle: const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.black,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18,
                                ),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                              ),
                              style: const TextStyle(),
                              onTap: () async {
                                var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (date == null) return;
                                dobController.text =
                                    date.toString().substring(0, 10);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 0),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText:
                                  genderSelected != null ? "Gender" : null,
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                isDense: true,
                                hint: const Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                value: genderSelected,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    genderSelected = value!;
                                  });
                                },
                                items: genderList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 700),
                child: ElevatedButton(
                  onPressed: () async {
                    if (name.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Name can\'t be empty',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ));
                      return;
                    }
                    if (phone.text.trim().length != 10) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Phone number is not valid',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ));
                      return;
                    }
                    if (email.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Email can\'t be empty',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ));
                      return;
                    }

                    if (userType.userType == 'Brand') {
                      if (brandName.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Brand Name can\'t be empty',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                        return;
                      }
                      if (designation.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Designation can\'t be empty',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                        return;
                      }
                    } else {
                      if (dobController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Date of birth can\'t be empty.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                        return;
                      }
                      age = Age.dateDifference(
                          fromDate: DateTime.parse(dobController.text),
                          toDate: DateTime.now(),
                          includeToDate: false);

                      if (age!.years < 18) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Minimum age requirement is 18.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                        return;
                      }

                      if (genderSelected == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Gender can\'t be empty.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                        return;
                      }
                    }

                    var result = await databaseMethods.userCheck(email.text);
                    if (result == true) {
                      if (userType.userType == 'Brand') {
                        FirebaseAuth.instance.currentUser!
                            .updateDisplayName(brandName.text.trim());
                        await FirebaseFirestore.instance
                            .collection(userType.userType)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'name': name.text.trim(),
                          'brandName': brandName.text.trim(),
                          'phone': phone.text.trim(),
                          'designation': designation.text.trim(),
                          'email': email.text.trim(),
                          'profilePhoto': null,
                          'website': website.text.trim(),
                          'dateTime': DateTime.now(),
                          'connects': 0,
                          'colabs': 0,
                        }, SetOptions(merge: true));

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const NavBar()),
                            (Route<dynamic> route) => false);
                      } else {
                        await FirebaseFirestore.instance
                            .collection(userType.userType)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'name': name.text.trim(),
                          'phone': phone.text.trim(),
                          'email': email.text.trim(),
                          'gender': genderSelected,
                          'dob': dobController.text.trim(),
                          'profilePhoto': null,
                          'dateTime': DateTime.now(),
                          'categories': [],
                          'connects': 0,
                          'collabs': 0,
                          'city': '',
                          'state': '',
                          'instagramSelected': false,
                          'youtubeSelected': false,
                        }, SetOptions(merge: true));

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const CategoryPage()),
                            (Route<dynamic> route) => false);
                      }

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('phone', phone.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'You are already logged in with this email using Google sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellow,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.4,
                          vertical: 15)),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
