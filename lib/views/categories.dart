import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/provider/user_type.dart';
import 'package:onlybarter/views/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

List selected = [];
final len = ValueNotifier<int>(0);

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isISelected = false;
  bool isYSelected = false;

  String? selectedState;
  String? selectedCity;

  List categories = [
    'Lifestyle',
    'Beauty & Wellness',
    'Fitness & Wellness',
    'Travel',
    'Food',
    'Gaming',
    'Parenting',
    'Technology',
    'Business & Enterpreneur',
    'Social Issues & Advocacy'
  ];

  List isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserTypeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: background,
      ),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              const Text(
                'Which Platform Influencer you are?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        isISelected = !isISelected;
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isISelected == true
                              ? yellow
                              : Colors.grey.shade400,
                          width: isISelected == true ? 5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/instagram.png',
                            width: 40,
                            height: 40,
                          ),
                          const Text(
                            'Instagram',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      isYSelected = !isYSelected;
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isYSelected == true
                              ? yellow
                              : Colors.grey.shade400,
                          width: isYSelected == true ? 5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/youtube.png',
                            width: 40,
                            height: 40,
                          ),
                          const Text(
                            'Youtube',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const Text(
                'Select Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'You can select upto 3',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 11 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      int c =
                          isSelected.where((element) => element == true).length;

                      if (c < 3) {
                        isSelected[index] = !isSelected[index];
                      } else {
                        isSelected[index] = false;
                      }

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected[index]
                              ? Colors.transparent
                              : Colors.grey.shade400,
                          width: 1,
                        ),
                        color: isSelected[index] ? yellow : null,
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              CSCPicker(
                onCountryChanged: (value) {
                  setState(() {
                    selectedState = null;
                    selectedCity = null;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    selectedState = value;
                    selectedCity = null;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (isISelected == false && isYSelected == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please select atleast one platform',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  int c = isSelected.where((element) => element == true).length;
                  if (c <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please select atleast one category',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  if (selectedState == null || selectedCity == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'State and City can\'t be empty',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  List l = [];
                  for (int i = 0; i < isSelected.length; i++) {
                    if (isSelected[i] == true) {
                      l.add(categories[i]);
                    }
                  }

                  await FirebaseFirestore.instance
                      .collection(userType.userType)
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'categories': l,
                    'city': selectedCity,
                    'state': selectedState,
                    'instagramSelected': isISelected,
                    'youtubeSelected': isYSelected,
                  });

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const NavBar()),
                      (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellow,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
