import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  userCheck(email) async {
    final result = await FirebaseFirestore.instance
        .collection("Users")
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isEmpty;
  }
}
