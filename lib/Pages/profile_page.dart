import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_click/Pages/booking_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dotted_line/dotted_line.dart';
import '../main.dart';
import 'landing_page.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  String name = 'User';

  Future fetchdata() async {
    var snapdata;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        snapdata = documentSnapshot.data()!;
        Map<String, dynamic>? data = snapdata;
        String namedata = (data!['Name']).toString();
        name = namedata.toTitleCase();
        print(namedata);
        return documentSnapshot.data().toString();
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 194, 188, 240),
        appBar: AppBar(
          title: const Text('Account'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Padding(padding: EdgeInsets.all(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.user,
                          size: 55,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                            //   child: Text(
                            //     name,
                            // style: TextStyle(
                            //     fontSize: 20, fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FutureBuilder(
                                future: fetchdata(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    );
                                  } else {
                                    return Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                user.email!,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookingPage()));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Bookings'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: DottedLine(
                            dashColor: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Coming Soon!',textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Rating'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: DottedLine(
                            dashColor: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Coming Soon!',textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('About One Click'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: DottedLine(
                            dashColor: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Coming Soon!',textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Share With Friends'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: DottedLine(
                            dashColor: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Coming Soon!',textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rate Our Application'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: DottedLine(
                            dashColor: Colors.deepPurple,
                          )),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Coming Soon!',textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Help Center'),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10),
                  // ignore: prefer_const_constructors
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyApp())));
                    },
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                ],
              ),
            )

            // Text('Signed in as:' + user.email!),
            // MaterialButton(
            //   onPressed: () {
            // FirebaseAuth.instance.signOut().then((value) =>
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) => MyApp())));
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => LoginPage()));
            //   },
            //   color: Colors.deepPurple,
            //   child: Text('Sign Out'),
            // )
          ],
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
                selectedIndex: 2,
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
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return const BookingPage();
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
