import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:one_click/Pages/landing_page.dart';
import 'package:one_click/Pages/profile_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late int totalService = 0;
  late var serviceNameList = [];
  late var placePincodeList = [];
  late var orderStatus = [];
  late var dateTime = [];
  late var serviceAvailable = [
    'Tutor',
    'Electrician',
    'Plumber',
    'Mechanic',
    'Assistance',
    'Driver'
  ];
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> deleteAllTaskDocs(String service) {
    return users
        .doc(user.uid)
        .collection(service)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  List<String> docIDs = [];

  Future fetchdata(srlist) async {
    var snapdata;
    totalService = 0;
    for (var i = 0; i < srlist.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(srlist[i].toString())
          .doc('All Details')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        // final testdata = documentSnapshot.data();

        // final Map<String, dynamic> convertedData =
        //     jsonDecode(jsonEncode(testdata));
        if (documentSnapshot.exists) {
          snapdata = documentSnapshot.data()!;
          Map<String, dynamic>? data = snapdata;

          // print(data!['Time']);
          String placePincode = (data!['Place and Pincode']).toString();
          String oStatus = (data['Order Status']).toString();
          String dt = (data['Time & Date']).toString();
          // print('Document data: ${documentSnapshot.data()}');
          serviceNameList.add(srlist[i].toString());
          placePincodeList.add(placePincode);
          orderStatus.add(oStatus);
          dateTime.add(dt);
          totalService = totalService + 1;
        } else {
          print('Document does not exist on the database');
        }
      });
    }
  }

  Future getdata() async {
    print(totalService);
    print(serviceNameList.toSet());
    print(placePincodeList);
  }

  Future getDocId() async {
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.uid)
    //     .collection('Tutor')
    //     .doc('All Details')
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   final testdata = documentSnapshot.data();

    //   final Map<String, dynamic> convertedData =
    //       jsonDecode(jsonEncode(testdata));
    //   print(convertedData.runtimeType);
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //     serviceNameList.add('Tutor');

    //     return documentSnapshot.data().toString();
    //   } else {
    //     print('Document does not exist on the database');
    //     return null;
    //   }
    // });
    // totalService = totalService + 1;
    await fetchdata(serviceAvailable);
    await getdata();
  }

  // @override
  // void initState() {
  //   getDocId();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 194, 188, 240),
        appBar: AppBar(
          title: const Text(
            'Bookings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          centerTitle: true,
          // centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: totalService,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    serviceNameList[index].toString(),
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      letterSpacing: 1.3,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(LineIcons.mapMarker),
                                            Text(placePincodeList[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 1.1,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(LineIcons.clock),
                                            Text(dateTime[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 1.1,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Current Status : ' +
                                                orderStatus[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 1.1,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text(
                                                'Are you sure you want to cancel ?',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 82, 25, 180),
                                                ),
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              // buttonPadding: EdgeInsets.only(right: 10),
                                              actionsPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              // contentPadding: EdgeInsets.only(right: 20),
                                              // insetPadding: EdgeInsets.only(right: 80) ,
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      serviceNameList
                                                          .remove(index);
                                                      deleteAllTaskDocs(
                                                          serviceNameList[
                                                              index]);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Yes'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      
                                      
                                      Icons.delete,
                                      color: Colors.deepPurple,
                                    ),
                                    splashColor: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
                  }
                  return const Text('Loading');
                }),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.deepPurple.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                selectedIndex: 1,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.deepPurple[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.deepPurple,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.elementor,
                    text: 'Booking',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                onTabChange: (index) {
                  setState(() {
                    if (index == 0) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LandingPage()));
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return const LandingPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    } else if (index == 2) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const ProfilePage()));
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return const ProfilePage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

