import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';

class Chat extends StatefulWidget {
  final roomId, brandName, influencerName, usertype;
  const Chat(
      {Key? key,
      required this.roomId,
      required this.brandName,
      required this.influencerName,
      required this.usertype})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController message = TextEditingController();
  // ScrollController? _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = ScrollController();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _controller!.animateTo(
  //       _controller!.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 1),
  //       curve: Curves.ease,
  //     );
  //   });
  // }

  sendMessages(String msg, String by, DateTime time) async {
    if (msg.trim().isNotEmpty) {
      message.clear();
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.roomId)
          .collection('msg')
          .doc()
          .set({'msg': msg, 'by': by, 'time': time});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: yellow,
                child: Center(
                  child: Text(
                    widget.usertype == 'Brand'
                        ? widget.influencerName.substring(0, 1).toUpperCase()
                        : widget.brandName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.usertype == 'Brand'
                    ? widget.influencerName
                    : widget.brandName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              // controller: _controller,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .doc(widget.roomId)
                    .collection('msg')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return snapshot.data!.docs[index].exists
                          ? MessageTile(
                              message: snapshot.data!.docs[index]['msg'],
                              byMe: FirebaseAuth.instance.currentUser!.uid ==
                                      snapshot.data!.docs[index]['by']
                                  ? true
                                  : false,
                            )
                          : Container();
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          controller: message,
                          onSubmitted: (_) {
                            sendMessages(
                                message.text.trim(),
                                FirebaseAuth.instance.currentUser!.uid,
                                DateTime.now());
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message...",
                          ),
                        ),
                      ),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: message,
                        builder: (context, value, child) {
                          return value.text.trim().isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    sendMessages(
                                        message.text.trim(),
                                        FirebaseAuth.instance.currentUser!.uid,
                                        DateTime.now());
                                  },
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : const Text('');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool byMe;

  const MessageTile({super.key, required this.message, required this.byMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: byMe ? 0 : MediaQuery.of(context).size.width * 0.02,
        right: byMe ? MediaQuery.of(context).size.width * 0.02 : 0,
      ),
      alignment: byMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: byMe
            ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2)
            : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: byMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))
              : const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
          color: byMe ? blue : Colors.blue,
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
