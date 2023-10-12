import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_app/authentication/login_view.dart';
import 'package:firestore_app/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;

  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network(
                'https://lottie.host/5820167c-957c-4e92-b3ab-eb5755b09e7f/LCPMrBBkgn.json',
                controller: _controller, onLoaded: (compose) {
              _controller
                ..duration = compose.duration
                ..forward().then((value) {
                  if (user != null) {
                    Timer(const Duration(milliseconds: 1), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    });
                  } else if (user == null) {
                    Timer(const Duration(milliseconds: 1), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    });
                  }
                });
            })
          ]),
    );
  }
}
