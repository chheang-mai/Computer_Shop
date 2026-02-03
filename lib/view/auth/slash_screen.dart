import 'dart:async';
import 'package:computer_shop/view/auth/login_screen.dart';
import 'package:computer_shop/view/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      // already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  BottomNavbarScreen()),
      );
    } else {
      //  not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          "https://www.bing.com/th/id/OIG2.UpV8r.otPcYq5_buemMq?w=540&h=540&c=6&r=0&o=5&dpr=1.3&pid=ImgGn",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
