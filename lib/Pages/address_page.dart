import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dateTime_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage(
      {super.key, required this.Charges, required String this.services});
  final double Charges;
  final String services;

  @override
  State<AddressPage> createState() => _Address_pageState();
}

class _Address_pageState extends State<AddressPage> {
  late double Charges = widget.Charges;
  late String service = widget.services;

  int _value = 1;
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  bool loading = false;

  final _primaryAddress = TextEditingController();
  final _secondaryAddress = TextEditingController();
  final _locality = TextEditingController();
  final _pincode = TextEditingController();
  late String _addresstype = 'home';
  final user = FirebaseAuth.instance.currentUser!;

  late String locality = _locality.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 194, 188, 240),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text('Enter Your Address Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 82, 25, 180),
                        )),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: TextFormField(
                        controller: _primaryAddress,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'House / Flat / Block No',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 82, 25, 180))),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: TextFormField(
                        controller: _secondaryAddress,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Apartment / Road / Area',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 82, 25, 180))),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: TextFormField(
                        controller: _locality,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Locality ',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 82, 25, 180))),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: TextFormField(
                        controller: _pincode,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Pin Code',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 82, 25, 180))),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            )),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
                            return "Invalid Format";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Save This Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Home",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Radio(
                                value: 1,
                                groupValue: _value,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        const Color.fromARGB(255, 82, 25, 180)),
                                onChanged: ((value) {
                                  _addresstype = 'home';
                                  setState(() {
                                    _value = value!;
                                  });
                                }),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Work",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Radio(
                                value: 2,
                                groupValue: _value,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        const Color.fromARGB(255, 82, 25, 180)),
                                onChanged: ((value) {
                                  _addresstype = 'Work';
                                  setState(() {
                                    _value = value!;
                                  });
                                }),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Others",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Radio(
                                value: 3,
                                groupValue: _value,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        const Color.fromARGB(255, 82, 25, 180)),
                                onChanged: ((value) {
                                  _addresstype = 'Others';
                                  setState(() {
                                    _value = value!;
                                  });
                                }),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 82, 25, 180),
                              shadowColor: Colors.black,
                              elevation: 5,
                            ),
                            onPressed: () {
                              print(service);
                              print(Charges);
                              if (formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DateTimePage(
                                            services: service,
                                            charge: Charges,
                                            primaryAddress:
                                                _primaryAddress.text.trim(),
                                            secondAddress:
                                                _secondaryAddress.text.trim(),
                                            locality: locality,
                                            pincode: _pincode.text.trim(),
                                            addresstype: _addresstype)));
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Continue'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ))));
  }
}

// void _createRoute() {
//   final PageRoute =  new PageRouteBuilder(
//     opaque: false,
//     pageBuilder: (context, animation, secondaryAnimation) => DateTimePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
