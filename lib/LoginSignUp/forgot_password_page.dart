// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Şifreni mi unuttun?",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "• Hesabına kayıtlı E-posta adresini gir \n\n• E-posta adresine gönderilen linke tıkla \n\n• Şifreni sıfırla",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                      controller: _emailController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "E-posta",
                          hintStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: applicationPurple,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)))),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: applicationOrange, borderRadius: BorderRadius.circular(20)),
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextButton(
                    onPressed: passwordReset,
                    child: const Text(
                      "Gönder",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future passwordReset() async {
    String resetMail = _emailController.text.toString();
    if (_emailController.text.toString() != "") {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
        if (Platform.isIOS) {
          _showIOSAlert(context, Text("Şifre sıfırlama linki $resetMail adresine gönderildi"));
        } else {
          _showAndroidAlert(context, Text("Şifre sıfırlama linki $resetMail adresine gönderildi"));
        }
      } on FirebaseAuthException catch (err) {
        if (err.code == "invalid-email") {
          if (Platform.isIOS) {
            _showIOSAlert(
                context,
                const Text("Geçersiz E-posta",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          } else {
            _showAndroidAlert(
                context,
                const Text("Geçersiz E-posta",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          }
        } else if (err.code == "user-not-found") {
          if (Platform.isIOS) {
            _showIOSAlert(
                context,
                const Text("Kullanıcı bulunamadı",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          } else {
            _showAndroidAlert(
                context,
                const Text("Kullanıcı bulunamadı",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          }
        }
      }
    } else {
      if (Platform.isIOS) {
        _showIOSAlert(context, const Text("E-posta alanı boş bırakılamaz"));
      } else {
        _showAndroidAlert(context, const Text("E-posta alanı boş bırakılamaz"));
      }
    }
  }
}
