import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/check_state.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/personal_info_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';

import '../../../main.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController;
    _emailController;
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
        backgroundColor: Colors.transparent.withOpacity(0.7),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(CupertinoDialogRoute(
                      builder: (context) => const PersonalInformationPage(), context: context)),
                  icon: Icon(
                    Icons.close,
                    color: applicationOrange,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hesabınızı silmek için lütfen bilgilerinizi giriniz",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      autocorrect: false,
                      cursorColor: Colors.white,
                      controller: _emailController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "E-mail",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      autocorrect: false,
                      cursorColor: Colors.white,
                      controller: _passwordController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Şifre(Tekrar)",
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: applicationPurple,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .reauthenticateWithCredential(
                            EmailAuthProvider.credential(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          )
                              .then(
                            (value) async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .delete();

                              await FirebaseStorage.instance
                                  .ref(FirebaseAuth.instance.currentUser!.uid)
                                  .child("Profile Picture")
                                  .delete();
                              await FirebaseAuth.instance.currentUser!.delete();
                              await FirebaseAuth.instance.signOut();
                            },
                          ).then(
                            (value) {
                              return Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoDialogRoute(
                                      builder: (context) => const CheckState(), context: context),
                                  (route) => false);
                            },
                          );
                        } on FirebaseAuthException catch (err) {
                          if (err.code == "wrong-password") {
                            if (Platform.isIOS) {
                              showIOSAlert(
                                  context,
                                  const Text("Lütfen şifrenizi kontrol ediniz",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            } else {
                              showAndroidAlert(
                                  context,
                                  const Text("Lütfen şifrenizi kontrol ediniz",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            }
                          } else if (err.code == "invalid-email") {
                            if (Platform.isIOS) {
                              showIOSAlert(
                                  context,
                                  const Text("Geçersiz E-posta",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            } else {
                              showAndroidAlert(
                                  context,
                                  const Text("Geçersiz E-posta",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            }
                          } else if (err.code == "user-not-found") {
                            if (Platform.isIOS) {
                              showIOSAlert(
                                  context,
                                  const Text("Kullanıcı bulunamadı",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            } else {
                              showAndroidAlert(
                                  context,
                                  const Text("Kullanıcı bulunamadı",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )));
                            }
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: applicationOrange, borderRadius: BorderRadius.circular(20)),
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: const Center(
                            child: Text(
                              "Hesabı sil",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
