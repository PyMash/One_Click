import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_click/Pages/landing_page.dart';
import 'package:one_click/Pages/login_page.dart';

import 'auth_page.dart';


class MainPageAuth extends StatelessWidget {
  const MainPageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return LandingPage();
          } else {
            return AuthPage();
          }
        }),
      ),
    );
  }
}
