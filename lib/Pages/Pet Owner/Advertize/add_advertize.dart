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
                  const Text("Lütfen adres seçin"),
                  const SizedBox(
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
                                    value: document["Title"],
                                    child: Text(
                                      document["Title"],
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedAdres,
                            onChanged: (newValue) {
                              setState(() {
                                selectedAdres = newValue as String?;
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
                  const Text("Lütfen dostunuzu seçin"),
                  const SizedBox(
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
                                  value: document["Pet Name"],
                                  child: Text(
                                    document["Pet Name"],
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedPet,
                          onChanged: (newValue) {
                            setState(() {
                              selectedPet = newValue as String?;
                            });
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    final data = await FirebaseFirestore.instance
                        .collection("advertize")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("advertizement")
                        .doc();

                    data.set({"Adres": selectedAdres, "Pet": selectedPet, "ID": data.id});
                    Navigator.pop(context);

                    print(data.id);
                  },
                  child: Text("İlan ver"))
            ],
          ),
        ),
      ),
    );
  }
}
