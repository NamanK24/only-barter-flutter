import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/Auth/login.dart';
import 'package:onlybarter/views/Auth/signup.dart';
import 'package:onlybarter/views/bottom_nav_bar.dart';
import 'package:onlybarter/views/categories.dart';
import 'package:onlybarter/utils/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../provider/user_type.dart';

class Otp extends StatefulWidget {
  final verificationId, fromSignup, data;
  const Otp({Key? key, this.verificationId, this.fromSignup, this.data})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otp = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserTypeProvider>(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: const Text(
                  'Verification code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    'We have sent the code verification to\nYour Mobile Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInRight(
                delay: const Duration(milliseconds: 400),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  child: PinCodeTextField(
                    onChanged: (value) {},
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    controller: otp,
                    validator: (v) {
                      if (v!.length < 6) {
                        return 'Enter six digit OTP';
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      fieldHeight: 40,
                      shape: PinCodeFieldShape.circle,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      activeColor: yellow,
                      selectedColor: yellow,
                    ),
                    cursorColor: Colors.grey.shade500,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeInRight(
                delay: const Duration(milliseconds: 500),
                child: ElevatedButton(
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: otp.text);

                    try {
                      final authCredential = await FirebaseAuth.instance
                          .signInWithCredential(phoneAuthCredential);
                      var temp = await FirebaseFirestore.instance
                          .collection(userType.userType)
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();

                      if (authCredential.user != null) {
                        if (widget.fromSignup == false) {
                          if (authCredential.additionalUserInfo!.isNewUser ||
                              temp.exists == false) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignUp(phone: widget.data['phone'])),
                                (Route<dynamic> route) => false);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return const CupertinoAlertDialog(
                                  content: Text(
                                      'You are new user! Please signup first.'),
                                );
                              },
                            );
                          } else {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('phone', widget.data['phone']);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const NavBar()),
                                (Route<dynamic> route) => false);
                          }
                        }
                        if (widget.fromSignup == true) {
                          Map<String, dynamic> userInfoMap = widget.data;
                          var result = await databaseMethods
                              .userCheck(userInfoMap['email']);
                          if (result == true) {
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set(userInfoMap, SetOptions(merge: true));

                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('phone', widget.data['phone']);

                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(widget.data['name']);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const CategoryPage()),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'You are already logged in with this email using Google sign in',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ));

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (Route<dynamic> route) => false);
                            return;
                          }
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context);
                      print(e);
                    }
                  },
                  child: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffae10b),
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.4,
                          vertical: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
