import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bookingSplash_page.dart';
import 'service.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({
    super.key,
    required this.services,
    required this.charge,
    required this.addresstype,
    required this.locality,
    required this.secondAddress,
    required this.primaryAddress,
    required this.pincode,
  });
  final String services;

  final String addresstype;

  final double charge;

  final String locality;

  final String primaryAddress;

  final String secondAddress;
  final String pincode;

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _date = TextEditingController();
  final _time = TextEditingController();
  late String dateDetails = '';
  late String timeDetails = '';
  String ser = '';
  List<Service> services = [
    Service('10.00AM'),
    Service('11.00AM'),
    Service('12.00AM'),
    Service('01:00PM'),
    Service('02.00PM'),
    Service(
      '03.00PM',
    )
  ];

  int selectedService = -1;
  bool isButtonActiveOne = true;
  bool isButtonActiveTwo = true;
  DateTime today = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 188, 240),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height / 2),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 213, 210, 241),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Select Date and Time',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: 110.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: isButtonActiveOne
                                  ? () {
                                      String todaydate =
                                          "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
                                      // debugPrint(todaydate);
                                      dateDetails = todaydate;

                                      setState(() {
                                        isButtonActiveOne = false;
                                        isButtonActiveTwo = true;
                                      });
                                    }
                                  : null,
                              child: const Text(
                                'Today',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: 110.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: isButtonActiveTwo
                                  ? () {
                                      var nextday =
                                          today.add(new Duration(days: 1));
                                      String result =
                                          "${nextday.year.toString()}-${nextday.month.toString().padLeft(2, '0')}-${nextday.day.toString().padLeft(2, '0')}";
                                      // debugPrint(result);
                                      dateDetails = result;

                                      setState(() {
                                        isButtonActiveTwo = false;
                                        isButtonActiveOne = true;
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              child: const Text(
                                'Tommorow',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Slots',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.0,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: services.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return serviceContainer(
                                      services[index].name, index);
                                }),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () async {
                        outcome(number) {
                          if (number == 0) {
                            return "10.00AM";
                          } else if (number == 1) {
                            return "11.00AM";
                          } else if (number == 2) {
                            return "12.00AM";
                          } else if (number == 3) {
                            return "01.00PM";
                          } else if (number == 4) {
                            return "02.00PM";
                          } else if (number == 5) {
                            return "03.00PM";
                          }
                        }

                        timeDetails = outcome(selectedService).toString();
                        ser = widget.services;
                        String dateTime = timeDetails + ' ' + dateDetails;
                        print(dateTime);
                        String pp = widget.primaryAddress +' - ' + widget.pincode.toString();

                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .collection(ser)
                              .doc('All Details')
                              .set({
                            'Service': widget.services,
                            'Charges': widget.charge,
                            'House / Flat / Block No': widget.primaryAddress,
                            'Apartment / Road / Area': widget.secondAddress,
                            'Locality': widget.locality,
                            'Pin Code': widget.pincode,
                            'Address Type': widget.addresstype,
                            'Time & Date': dateTime.trim(),
                            'Place and Pincode' :pp,

                          });
                          // await FirebaseFirestore.instance
                          //     .collection('users')
                          //     .doc(user.uid)
                          //     .collection(ser)
                          //     .doc('Address')
                          //     .set({
                          //   'House / Flat / Block No': widget.primaryAddress,
                          //   'Apartment / Road / Area': widget.secondAddress,
                          //   'Locality': widget.locality,
                          //   'Pin Code': widget.pincode,
                          //   'Address Type': widget.addresstype,
                          // });
                          // await FirebaseFirestore.instance
                          //     .collection('users')
                          //     .doc(user.uid)
                          //     .collection(ser)
                          //     .doc('Date and Time')
                          //     .set({
                          //   'Date': dateDetails.trim(),
                          //   'Time': timeDetails.trim(),
                          // });

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmPage()));
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor:
                                  const Color.fromARGB(255, 82, 25, 180),
                              content: Text(
                                e.message.toString(),
                                style: const TextStyle(color: Colors.white),
                              )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Continue'),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }

  serviceContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else
            selectedService = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.deepPurple
                : Colors.deepPurple.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(image, height: 80),
              Text(
                name,
                style: const TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }
}
