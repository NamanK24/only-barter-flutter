import 'package:flutter/material.dart';
import 'package:onlybarter/views/Ads/create_campaign_screen_3.dart';

import '../../utils/colors.dart';

class CreateCampaignScreen2 extends StatefulWidget {
  final locality, title, activity;
  const CreateCampaignScreen2(
      {super.key, this.locality, this.title, this.activity});

  @override
  State<CreateCampaignScreen2> createState() => _CreateCampaignScreen2State();
}

class _CreateCampaignScreen2State extends State<CreateCampaignScreen2> {
  bool isISelected = false;
  bool isYSelected = false;

  String? selectedState;
  String? selectedCity;

  List categories = [
    'Lifestyle',
    'Beauty & Wellness',
    'Fitness & Wellness',
    'Travel',
    'Food',
    'Gaming',
    'Parenting',
    'Technology',
    'Business & Enterpreneur',
    'Social Issues & Advocacy'
  ];

  List isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 10),
            const Text(
              'Few more details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'about this campaign!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Where do you want to promote?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      isISelected = true;
                      isYSelected = false;
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isISelected == true ? yellow : Colors.grey.shade400,
                        width: isISelected == true ? 5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/instagram.png',
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          'Instagram',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () {
                    isISelected = false;
                    isYSelected = true;

                    setState(() {});
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isYSelected == true ? yellow : Colors.grey.shade400,
                        width: isYSelected == true ? 5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/youtube.png',
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          'Youtube',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            const Text(
              'Select Category of campaign',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'You can select upto 3',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 11 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    int c =
                        isSelected.where((element) => element == true).length;

                    if (c < 3) {
                      isSelected[index] = !isSelected[index];
                    } else {
                      isSelected[index] = false;
                    }

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected[index]
                            ? Colors.transparent
                            : Colors.grey.shade400,
                        width: 1,
                      ),
                      color: isSelected[index] ? yellow : null,
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (isISelected == false && isYSelected == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Please select one platform',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ));
                  return;
                }

                int c = isSelected.where((element) => element == true).length;
                if (c <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Please select atleast one category',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ));
                  return;
                }

                List l = [];
                for (int i = 0; i < isSelected.length; i++) {
                  if (isSelected[i] == true) {
                    l.add(categories[i]);
                  }
                }

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateCampaignScreen3(
                          locality: widget.locality,
                          activity: widget.activity,
                          title: widget.title,
                          categories: l,
                          isISelected: isISelected,
                          isYSelected: isYSelected,
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
            const SizedBox(height: 20,)
          ],
        ),
      )),
    );
  }
}
