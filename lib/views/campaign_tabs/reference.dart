import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:video_player/video_player.dart';

class Reference extends StatefulWidget {
  final DocumentSnapshot snapshot;

  const Reference({super.key, required this.snapshot});

  @override
  State<Reference> createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deliverables',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  const Text(
                    'Here are the tasks that you must complete for this campaign.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: widget.snapshot['deliverables'].length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: yellow,
                          ),
                        ),
                        color: yellow.withOpacity(0.2),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: yellow,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          title: Text(
                            widget.snapshot['deliverables'][index],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  const Text(
                    'Your task is to promote the products given below.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(20),
                            elevation: 10,
                            child: Image.network(
                              widget.snapshot['photo'],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Image.network(
                      widget.snapshot['photo'],
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const Text(
                    'Reference Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  const Text(
                    'Here is the image that you can refer to complete this campaign.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(20),
                            elevation: 10,
                            child: Image.network(
                              widget.snapshot['refImage'],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Image.network(
                      widget.snapshot['refImage'],
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const Text(
                    'Reference Video',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                  const Text(
                    'Here is the video that you can refer to complete this campaign.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                    video: widget.snapshot['refVideo'],
                                  )));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final video;

  const VideoPlayerScreen({super.key, required this.video});
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  initVideo() {
    _controller = VideoPlayerController.network(widget.video);
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      setState(() {
        _controller!.play();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          setState(() {
            if (_controller!.value.isPlaying) {
              _controller!.pause();
            } else {
              _controller!.play();
            }
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
