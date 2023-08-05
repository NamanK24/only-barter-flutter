import 'package:flutter/material.dart';
import 'package:onlybarter/provider/user_type.dart';
import 'package:onlybarter/views/Auth/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({super.key});

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  bool isISelected = false;
  bool isBSelected = false;

  @override
  Widget build(BuildContext context) {
    final userTypeProvider = Provider.of<UserTypeProvider>(context);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Tell us who you are.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isISelected = true;
                          isBSelected = false;
                          userTypeProvider.userType = 'Influencer';
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('userType', 'Influencer');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.18,
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isISelected ? yellow : Colors.transparent,
                            width: 5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/influencer_logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Influencer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isBSelected = true;
                          isISelected = false;
                          userTypeProvider.userType = 'Brand';
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('userType', 'Brand');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.18,
                        height: MediaQuery.of(context).size.height * 0.18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isBSelected ? yellow : Colors.transparent,
                            width: 5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/brands_logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Brand',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: yellow,
                elevation: 5,
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.35,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
