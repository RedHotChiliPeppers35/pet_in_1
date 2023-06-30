import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/LoginSignUp/auth_page.dart';
import 'package:flutter_application_1/LoginSignUp/verify_page.dart';

class CheckState extends StatefulWidget {
  const CheckState({super.key});

  @override
  State<CheckState> createState() => _CheckStateState();
}

class _CheckStateState extends State<CheckState> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Hata Oluştu"),);
            }
            
            else if (snapshot.hasData) {
            return const VerificationPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    )));
  }
}
