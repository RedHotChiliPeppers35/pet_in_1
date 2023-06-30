import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/forgot_password_page.dart';
import 'package:flutter_application_1/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.showRegisterPage,
  });
  final VoidCallback showRegisterPage;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage("images/petinone.png")),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                            autocorrect: false,
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
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                            autocorrect: false,
                            controller: _passwordController,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelText: "Şifre",
                                labelStyle: const TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: applicationPurple,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const ForgotPasswordPage(),
                                    ));
                              },
                              child: const Text(
                                "Şifreni mi unuttun?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          logIn();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              color: applicationOrange, borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Üye değil misin?"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          "Üye ol",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: applicationOrange,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future logIn() async {
    if (_emailController.text.toString() != "" && _passwordController.text.toString() != "") {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (err) {
        if (err.code == "wrong-password") {
          if (Platform.isIOS) {
            _showIOSAlert(
                context,
                const Text("Lütfen şifrenizi kontrol ediniz",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          } else {
            _showAndroidAlert(
                context,
                const Text("Lütfen şifrenizi kontrol ediniz",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          }
        } else if (err.code == "invalid-email") {
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
        _showIOSAlert(context, const Text("E-posta ve şifre alanı boş bırakılamaz"));
      } else {
        _showAndroidAlert(context, const Text("E-posta ve şifre alanı boş bırakılamaz"));
      }
    }
  }

  void _showIOSAlert(BuildContext context, Text myContent) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("HATA"),
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
          title: const Text("HATA"),
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
}
