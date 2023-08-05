import 'package:flutter/material.dart';

class UserTypeProvider extends ChangeNotifier {
  String _userType = '';

  String get userType => _userType;
  UserTypeProvider({String? usertype}) {
    _userType = userType;
    notifyListeners();
  }

  set userType(String value) {
    _userType = value;
    notifyListeners();
  }
}
