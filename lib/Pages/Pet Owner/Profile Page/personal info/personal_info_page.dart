import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/check_state.dart';
import 'package:flutter_application_1/LoginSignUp/forgot_password_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/personal%20info/delete_account_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final user = FirebaseAuth.instance.currentUser;

  final Stream _stream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  Reference ref =
      FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child("Profile Picture");

  @override
  void dispose() {
    user;
    super.dispose();
  }

  @override
  void initState() {
    getPhone();
    super.initState();
  }

  Future getPhone() async {
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);

    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        userPhone = data["Phone Number"];
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );
    setState(() {
      userPhone;
    });
  }

  Future updateAdress(String adress) async {
    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc("User Info")
        .update({
      "Adress": adress,
    });
  }

  Future uploadPicture() async {
    setState(() {
      isLoading = true;
    });

    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      isLoading = false;
    });

    if (file != null) {
      await ref.putFile(File(file.path)).then((p0) {
        setState(() {
          isLoading = true;
        });
      });
    }

    imageURL = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Profile picture": imageURL}).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const CheckState();
        } else {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              elevation: 0,
              title: const Text(
                "Kişisel Bilgiler",
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          child: Builder(
                            builder: (context) {
                              if (isLoading == true) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 60),
                                  child: Center(child: CircularProgressIndicator.adaptive()),
                                );
                              }

                              return TextButton(
                                onPressed: () async {
                                  uploadPicture();
                                },
                                child: StreamBuilder(
                                  stream: _stream,
                                  builder: (context, snapshot) {
                                    if (imageURL == null) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(1000),
                                            border: Border.all(width: 4, color: applicationOrange)),
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.transparent,
                                          child: Icon(
                                            Icons.person,
                                            size: 60,
                                            color: applicationOrange,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(imageURL!),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          user!.displayName!,
                          style: const TextStyle(fontSize: 25, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: applicationOrange,
                          ),
                          child: Center(
                            child: Text(
                              user!.email.toString(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: applicationOrange,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+90 $userPhone",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                ));
                          },
                          child: Container(
                            height: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: applicationOrange,
                            ),
                            child: const Center(
                              child: Text(
                                "Şifre Sıfırlama",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Hesabı silmek istediğine emin misin ?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Vazgeç",
                                              style: TextStyle(fontSize: 18),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                CupertinoDialogRoute(
                                                    builder: (context) {
                                                      return const DeleteAccountPage();
                                                    },
                                                    context: context),
                                              );
                                            },
                                            child: Text(
                                              "Hesabı sil",
                                              style:
                                                  TextStyle(fontSize: 18, color: applicationOrange),
                                            )),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Hesabı Sil",
                            style: TextStyle(color: applicationOrange, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
