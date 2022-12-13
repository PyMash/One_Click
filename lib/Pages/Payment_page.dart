
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'address_page.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class calculation {
  late double s;
  late double t;
  late double m;
  String index = '';

  serviceCalculation(String i, int service) {
    double total;
    String rt;
    index = i;
    if (i == 'Tutor') {
      s = 599;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      }
      else if (service == 3) {
        String text = "* Science, Literatue, Maths";
        return text;
      }
    } else if (i == 'Electrician') {
      s = 399.00;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      } else if (service == 3) {
        String text = "* clean-up after the service\n\n* Procurement of spare parts (at extra cost)";
        return text;
      }
    } else if (i == 'Plumber') {
      s = 399.00;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      }
      else if (service == 3) {
        String text = "* clean-up after the service\n\n* Procurement of spare parts (at extra cost)";
        return text;
      }
    } else if (i == 'Mechanic') {
      s = 499.00;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      }
      else if (service == 3) {
        String text = "* clean-up after the service\n\n* Procurement of spare parts (at extra cost)";
        return text;
      }
    } else if (i == 'Assistance') {
      s = 499.00;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      }
      else if (service == 3) {
        String text = "* Helping hand for yours -\n\n    - Kids, Old Age People\n\n    - Or we can be your shifting buddy ";
        return text;
      }
    } else if (i == 'Driver') {
      s = 399.00;
      t = s * 0.18;
      m = 99;
      total = s + t + m;
      if (service == 1) {
        return s.toPrecision(1);
      } else if (service == 2) {
        return t.toPrecision(1);
      } else if (service == 0) {
        return total.toPrecision(2);
      }
      else if (service == 3) {
        String text = "* All our drivers are professional\n\n* Extra time can be provided with little extra charges ";
        return text;
      }
    }
  }
}

class PaymentPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final String service;
  PaymentPage({Key? key, required this.service}) : super(key: key);
  late double serviceCharg = calculation().serviceCalculation(service, 0);
  late double serviceChargOne = calculation().serviceCalculation(service, 1);
  late double serviceChargTwo = calculation().serviceCalculation(service, 2);
  late var serviceChargThree = calculation().serviceCalculation(service, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).size.height / 3.8,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 61, 23, 128),
            child: const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 30),
              child: Text(
                "Order Summary",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Service Charge - ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹$serviceChargOne',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Taxes -",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹$serviceChargTwo',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Miscellaneous Charges -",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹99.0',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grand Total",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '₹$serviceCharg',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Service Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 10.0, top: 5),
                    child: Text(
                      '$service',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 12.0, right: 10.0, top: 5),
                    child: Text('* 45 minutes'),
                  ),
                  const SizedBox(height: 8,),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 10.0, top: 5),
                    child: Text('$serviceChargThree'),
                  ),
                  
                  const SizedBox(
                    height: 25,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('Payment Details',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,

                  //   ),),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 72, 32, 141),
                        shadowColor: Colors.black,
                        elevation: 5,
                      ),
                      onPressed: () async{
                        // try{
                        // await FirebaseFirestore.instance
                        //     .collection('users')
                        //     .doc(user.uid)
                        //     .collection('Service')
                        //     .doc('Service and Charges')
                        //     .set({
                        //                 'Service': service.trim(),
                        //                 'Charges'  : serviceCharg,
                        //               });
                        // // ignore: use_build_context_synchronously
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AddressPage()));
                        // } on FirebaseAuthException catch (e) {
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //                 SnackBar(
                        //                     backgroundColor:
                        //                         const Color.fromARGB(
                        //                             255, 82, 25, 180),
                        //                     content: Text(
                        //                       e.message.toString(),
                        //                       style: const TextStyle(
                        //                           color: Colors.white),
                        //                     )));
                        //           }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  AddressPage(services : service, Charges : serviceCharg)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Continue'),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
