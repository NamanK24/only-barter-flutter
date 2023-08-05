import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBrandProfile extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const EditBrandProfile({super.key, this.snapshot});

  @override
  State<EditBrandProfile> createState() => _EditBrandProfileState();
}

class _EditBrandProfileState extends State<EditBrandProfile> {
  var profilePhoto;
  var email = '';
  var name = '';
  var profilePic;
  var website = '';
  var phone = '';
  TextEditingController nameT = TextEditingController();
  TextEditingController websiteT = TextEditingController();
  TextEditingController emailT = TextEditingController();
  String? url1;
  bool loading = false;
  var usertype;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    usertype = prefs.getString('userType');
    profilePhoto = widget.snapshot['profilePhoto'];
    name = widget.snapshot['name'];
    email = widget.snapshot['email'];
    website = widget.snapshot['website'];

    phone = widget.snapshot['phone'];

    nameT.text = name;
    emailT.text = email;
    websiteT.text = website;
    setState(() {});
  }

  cropImage(ImageSource source) async {
    final tempImage =
        await ImagePicker().pickImage(source: source, imageQuality: 95);
    if (tempImage != null) {
      File? croppedPhoto = await ImageCropper().cropImage(
          sourcePath: tempImage.path,
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop photo",
            toolbarColor: Colors.white,
            toolbarWidgetColor: blue,
            activeControlsWidgetColor: yellow,
          ));
      setState(() {
        profilePic = croppedPhoto;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: yellow,
          ),
        ),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: yellow,
            ),
            onPressed: () async {
              if (nameT.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Name can\'t be empty',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ));
                return;
              }

              if (emailT.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Email can\'t be empty',
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

              if (profilePic != null) {
                Reference ref = FirebaseStorage.instance
                    .ref()
                    .child(
                        '$usertype/${FirebaseAuth.instance.currentUser!.uid}/profilePhoto')
                    .child(FirebaseAuth.instance.currentUser!.uid +
                        '-${DateTime.now().toString()}');
                UploadTask task = ref.putFile(profilePic);
                task.whenComplete(() async {
                  url1 = await ref.getDownloadURL();
                  await FirebaseFirestore.instance
                      .collection(usertype)
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'profilePhoto': url1});
                }).catchError((e) {
                  setState(() {
                    loading = false;
                  });
                });
              }
              if (profilePic == null && profilePhoto == null) {
                await FirebaseFirestore.instance
                    .collection(usertype)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({'profilePhoto': null});
              }
              await FirebaseAuth.instance.currentUser!
                  .updateDisplayName(nameT.text.trim());
              await FirebaseFirestore.instance
                  .collection(usertype)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                'name': nameT.text.trim(),
                'email': emailT.text.trim(),
                'website': websiteT.text.trim(),
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: loading
            ? const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.drag_handle_rounded,
                                  size: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.photo,
                                                size: 26,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            const Text("Choose from gallery",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                          ],
                                        ),
                                        onTap: () async {
                                          cropImage(ImageSource.gallery);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.camera_alt,
                                                size: 26,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            const Text("Take photo",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                          ],
                                        ),
                                        onTap: () async {
                                          cropImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      if (profilePic != null ||
                                          profilePhoto != null)
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 26,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              const Text("Remove photo",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  )),
                                            ],
                                          ),
                                          onTap: () async {
                                            setState(() {
                                              profilePhoto = null;
                                              profilePic = null;
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: profilePic == null
                        ? profilePhoto != null
                            ? Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Stack(children: [
                                      Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      profilePhoto),
                                                  fit: BoxFit.cover)),
                                          child: null),
                                      Positioned(
                                          right: 0.0,
                                          bottom: 0.0,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ))
                                    ])))
                            : Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Stack(children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        color: yellow,
                                        child: Center(
                                          child: Text(
                                            name.substring(0, 1).toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0.0,
                                          bottom: 0.0,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.grey),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ))
                                    ])))
                        : Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(profilePic),
                                                fit: BoxFit.cover)),
                                        child: null),
                                    Positioned(
                                        right: 0.0,
                                        bottom: 0.0,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.grey),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ))
                                  ],
                                ))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextField(
                      controller: nameT,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        counterText: '',
                        labelText: 'Name *',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // focusedBorder: outlineInputBorder,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextField(
                      controller: emailT,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        counterText: '',
                        labelText: 'Email *',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // focusedBorder: outlineInputBorder,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextField(
                      controller: websiteT,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.link,
                          color: Colors.grey,
                        ),
                        counterText: '',
                        labelText: 'Website',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // focusedBorder: outlineInputBorder,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Text(
                          "Phone",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Text(
                          "+91 " + phone,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
      ),
    );
  }
}
