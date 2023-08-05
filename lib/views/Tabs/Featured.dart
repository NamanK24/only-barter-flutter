import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Featured extends StatefulWidget {
  final uid, fromCheckProfile, name;
  const Featured(
      {super.key, this.uid, required this.fromCheckProfile, this.name});

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
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
    return SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usertype.toString())
          .doc(widget.uid)
          .collection('Posts')
          .where('featured', isEqualTo: true)
          .orderBy('uploadTime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                'No post to Display',
              ),
            ),
          );
        }
        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 1,
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.transparent,
              elevation: 0,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PostDetails(
                  //               snapshot: snapshot.data!.docs[index],
                  //               fromCheckProfile: widget.fromCheckProfile,
                  //               name: widget.name,
                  //             )));
                },
                behavior: HitTestBehavior.translucent,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(snapshot.data!.docs[index]['url'])),
              ),
            );
          },
        );
      },
    ));
  }
}
