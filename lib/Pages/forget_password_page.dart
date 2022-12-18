import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  bool loading = false;


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 188, 240),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Enter your email address and we will send you a password rest link',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 82, 25, 180),
                            width: 1.0),
                      ),
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return "Invalid Email Format";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(
                        255,
                        82,
                        25,
                        180,
                      )),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _emailController.text.trim());
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Text(
                                          'Password reset link send! check your email',style: TextStyle(color:Color.fromARGB(
                                          255, 82, 25, 180), ),),
                                    );
                                  });
                              Timer(const Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()));
                              });
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 82, 25, 180),
                                      content: Text(
                                        e.message.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )));
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 82, 25, 180),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: const Text('Reset Password'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
