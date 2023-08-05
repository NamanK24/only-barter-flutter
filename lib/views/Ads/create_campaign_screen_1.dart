import 'package:flutter/material.dart';
import 'package:onlybarter/utils/colors.dart';
import 'package:onlybarter/utils/text_field_decoration.dart';
import 'package:onlybarter/views/Ads/create_campaign_screen_2.dart';

class CreateCampaignScreen1 extends StatefulWidget {
  const CreateCampaignScreen1({super.key});

  @override
  State<CreateCampaignScreen1> createState() => _CreateCampaignScreen1State();
}

class _CreateCampaignScreen1State extends State<CreateCampaignScreen1> {
  TextEditingController title = TextEditingController();
  TextEditingController locality = TextEditingController();

  List activities = [
    'Video Creation',
    'Images',
    'Product Reviews',
    'Event Visit',
    'Mention',
    'Trending',
    'Contest Giveaways',
    'Product Placement',
  ];

  int selectedActivity = 0;
  String activity = '';

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
          "Create Campaign",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Let\'s set up a campaign!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              'We just need some basic information',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: title,
                style: const TextStyle(),
                decoration: InputDecoration(
                  labelText: 'Promotion Title',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: locality,
                style: const TextStyle(),
                decoration: InputDecoration(
                  labelText: 'Locality',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'What  activities would you like influencers to engage in as part of your campaign?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                ),
                itemCount: activities.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedActivity = index;
                        activity = activities[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // border: Border.all(
                        //   color:
                        //       activities[selectedActivity] == activities[index]
                        //           ? yellow
                        //           : Colors.grey.shade400,
                        //   width:
                        //       activities[selectedActivity] == activities[index]
                        //           ? 3
                        //           : 1,
                        // ),
                        color: activities[selectedActivity] == activities[index]
                                  ? yellow
                                  : Colors.grey.shade200,

                      ),
                      child: Center(
                        child: Text(
                          activities[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: activities[selectedActivity] == activities[index]
                                      ? Colors.white
                                      : Colors.black

                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (title.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Title can\'t be empty',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ));
                  return;
                }
                if (locality.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Locality can\'t be empty',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ));
                  return;
                }
                if (selectedActivity == 0) {
                  activity = 'Video Creation';
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateCampaignScreen2(
                              locality: locality.text.trim(),
                              title: title.text.trim(),
                              activity: activity,
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: yellow,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
