import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/colors.dart';
import '../../utils/text_field_decoration.dart';
import '../bottom_nav_bar.dart';

class CreateCampaignScreen4 extends StatefulWidget {
  final title,
      locality,
      activity,
      categories,
      ageRange,
      startDate,
      endDate,
      gender,
      isISelected,
      isYSelected;
  const CreateCampaignScreen4(
      {super.key,
      this.title,
      this.locality,
      this.activity,
      this.categories,
      this.ageRange,
      this.startDate,
      this.endDate,
      this.gender,
      this.isISelected,
      this.isYSelected});

  @override
  State<CreateCampaignScreen4> createState() => _CreateCampaignScreen4State();
}

class _CreateCampaignScreen4State extends State<CreateCampaignScreen4> {
  TextEditingController deliverableT = TextEditingController();
  List deliverables = [];
  var Pimage, Rimage, Rvideo;
  bool loading = false;
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
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        // title: const Text(
        //   "Create Campaign",
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 20,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 32),
              const Text(
                'Add Deliverables',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10, width: double.infinity,),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Let influencers know what they have to do for this campaign',
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,

                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextField(
                      controller: deliverableT,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Add deliverables',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deliverables.add(deliverableT.text.trim());
                      deliverableT.clear();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfffae10b),
                        elevation: 10,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04,
                            vertical: 15)),
                    child: const Text(
                      "Add +",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(deliverables.join('\n')),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Add Product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                'Influencers have to promote this product',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  var tempImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 90,
                  );
                  Pimage = File(tempImage!.path);
                  setState(() {});
                },
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Pimage == null
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : Image(image: FileImage(Pimage)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add Reference Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                'This will help influencers create relevent content for your brand',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  var tempImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 90,
                  );
                  Rimage = File(tempImage!.path);
                  setState(() {});
                },
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Rimage == null
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : Image(image: FileImage(Rimage)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add Reference Video',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  var tempImage = await ImagePicker().pickVideo(
                    source: ImageSource.gallery,
                  );
                  Rvideo = File(tempImage!.path);

                  setState(() {});
                },
                child: Center(
                    child: Rvideo == null
                        ? Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('video added'), Icon(Icons.done)],
                          )),
              ),
              const SizedBox(
                height: 20,
              ),
              loading == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: yellow,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        var url1, url2, url3;
                        if (deliverables.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Please add atleast one deliverable',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ));
                          return;
                        }
                        if (Pimage == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Please add product image',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ));
                          return;
                        }
                        setState(() {
                          loading = true;
                        });
                        var doc = FirebaseFirestore.instance
                            .collection('Campaigns')
                            .doc();
                        Reference ref = FirebaseStorage.instance
                            .ref()
                            .child('Campaigns/${doc.id}')
                            .child('productImage' +
                                '-${DateTime.now().toString()}');
                        UploadTask task = ref.putFile(Pimage);
                        task.whenComplete(() async {
                          url1 = await ref.getDownloadURL();
                          if (Rimage != null) {
                            Reference ref = FirebaseStorage.instance
                                .ref()
                                .child('Campaigns/${doc.id}')
                                .child('refImage' +
                                    '-${DateTime.now().toString()}');
                            UploadTask task = ref.putFile(Rimage);
                            task.whenComplete(() async {
                              url2 = await ref.getDownloadURL();
                              if (Rvideo != null) {
                                Reference ref = FirebaseStorage.instance
                                    .ref()
                                    .child('Campaigns/${doc.id}')
                                    .child('refVideo' +
                                        '-${DateTime.now().toString()}');
                                UploadTask task = ref.putFile(Rvideo);
                                task.whenComplete(() async {
                                  url3 = await ref.getDownloadURL();
                                  await doc.set({
                                    'title': widget.title,
                                    'locality': widget.locality,
                                    'activity': widget.activity,
                                    'gender': widget.gender,
                                    'startDate': widget.startDate,
                                    'endDate': widget.endDate,
                                    'deliverables': deliverables,
                                    'startAge': widget.ageRange.start,
                                    'endAge': widget.ageRange.end,
                                    'dateTime': DateTime.now(),
                                    'brandName': FirebaseAuth
                                        .instance.currentUser!.displayName,
                                    'categories': widget.categories,
                                    'createdBy':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'photo': url1,
                                    'refImage': url2,
                                    'refVideo': url3,
                                    'instagramSelected': widget.isISelected,
                                    'youtubeSelected': widget.isYSelected,
                                    'isApproved': false
                                  }, SetOptions(merge: true));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const NavBar()),
                                      (Route<dynamic> route) => false);
                                });
                              }
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        "Create Campaign",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
