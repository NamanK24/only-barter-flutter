import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlybarter/utils/colors.dart';

class About extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const About({super.key, required this.snapshot});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snapshot['categories'].join(', '),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      Text(
                        widget.snapshot['locality'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.snapshot['instagramSelected'] == true
                        ? Image.asset(
                            'assets/images/instagram.png',
                            width: 40,
                            height: 40,
                          )
                        : Image.asset(
                            'assets/images/youtube.png',
                            width: 40,
                            height: 40,
                          ),
                    widget.snapshot['instagramSelected'] == true
                        ? const Text(
                            'Instagram',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          )
                        : const Text(
                            'Youtube',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Influencers Requirement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BoxContainer(
                      title: 'Age',
                      data:
                          "${widget.snapshot['startAge'].toStringAsFixed(0)}y - ${widget.snapshot['endAge'].toStringAsFixed(0)}y",
                    ),
                    BoxContainer(
                      title: 'Gender',
                      data: widget.snapshot['gender'],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Campaign Time Period',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxContainer(
                title: 'Start Date',
                data: DateFormat('dd MMM')
                    .format(widget.snapshot['startDate'].toDate()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Divider(
                  color: yellow,
                  thickness: 2,
                ),
              ),
              BoxContainer(
                title: 'End Date',
                data: DateFormat('dd MMM')
                    .format(widget.snapshot['endDate'].toDate()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  const BoxContainer({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
