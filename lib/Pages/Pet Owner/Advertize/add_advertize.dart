import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class AddAdvertizePage extends StatefulWidget {
  const AddAdvertizePage({super.key});

  @override
  State<AddAdvertizePage> createState() => _AddAdvertizePageState();
}

class _AddAdvertizePageState extends State<AddAdvertizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İlan Ver "),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("İlanın olacağı adres: "),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("User Adress")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        return DropdownButton(
                          onChanged: (value) {},
                          items: List.of(
                            List.from(
                              snapshot.data!.docs.map((document) {
                                return document["Title"];
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "İlan ver",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
