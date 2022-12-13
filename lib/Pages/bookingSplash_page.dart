import 'package:flutter/material.dart';
import 'dart:async';

import 'package:one_click/main.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const MyApp()),
          ModalRoute.withName("/Home")
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'img_file/ss.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(35.0),
              child: Text(
                'Booking Accepted',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 30, 18, 133),
                    letterSpacing: 1),
              ),
            ),
            // ElevatedButton(onPressed: () {},
            // child: Text('View Orders'),
            // style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.deepPurple,
            //         shadowColor: Colors.black,
            //         elevation: 5,)
            // )
          ],
        ),
      ),
    );
  }
}
