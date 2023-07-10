// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/select_type_of_ad.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/add_adress_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/pet_add_page.dart';
import 'package:flutter_application_1/main.dart';

class AdvertizePage extends StatefulWidget {
  const AdvertizePage({super.key});

  @override
  State<AdvertizePage> createState() => _AdvertizePageState();
}

class _AdvertizePageState extends State<AdvertizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoDialogRoute(
                          builder: (context) {
                            return const SelectTypeOfAdvertize();
                          },
                          context: context));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                )),
          )
        ],
        title: const Text(
          "İlanlarım",
        ),
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("advertize")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Daily on Pet Owners House")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("advertize")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("Nightly on Hosts House")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (snapshot1.data!.docs.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.task,
                                size: 50,
                                color: applicationOrange,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Henüz ilanın bulunmuyor",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () async {
                              DocumentReference collectionReference = FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid);

                              QuerySnapshot adressSnapshot =
                                  await collectionReference.collection("User Adress").get();

                              QuerySnapshot petSnapshot =
                                  await collectionReference.collection("User Pets").get();
                              if (adressSnapshot.docs.isEmpty) {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    content: const Text("Adres eklemeden ilan veremezsiniz",
                                        style: TextStyle(fontSize: 18)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            CupertinoDialogRoute(
                                                builder: (context) => const AddAdressPage(),
                                                context: context),
                                          );
                                        },
                                        child: const Text(
                                          "Adres Ekle",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (petSnapshot.docs.isEmpty) {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    content: const Text("Dost eklemeden ilan veremezsiniz",
                                        style: TextStyle(fontSize: 18)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            CupertinoDialogRoute(
                                                builder: (context) => const PetAddPage(),
                                                context: context),
                                          );
                                        },
                                        child:
                                            const Text("Dost Ekle", style: TextStyle(fontSize: 18)),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  CupertinoDialogRoute(
                                      builder: (context) {
                                        return const SelectTypeOfAdvertize();
                                      },
                                      context: context),
                                );
                              }
                            },
                            child: const Text(
                              "İlan ver",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: snapshot1.data!.docs.map(
                              (document) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(document["ID"]),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: snapshot2.data!.docs.map(
                              (document) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(document["ID"]),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        )
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
