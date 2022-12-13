import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  bool loading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center, // use aligment
                      color: Colors.white,
                      child: Image.asset(
                        'img_file/logo.png',
                        height: 150,
                        width: 180,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text('Welcome Again!',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 38,
                        )),
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
                              controller: _passwordController,
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
                      height: 12.0,
                    ),
                    loading
                        ? const CircularProgressIndicator(
                            color: Color.fromARGB(255, 82, 25, 180),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.message ==
                                        'There is no user record corresponding to this identifier. The user may have been deleted.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'User Not Found',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                                    } else if (e.message ==
                                        'The password is invalid or the user does not have a password.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Password Incorrect',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                                    } else if (e.message ==
                                        'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 82, 25, 180),
                                              content: Text(
                                                'Check your internet',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 82, 25, 180),
                                              content: Text(
                                                'Contact Support Team With Error Details"${e.message.toString()}"',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )));
                                    }

                                    print(e);
                                  }
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 82, 25, 180),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: Text('Sign In'),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgetPasswordPage();
                          }));
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member? ',
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            'Register Now',
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
