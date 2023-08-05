

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/views/bottomNavBarItems/influencer_profile.dart';
import 'package:onlybarter/views/edit_brand_profile.dart';

class BrandProfile extends StatefulWidget {
  const BrandProfile({super.key});

  @override
  State<BrandProfile> createState() => _BrandProfileState();
}

class _BrandProfileState extends State<BrandProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Brand')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              centerTitle: true,
              iconTheme: Theme.of(context).iconTheme,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: background,
              title: const Text(
                "Only Barter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBrandProfile(
                                  snapshot: snapshot.data,
                                )));
                  },
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
            ),
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                snapshot.data!['profilePhoto'] == null
                    ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data!['profilePhoto'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: null,
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    snapshot.data!['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                ProfileItem(
                  label: 'Brand Name',
                  value: snapshot.data!['brandName'],
                ),
                ProfileItem(
                  label: 'Email',
                  value: snapshot.data!['email'],
                ),
                ProfileItem(
                  label: 'Mobile Number',
                  value: snapshot.data!['phone'],
                ),
                ProfileItem(
                  label: 'Designation',
                  value: snapshot.data!['designation'],
                ),
                ProfileItem(
                  label: 'Full Name',
                  value: snapshot.data!['name'],
                ),
                ProfileItem(
                  label: 'Website',
                  value: snapshot.data!['website'],
                ),
                const SizedBox(height: 20),
              ],
            )),
          );
        });
  }
}

class ProfileItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(239, 245, 135, 1),
              border: Border.all(width: 10, color: const Color.fromRGBO(239, 245, 135, 1)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: double.infinity,
            child: Text(
              value,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade800),

            ),
          ),
        ],
      ),
    );
  }
}
