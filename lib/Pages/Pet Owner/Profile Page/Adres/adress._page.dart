import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/Adres/add_adress_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:string_extensions/string_extensions.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({super.key});

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          toolbarHeight: 75,
          elevation: 0,
          title: const Text(
            "Adres Bilgileri",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddAdressPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Adresses")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("User Adresses")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator.adaptive();
            } else {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: applicationPurple.withAlpha(100),
                              borderRadius: BorderRadius.circular(20)),
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        document["Title"],
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${document["Street"].toString().toTitleCase}, \n${document["Apartment No"]}, ${document["Door No"]} \n${document["Neighbourhood"]}  \n${document["District"].toString().capitalize}/${document["City"].toString().toUpperCase()}  \nNot: ${document["Note"]} ",
                                        style: const TextStyle(fontSize: 15),
                                        maxLines: 4,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (BuildContext context) => CupertinoAlertDialog(
                                                title: const Text(
                                                    "Adresi silmek istediğine emin misin ?"),
                                                actions: <CupertinoDialogAction>[
                                                  CupertinoDialogAction(
                                                    isDefaultAction: true,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Vazgeç'),
                                                  ),
                                                  CupertinoDialogAction(
                                                    isDefaultAction: true,
                                                    onPressed: () async {
                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth
                                                              .instance.currentUser!.uid)
                                                          .collection("User Adress")
                                                          .doc(document.id)
                                                          .delete()
                                                          .then((value) => Navigator.pop(context));
                                                    },
                                                    child: const Text(
                                                      'Sil',
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                  ),
                                                ]));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }).toList(),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 50,
                            color: applicationOrange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Henüz adres bilgisi bulunmuyor",
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
                                return const AddAdressPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Adres ekle",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
