import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlybarter/views/Auth/otp.dart';
import 'package:onlybarter/utils/text_field_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phone = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    // final userTypeProvider = Provider.of<UserTypeProvider>(context);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: pressed == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          'Only Barter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: blue,
                          ),
                        )),
                    const SizedBox(height: 50),
                    FadeInDown(
                      delay: const Duration(milliseconds: 100),
                      child: const Text(
                        'Let\'s Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    // FadeInDown(
                    //   delay: const Duration(milliseconds: 200),
                    //   child: const Padding(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    //     child: Text(
                    //       'Enter your phone number to continue, we will send you OTP to verify.',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextField(
                          controller: phone,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            counterText: '',
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(color: Colors.black),
                            border: outlineInputBorder,
                            prefix: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                '+91',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (phone.text.trim().length != 10) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Phone number is not valid',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ));
                            return;
                          }

                          setState(() {
                            pressed = true;
                          });

                          await _auth.verifyPhoneNumber(
                            phoneNumber: "+91${phone.text}",
                            verificationCompleted:
                                (phoneAuthCredential) async {},
                            verificationFailed: (verificationFailed) async {
                              Navigator.of(context).pop();
                              setState(() {
                                pressed = false;
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    content: Text(
                                      verificationFailed.message.toString(),
                                    ),
                                  );
                                },
                              );
                            },
                            codeSent: (id, token) async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Otp(
                                            verificationId: id,
                                            fromSignup: false,
                                            data: {'phone': phone.text.trim()},
                                          )));
                            },
                            codeAutoRetrievalTimeout: (id) async {},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfffae10b),
                            elevation: 10,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.4,
                                vertical: 15)),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // FadeInDown(
                    //   delay: const Duration(milliseconds: 500),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.28,
                    //         child: Divider(
                    //           thickness: 1,
                    //           color: darkGrey,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text('Via Social Media',
                    //           style: TextStyle(
                    //             color: darkGrey,
                    //           )),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.28,
                    //         child: Divider(
                    //           thickness: 1,
                    //           color: darkGrey,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // FadeInDown(
                    //   delay: const Duration(milliseconds: 500),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () async {
                    //           try {
                    //             final GoogleSignInAccount? googleSignInAccount =
                    //                 await _googleSignIn.signIn();
                    //             if (googleSignInAccount != null) {
                    //               setState(() {
                    //                 pressed = true;
                    //               });
                    //               final GoogleSignInAuthentication
                    //                   googleSignInAuthentication =
                    //                   await googleSignInAccount.authentication;
                    //               final AuthCredential credential =
                    //                   GoogleAuthProvider.credential(
                    //                 accessToken:
                    //                     googleSignInAuthentication.accessToken,
                    //                 idToken: googleSignInAuthentication.idToken,
                    //               );
                    //               await _auth
                    //                   .signInWithCredential(credential)
                    //                   .then((value) async {
                    //                 if (value.additionalUserInfo!.isNewUser) {
                    //                   await FirebaseAuth.instance.currentUser!
                    //                       .updateDisplayName(
                    //                           value.user!.displayName);
                    //                   await FirebaseFirestore.instance
                    //                       .collection("Users")
                    //                       .doc(FirebaseAuth
                    //                           .instance.currentUser!.uid)
                    //                       .set({
                    //                     'name': value.user!.displayName,
                    //                     'phone': value.user!.phoneNumber,
                    //                     'email': value.user!.email.toString(),
                    //                     'gender': 'prefer not to display',
                    //                     'dob': '',
                    //                     'accountType': '',
                    //                     'profilePhoto': value.user!.photoURL,
                    //                     'link': '',
                    //                     'categories': [],
                    //                     'hideProfile': false,
                    //                     'hidePhone': false, 'hideEmail': false,
                    //                     'blocked': [],
                    //                     'location': '',
                    //                     // 'notification': [],
                    //                     'favourite': [],
                    //                     'blockedBy': []
                    //                   }, SetOptions(merge: true));

                    //                   final SharedPreferences prefs =
                    //                       await SharedPreferences.getInstance();
                    //                   prefs.setString('email',
                    //                       value.user!.email.toString());
                    //                   // Navigator.push(
                    //                   //     context,
                    //                   //     MaterialPageRoute(
                    //                   //         builder: ((context) =>
                    //                   //             EditProfilePage(
                    //                   //               snapshot: {
                    //                   //                 'name': value
                    //                   //                     .user!.displayName,
                    //                   //                 'phone': '',
                    //                   //                 'email': value.user!.email
                    //                   //                     .toString(),
                    //                   //                 'gender':
                    //                   //                     'prefer not to display',
                    //                   //                 'dob': '',
                    //                   //                 'accountType': '',
                    //                   //                 'profilePhoto':
                    //                   //                     value.user!.photoURL,
                    //                   //                 'link': '',
                    //                   //                 'categories': [],
                    //                   //                 'hideProfile': false,
                    //                   //                 'hidePhone': false,
                    //                   //                 'hideEmail': false,
                    //                   //                 'blocked': [],
                    //                   //                 'location': '',
                    //                   //                 // 'notification': [],
                    //                   //                 'favourite': [],
                    //                   //                 'blockedBy': []
                    //                   //               },
                    //                   //               fromlogin: true,
                    //                   //             ))));
                    //                 } else {
                    //                   final SharedPreferences prefs =
                    //                       await SharedPreferences.getInstance();
                    //                   prefs.setString('email',
                    //                       value.user!.email.toString());
                    //                   Navigator.pushReplacement(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: ((context) =>
                    //                               const HomeTabPage())));
                    //                 }
                    //               });
                    //             }
                    //           } on FirebaseAuthException catch (e) {
                    //             print(e.message);
                    //             setState(() {
                    //               pressed = false;
                    //             });
                    //             throw e;
                    //           }
                    //         },
                    //         child: Container(
                    //           width: 50,
                    //           height: 50,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(color: grey),
                    //               borderRadius: BorderRadius.circular(25),
                    //               color: Colors.white),
                    //           child: Center(
                    //             child: Image.asset(
                    //               'assets/images/google.png',
                    //               width: 40,
                    //               height: 40,
                    //               fit: BoxFit.contain,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 20,
                    //       ),
                    //       Container(
                    //         width: 50,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: grey),
                    //             borderRadius: BorderRadius.circular(25),
                    //             color: Colors.white),
                    //         child: Center(
                    //           child: Image.asset(
                    //             'assets/images/apple.png',
                    //             width: 40,
                    //             height: 40,
                    //             fit: BoxFit.contain,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
