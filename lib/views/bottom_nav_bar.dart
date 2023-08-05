import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/bottomNavBarItems/brand_profile.dart';
import 'package:onlybarter/views/bottomNavBarItems/home.dart';
import 'package:onlybarter/views/bottomNavBarItems/influencer_profile.dart';
import 'package:onlybarter/views/bottomNavBarItems/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottomNavBarItems/chatList.dart';
import 'bottomNavBarItems/influ_campaign.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  var userType;

  final iTabs = [
    const HomeTabPage(),
    const CampaignSearch(),
    const ChatTabPage(),
    const InflencerProfile()
  ];

  final bTabs = [
    const HomeTabPage(),
    const RequestTabPage(),
    const ChatTabPage(),
    const BrandProfile()
  ];

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('userType');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: '2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_rounded),
            label: '3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '4',
          ),
        ],
        selectedItemColor: yellow,
        unselectedItemColor: blue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        iconSize: 32,
        backgroundColor: background,
        elevation: 0,
      ),
      body: userType == 'Brand' ? bTabs[selectedIndex] : iTabs[selectedIndex],
    );
  }
}
