import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({super.key, required this.showLoginPage});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  bool loading = false;
  

  @override
  void dispose() {
    _name.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_password.text.trim() == _confirmPassword.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future addUserDetails(
      String name, int number, String email, String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Name': name,
      'Contact Number': number,
      'email': email,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                      child: Text('Create\nAccount',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 82, 25, 180),
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[30],
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _name,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 82, 25, 180),
                                      width: 1.0),
                                ),
                                filled: true,
                                hintText: 'Name',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Invalid Name Format";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[30],
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _phoneNumber,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 82, 25, 180),
                                      width: 1.0),
                                ),
                                filled: true,
                                hintText: 'Phone Number',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$')
                                      .hasMatch(value)) {
                                return "Invalid Format";
                                // return null;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[30],
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _email,
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
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[30],
                            borderRadius: BorderRadius.circular(12)),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                              controller: _password,
                              textAlign: TextAlign.center,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 82, 25, 180),
                                        width: 1.0),
                                  ),
                                  // border: InputBorder.none,
                                  hintText: 'Password',
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password should not be empty";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[30],
                            borderRadius: BorderRadius.circular(12)),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                              controller: _confirmPassword,
                              textAlign: TextAlign.center,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 82, 25, 180),
                                        width: 1.0),
                                  ),
                                  // border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password should not be empty";
                                } else if (value != _password.text) {
                                  return "Password Doesnot Match";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  try {
                                    if (passwordConfirmed()) {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _email.text.trim(),
                                              password: _password.text.trim());
                                      final user =
                                          FirebaseAuth.instance.currentUser!;

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.uid)
                                          .set({
                                        'Name': _name.text.trim(),
                                        'Contact Number':
                                            _phoneNumber.text.trim(),
                                        'email': _email.text.trim(),
                                        'password': _password.text.trim(),
                                      });
                                      // addUserDetails(
                                      //     _name.text.trim(),
                                      //     int.parse(_phoneNumber.text.trim()),
                                      //     _email.text.trim(),
                                      //     _password.text.trim());
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 82, 25, 180),
                                            content: Text(
                                              e.message.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )));
                                  }
                                }
                                if (mounted) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 82, 25, 180),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already a member? ',
                        ),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
