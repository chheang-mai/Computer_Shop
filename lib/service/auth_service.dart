import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/bottom_navbar.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signUp(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully ✅")),
      );
    } on FirebaseAuthException catch (e) {
      log("SignUp error: ${e.code} - ${e.message}");
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Sign up failed")),
      );
    } catch (e) {
      log("SignUp error: $e");
    }
  }

  static Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  BottomNavbarScreen()),
      );
    } on FirebaseAuthException catch (e) {
      log("SignIn error: ${e.code} - ${e.message}");
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    } catch (e) {
      log("SignIn error: $e");
    }
  }

  static Future<void> signOut(BuildContext context) async {
    await auth.signOut();
  }
}
