import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/bottomNavBarItems/chat.dart';
import 'package:onlybarter/views/campaign_tabs/about.dart';
import 'package:onlybarter/views/campaign_tabs/do_and_dont.dart';
import 'package:onlybarter/views/campaign_tabs/reference.dart';
import 'package:shared_preferences/shared_preferences.dart';

roomIdCheck(roomId) async {
  final result = await FirebaseFirestore.instance
      .collection("messages")
      .where('roomId', isEqualTo: roomId)
      .get();
  return result.docs.isNotEmpty;
}

class ViewCampaignDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const ViewCampaignDetails({super.key, required this.snapshot});

  @override
  State<ViewCampaignDetails> createState() => _ViewCampaignDetailsState();
}

class _ViewCampaignDetailsState extends State<ViewCampaignDetails>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: 3, vsync: this);
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: background,
          title: const Text(
            "Campaign",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final checkRoomExists = await roomIdCheck(
                '${FirebaseAuth.instance.currentUser!.uid}-testUID');

            SharedPreferences prefs = await SharedPreferences.getInstance();
            var usertype = prefs.getString('userType');

            if (checkRoomExists == true) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chat(
                            brandName:
                                FirebaseAuth.instance.currentUser!.displayName,
                            influencerName: 'TestNAME',
                            roomId:
                                '${FirebaseAuth.instance.currentUser!.uid}-testUID',
                            usertype: usertype,
                          )));
            } else {
              await FirebaseFirestore.instance
                  .collection('messages')
                  .doc('${FirebaseAuth.instance.currentUser!.uid}-testUID')
                  .set({
                'roomId': '${FirebaseAuth.instance.currentUser!.uid}-testUID',
                'users': [FirebaseAuth.instance.currentUser!.uid, 'testUID'],
                'brandName': FirebaseAuth.instance.currentUser!.displayName,
                'influencerName': 'TestNAME',
              }).then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat(
                                    roomId:
                                        '${FirebaseAuth.instance.currentUser!.uid}-testUID',
                                    brandName: FirebaseAuth
                                        .instance.currentUser!.displayName,
                                    influencerName: 'TestNAME',
                                    usertype: usertype))),
                      });
            }
          },
          backgroundColor: Colors.yellow,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          icon: const Icon(Icons.add),
          label: const Text(
            'Connect',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 80,
                          width: 80,
                          color: widget.snapshot['photo'] != null
                              ? Colors.transparent
                              : yellow,
                          child: widget.snapshot['photo'] != null
                              ? Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      widget.snapshot['photo'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    widget.snapshot['brandName']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.snapshot['title'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.snapshot['activity'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${DateTime.now().difference(widget.snapshot['dateTime'].toDate()).inDays}d ago',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
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
                  child: Text('About'),
                ),
                Tab(
                  child: Text('Reference'),
                ),
                Tab(
                  child: Text('Dos and Don\'ts'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  About(
                    snapshot: widget.snapshot,
                  ),
                  Reference(
                    snapshot: widget.snapshot,
                  ),
                  const DosAndDonts(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
