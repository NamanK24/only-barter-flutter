import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../bottom_nav_bar.dart';
import 'create_campaign_screen_4.dart';

class CreateCampaignScreen3 extends StatefulWidget {
  final activity,
      title,
      locality,
      platform,
      categories,
      isISelected,
      isYSelected;
  const CreateCampaignScreen3(
      {super.key,
      this.activity,
      this.title,
      this.locality,
      this.platform,
      this.categories,
      this.isISelected,
      this.isYSelected});

  @override
  State<CreateCampaignScreen3> createState() => _CreateCampaignScreen3State();
}

class _CreateCampaignScreen3State extends State<CreateCampaignScreen3> {
  RangeValues _currentRangeValues = const RangeValues(18, 20);
  var selectedGender;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
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
              // const SizedBox(height: 30),
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
                'Influencer Age ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              RangeSlider(
                values: _currentRangeValues,
                min: 18,
                max: 30,
                divisions: 12,
                activeColor: yellow,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('18'), Text('30')],
              ),
              // Divider(
              //   thickness: 1,
              //   color: Colors.grey.shade400,
              // )
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Influencer Gender ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
                items: genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'How long should the campaign last ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                      onPressed: () async {
                        DateTime? start = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            helpText: 'Select Start Date',
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));

                        if (start == null) return;
                        setState(() {
                          selectedStartDate = start;
                          // sDate = start;
                        });
                      },
                      child: Text(
                        selectedStartDate == null
                            ? "Start Date"
                            : DateFormat('dd-MM-yyyy')
                                .format(selectedStartDate!),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const Text(
                      'TO',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                      onPressed: () async {
                        DateTime? end = await showDatePicker(
                            context: context,
                            initialDate:
                                selectedStartDate!.add(const Duration(days: 1)),
                            helpText: 'Select End Date',
                            firstDate:
                                selectedStartDate!.add(const Duration(days: 1)),
                            lastDate: DateTime(2100));

                        if (end == null) return;
                        setState(() {
                          selectedEndDate = end;
                        });
                      },
                      child: Text(
                        selectedEndDate == null
                            ? "End Date"
                            : DateFormat('dd-MM-yyyy').format(selectedEndDate!),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedGender == null || selectedGender == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please select gender',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  if (selectedStartDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please select start date',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }
                  if (selectedEndDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please select end date',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                    return;
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CreateCampaignScreen4(
                              title: widget.title,
                              locality: widget.locality,
                              activity: widget.activity,
                              gender: selectedGender,
                              ageRange: _currentRangeValues,
                              startDate: selectedStartDate,
                              endDate: selectedEndDate,
                              categories: widget.categories,
                              isISelected: widget.isISelected,
                              isYSelected: widget.isYSelected,
                            )),
                  );
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
      ),
    );
  }
}
