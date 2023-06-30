import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/add_advertize.dart';
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
                  .collection("advertizement")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else if (snapshot.data!.docs.isEmpty) {
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoModalPopupRoute(
                                builder: (context) {
                                  return AddAdvertizePage();
                                },
                              ),
                            );
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
                  return Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  );
                }
              },
            ),
          ),
        ));
  }
}
