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
  String? selectedAdres;
  String? selectedPet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İlan Ver "),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lütfen adres seçin"),
                  SizedBox(
                    width: 20,
                  ),
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
                            iconEnabledColor: applicationPurple,
                            iconDisabledColor: applicationOrange,
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lütfen dostunuzu seçin"),
                  SizedBox(
                    width: 20,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("User Pets")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator.adaptive();
                        } else {
                          return DropdownButton(
                            iconEnabledColor: applicationPurple,
                            iconDisabledColor: applicationOrange,
                            items: snapshot.data!.docs
                                .map(
                                  (document) => DropdownMenuItem(
                                    child: Text(
                                      document["Pet Name"],
                                    ),
                                    value: document.id,
                                  ),
                                )
                                .toList(),
                            value: selectedPet,
                            onChanged: (newValue) {
                              setState(() {
                                selectedPet = newValue;
                              });
                            },
                          );
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
