import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/age.dart';
import 'package:onlybarter/views/select_user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';
import '../Tabs/Featured.dart';
import '../Tabs/all.dart';

class InflencerProfile extends StatefulWidget {
  const InflencerProfile({super.key});

  @override
  State<InflencerProfile> createState() => _InflencerProfileState();
}

class _InflencerProfileState extends State<InflencerProfile>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  String? usertype;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: 2, vsync: this);
    getUserType();
    controller!.addListener(() {
      setState(() {});
    });
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertype = prefs.getString('userType');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          automaticallyImplyLeading: false,
          title: const Text(
            "Only Barter",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const More(),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                ))
          ],
          elevation: 0,
          backgroundColor: background,
        ),
        body: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(usertype.toString())
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  var age = Age.dateDifference(
                      fromDate: DateTime.parse(snapshot.data!['dob']),
                      toDate: DateTime.now(),
                      includeToDate: false);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: snapshot.data!['profilePhoto'] ==
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              color: yellow,
                                              child: Center(
                                                child: Text(
                                                  snapshot.data!['name']
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data![
                                                                'profilePhoto']),
                                                        fit: BoxFit.cover)),
                                                child: null)),
                                  ),
                                  Text(
                                    snapshot.data!['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!['gender']
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        ', ' +
                                        age.years.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.15),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'State   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!['state'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'City   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!['city'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Connects   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!['connects'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Collabs   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!['collabs'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xfff9dd09),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      snapshot.data!['categories'][index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!['categories'].length,
                          ),
                        ),
                      ),
                    ],
                  );
                })),
            TabBar(
              indicatorColor: const Color(0xfff9dd09),
              labelColor: blue,
              unselectedLabelColor: blue,
              labelStyle: const TextStyle(fontSize: 18),
              indicatorSize: TabBarIndicatorSize.label,
              controller: controller,
              isScrollable: true,
              tabs: const [
                Tab(
                  child: Text('Instagram'),
                ),
                Tab(
                  child: Text('Youtube'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  InstaDisplay(),
                  Featured(
                      fromCheckProfile: false,
                      uid: FirebaseAuth.instance.currentUser!.uid),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class More extends StatefulWidget {
  final snapshot;
  const More({
    Key? key,
    this.snapshot,
  }) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Divider(
                    thickness: 3,
                    color: Colors.grey.shade400,
                  ),
                )),
                GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('phone');

                    prefs.remove('email');
                    prefs.remove('userType');
                    await FirebaseAuth.instance.signOut();
                    // await _googleSignIn.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectUserType()),
                        (Route<dynamic> route) => false);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(
                          Icons.logout,
                          size: 26,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
