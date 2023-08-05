import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/Ads/create_campaign_screen_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  String? usertype;
  @override
  void initState() {
    getUserType();
    super.initState();
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertype = prefs.getString('userType');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateCampaignScreen1()));
        },
        tooltip: 'Create Campaign',
        shape: const CircleBorder(),
        backgroundColor: blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text(usertype.toString()),
      ),
    );
  }
}
