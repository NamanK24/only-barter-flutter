import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/views/bottomNavBarItems/view_campaign_details.dart';

import '../../utils/colors.dart';

class CampaignSearch extends StatefulWidget {
  const CampaignSearch({super.key});

  @override
  State<CampaignSearch> createState() => _CampaignSearchState();
}

class _CampaignSearchState extends State<CampaignSearch> {
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
          "Campaigns",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Campaigns').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ViewCampaignDetails(
                                    snapshot: snapshot.data!.docs[index]))));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        elevation: 14,
                        shadowColor: Colors.grey,
                        child: Column(
                          children: [
                            snapshot.data!.docs[index]['photo'] != null
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(

                                            snapshot.data!.docs[index]['photo'], height: MediaQuery.of(context).size.height/3, width: MediaQuery.of(context).size.width/1.5,),
                                      ),
                                    ),
                                )
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: yellow,
                                          child: Center(
                                            child: Text(
                                              snapshot.data!
                                                  .docs[index]['brandName']
                                                  .substring(0, 1)
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.58,
                                        child: Text(
                                          snapshot.data!.docs[index]['title'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 5),
                                      child: Text(
                                        snapshot.data!.docs[index]['activity'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Brand Name',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['brandName'],
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Gender',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['gender'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Age',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${snapshot.data!.docs[index]['startAge'].toStringAsFixed(0)} - ${snapshot.data!.docs[index]['endAge'].toStringAsFixed(0)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
