import 'package:firebase_core/firebase_core.dart';
import 'package:onlybarter/provider/user_type.dart';
import 'package:onlybarter/views/bottom_nav_bar.dart';
import 'package:onlybarter/views/select_user_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

String? phone;
String? email;
String? usertype;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone = prefs.getString('phone');
  email = prefs.getString('email');
  usertype = prefs.getString('userType');
  if (usertype == null) {
    usertype = '';
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
        child: ChangeNotifierProvider<UserTypeProvider>(
      create: (_) => UserTypeProvider(usertype: usertype),
      child: Builder(builder: (context) {
        // final userType = Provider.of<UserTypeProvider>(context);
        // userType.userType = usertype!;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: phone == null && email == null
              ? const SelectUserType()
              : const NavBar(),
          theme: ThemeData(useMaterial3: true),
        );
      }),
    ));
  }
}
