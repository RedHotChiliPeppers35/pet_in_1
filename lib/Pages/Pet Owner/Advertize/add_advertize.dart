import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAdvertizePage extends StatefulWidget {
  const AddAdvertizePage({super.key});

  @override
  State<AddAdvertizePage> createState() => _AddAdvertizePageState();
}

class _AddAdvertizePageState extends State<AddAdvertizePage> {
  String? selectedAdres;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İlan Ver "),
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
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
                    items: snapshot.data!.docs
                        .map(
                          (document) => DropdownMenuItem(
                            child: Text(
                              document["Title"],
                            ),
                            value: document.id,
                          ),
                        )
                        .toList(),
                    value: selectedAdres,
                    onChanged: (newValue) {
                      setState(() {
                        print(newValue);
                        selectedAdres = newValue;
                      });
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
