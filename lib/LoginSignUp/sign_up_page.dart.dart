// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:string_extensions/string_extensions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.showLoginPage});
  final VoidCallback showLoginPage;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool kosullarCheck = false;
  bool emailCheck = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Widget kosulHukumCheckBox() {
    return Checkbox(
      fillColor: MaterialStateProperty.all<Color>(applicationOrange),
      checkColor: applicationPurple,
      activeColor: applicationOrange,
      value: kosullarCheck,
      onChanged: (value) {
        setState(() {
          if (kosullarCheck == false) {
            kosullarCheck = true;
          } else if (kosullarCheck = true) {
            kosullarCheck = false;
          }
          debugPrint("Koşullar okudum, onaylıyorum: $kosullarCheck");
        });
      },
    );
  }

  Widget ePostaCheckBox() {
    return Checkbox(
      fillColor: MaterialStateProperty.all<Color>(applicationOrange),
      checkColor: applicationPurple,
      activeColor: applicationOrange,
      value: emailCheck,
      onChanged: (value) {
        setState(() {
          if (emailCheck == false) {
            emailCheck = true;
          } else if (emailCheck = true) {
            emailCheck = false;
          }
          debugPrint("E mail ile haber almak istiyorum: $emailCheck");
          debugPrint(_emailController.text.trim());
        });
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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

  Future signUp() async {
    if (kosullarCheck == true &&
        _firstNameController.text != "" &&
        _lastNameController.text != "" &&
        _emailController.text != "" &&
        _phoneNumberController.text.length == 12 &&
        _passwordController.text.length >= 6 &&
        _passwordController.text.toString() == _confirmPasswordController.text.toString()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.toString(),
        )
            .then(
          (value) {
            addUserDetails(
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _emailController.text.toLowerCase(),
              _phoneNumberController.text.trim(),
              _passwordController.text.toString(),
              FirebaseAuth.instance.currentUser!.uid.toString(),
            );
            FirebaseAuth.instance.currentUser?.updateDisplayName(
                "${_firstNameController.text.toTitleCase} ${_lastNameController.text.toTitleCase}");
            FirebaseAuth.instance.currentUser!.updateEmail(_emailController.text.trim());
          },
        );
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
        } else if (err.code == "email-already-in-use") {
          if (Platform.isIOS) {
            _showIOSAlert(
                context,
                const Text(
                    "Bu E-posta adresi zaten başka bir hesaba kayıtlı, Lütfen farklı bir E-posta adresi deneyiniz",
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
        } else if (err.code == "weak-password") {
          if (Platform.isIOS) {
            _showIOSAlert(
                context,
                const Text("Şifre en az 6 karakterden oluşmalıdır",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          } else {
            _showAndroidAlert(
                context,
                const Text("Şifre en az 6 karakterden oluşmalıdır",
                    style: TextStyle(
                      fontSize: 15,
                    )));
          }
        }
      }
    } else if (_emailController.text == "") {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text('Lütfen E-posta giriniz'),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Lütfen E-posta giriniz"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (_phoneNumberController.text.length != 12) {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text('Lütfen telefon numaranızı kontrol edin'),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Lütfen telefon numaranızı kontrol edin"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (_firstNameController.text == "") {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text("İsim alanı boş bırakılamaz"),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("İsim alanı boş bırakılamaz"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (_lastNameController.text == "") {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text("Soy isim alanı boş bırakılamaz"),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Soy isim alanı boş bırakılamaz"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (_passwordController.text.length < 6) {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text("Şifre karakter sayısı 10 veya daha fazla olmalıdır"),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Şifre karakter sayısı 10 veya daha fazla olmalıdır"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (_passwordController.text != _confirmPasswordController.text) {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text("Şifreler uyuşmamaktadır"),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Şifreler uyuşmamaktadır"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    } else if (kosullarCheck == false) {
      if (Platform.isIOS == true) {
        void _showAlertDialog(BuildContext context) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('HATA'),
              content: const Text("Koşulları okuyup, kabul etmeniz gerekmektedir"),
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

        _showAlertDialog(context);
      } else {
        void _showDialog(BuildContext context) {
          showDialog(
              context: context,
              barrierDismissible:
                  true, // disables popup to close if tapped outside popup (need a button to close)
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "HATA",
                  ),
                  content: const Text("Koşulları okuyup, kabul etmeniz gerekli"),
                  //buttons?
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Kapat"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //closes popup
                    ),
                  ],
                );
              });
        }

        _showDialog(context);
      }
    }
  }

  Future addUserDetails(String firstName, String lastName, String eMail, String phoneNumber,
      String password, String userID) async {
    await FirebaseFirestore.instance.collection("users").doc(userID).set({
      "First Name": firstName,
      "Last Name": lastName,
      "E-mail": eMail,
      "Phone Number": phoneNumber,
      "Password": password,
      "User ID": userID,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                        child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold, color: applicationOrange),
                    ))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _firstNameController,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "İsim",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _lastNameController,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Soy İsim",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _emailController,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "E-posta",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    inputFormatters: [
                      PhoneInputFormatter(
                        allowEndlessPhone: false,
                        defaultCountryCode: "TR",
                      )
                    ],
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "5xx-xxx-xxxx",
                        hintStyle: const TextStyle(color: Colors.white),
                        labelText: "Telefon Numarası",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _passwordController,
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
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                    autocorrect: false,
                    cursorColor: Colors.white,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Şifre (Tekrar)",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)))),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    kosulHukumCheckBox(),
                    Flexible(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Koşulları",
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          ),
                          Text(
                            style: TextStyle(color: applicationOrange),
                            "okudum, kabul ediyorum",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ePostaCheckBox(),
                    Flexible(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          style: TextStyle(color: applicationOrange),
                          "E-posta ile gelişmelerden haberdar olmak istiyorum",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: signUp,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      color: applicationOrange, borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Kayıt ol",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Zaten üye misin?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Giriş yap",
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
      )),
    );
  }
}
