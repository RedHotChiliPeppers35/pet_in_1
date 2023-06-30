import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

import '../Pages/Pet Owner/main_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool eMailVerified = false;
  bool resendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    eMailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (eMailVerified == false) {
      sendVerification();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        checkVerificationState();
      });
    }
  }

  Future checkVerificationState() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      eMailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (eMailVerified == true) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _showIOSAlert(BuildContext context, Text myContent) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: myContent,
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Geri dön'),
          ),
        ],
      ),
    );
  }

  void _showAndroidAlert(BuildContext context, Text myContent) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: myContent,
          //buttons?
          actions: <Widget>[
            TextButton(
              child: const Text("Geri dön"),
              onPressed: () {
                Navigator.of(context).pop();
              }, //closes popup
            ),
          ],
        );
      },
    );
  }

  Future sendVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => resendEmail = false);
      await Future.delayed(const Duration(seconds: 3));
      setState(() => resendEmail = true);
    } on FirebaseAuthException catch (e) {
      if (e.code == "too-many-requests") {
        if (Platform.isIOS) {
          _showIOSAlert(context, const Text("Art arda veya çok fazla işlem talebinde bulunudnuz"));
        } else {
          _showAndroidAlert(
              context, const Text("Art arda veya çok fazla işlem talebinde bulunudnuz"));
        }
      } else {
        print(e);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (eMailVerified == true) {
      return const MainPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("E-posta Doğrulama"),
          elevation: 0,
        ),
        body: Scaffold(
          body: SafeArea(
              child: Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail,
                    size: 100,
                    color: applicationPurple,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Doğrulama linki",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Text("${FirebaseAuth.instance.currentUser!.email}",
                      style: const TextStyle(
                        fontSize: 25,
                      )),
                  const Text("adresine gönderildi",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Link ulaşmadı mı ?",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(backgroundColor: applicationOrange),
                      onPressed: () => sendVerification(),
                      child: const Text(
                        "Tekrar gönder",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: const Text(
                        "Vazgeç",
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ))
                ],
              ),
            ),
          )),
        ),
      );
    }
  }
}
