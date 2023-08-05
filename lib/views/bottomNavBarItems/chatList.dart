import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/bottomNavBarItems/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatTabPage extends StatefulWidget {
  const ChatTabPage({super.key});

  @override
  State<ChatTabPage> createState() => _ChatTabPageState();
}

class _ChatTabPageState extends State<ChatTabPage> {
  var usertype;
  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      usertype = prefs.getString('userType');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: background,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Color(0xff153f6e),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .where('users',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: yellow),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat(
                                  brandName: snapshot.data!.docs[index]
                                      ['brandName'],
                                  influencerName: snapshot.data!.docs[index]
                                      ['influencerName'],
                                  roomId: snapshot.data!.docs[index]['roomId'],
                                  usertype: usertype,
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: yellow,
                      radius: 32,
                      child: Center(
                        child: Text(
                          usertype == 'Brand'
                              ? snapshot.data!.docs[index]['influencerName']
                                  .substring(0, 1)
                                  .toUpperCase()
                              : snapshot.data!.docs[index]['brandName']
                                  .substring(0, 1)
                                  .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: usertype == 'Brand'
                        ? Text(
                            snapshot.data!.docs[index]['influencerName'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            snapshot.data!.docs[index]['brandName'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
