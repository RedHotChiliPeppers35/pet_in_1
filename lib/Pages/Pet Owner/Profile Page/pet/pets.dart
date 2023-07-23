import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/pet/pet_add_page.dart';
import "package:flutter_application_1/main.dart";

String? selectedpet = "Köpek";

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  void initState() {
    super.initState();
  }

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
          "Dostlar",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                      builder: (context) {
                        return const PetAddPage();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("pets")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("Hamster")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> hamsterSnapshot) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("pets")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("Kuş")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> birdSnapshot) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("pets")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("Kedi")
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot<QuerySnapshot> catSnapshot) {
                              return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("pets")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("Köpek")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> dogSnapshot) {
                                  if (!dogSnapshot.hasData) {
                                    return const CircularProgressIndicator.adaptive();
                                  } else {
                                    if (dogSnapshot.data!.docs.isEmpty &&
                                        catSnapshot.data!.docs.isEmpty &&
                                        birdSnapshot.data!.docs.isEmpty) {
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.pets,
                                                  size: 50,
                                                  color: applicationOrange,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  "Henüz bir dostun gözükmüyor",
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
                                                      return const PetAddPage();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Dost ekle",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: dogSnapshot.data!.docs.map((document) {
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              dogSnapshot.connectionState !=
                                                                      ConnectionState.waiting
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius: 40,
                                                                        backgroundImage:
                                                                            NetworkImage(document[
                                                                                "Pet Photo URL"]),
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child:
                                                                          CircularProgressIndicator
                                                                              .adaptive(),
                                                                    ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      document["Pet Name"],
                                                                      style: const TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Text(
                                                                      "${document["Pet Age"]} yaşında ",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Türü: ${document["Pet Kind"]}",
                                                                      style: const TextStyle(
                                                                        fontSize: 17,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Irk: ${document["Pet Race"]}",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Not: ${document["Pet Alert"]}",
                                                                      maxLines: 5,
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            showCupertinoModalPopup(
                                                                context: context,
                                                                builder: (BuildContext context) =>
                                                                    CupertinoAlertDialog(
                                                                        title: const Text(
                                                                            "Dostunu silmek istediğine emin misin ?"),
                                                                        actions: <CupertinoDialogAction>[
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            child: const Text(
                                                                                'Vazgeç'),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () async {
                                                                              await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                      "pets")
                                                                                  .doc(FirebaseAuth
                                                                                      .instance
                                                                                      .currentUser!
                                                                                      .uid)
                                                                                  .collection(
                                                                                      "Köpek")
                                                                                  .doc(document.id)
                                                                                  .delete()
                                                                                  .then((value) =>
                                                                                      Navigator.pop(
                                                                                          context));
                                                                            },
                                                                            child: const Text(
                                                                              'Sil',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                      Colors.red),
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
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                          ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: catSnapshot.data!.docs.map((document) {
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              catSnapshot.connectionState !=
                                                                      ConnectionState.waiting
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius: 40,
                                                                        backgroundImage:
                                                                            NetworkImage(document[
                                                                                "Pet Photo URL"]),
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child:
                                                                          CircularProgressIndicator
                                                                              .adaptive(),
                                                                    ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      document["Pet Name"],
                                                                      style: const TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Text(
                                                                      "${document["Pet Age"]} yaşında ",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Türü: ${document["Pet Kind"]}",
                                                                      style: const TextStyle(
                                                                        fontSize: 17,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Irk: ${document["Pet Race"]}",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Not: ${document["Pet Alert"]}",
                                                                      maxLines: 5,
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            showCupertinoModalPopup(
                                                                context: context,
                                                                builder: (BuildContext context) =>
                                                                    CupertinoAlertDialog(
                                                                        title: const Text(
                                                                            "Dostunu silmek istediğine emin misin ?"),
                                                                        actions: <CupertinoDialogAction>[
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            child: const Text(
                                                                                'Vazgeç'),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () async {
                                                                              await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                      "pets")
                                                                                  .doc(FirebaseAuth
                                                                                      .instance
                                                                                      .currentUser!
                                                                                      .uid)
                                                                                  .collection(
                                                                                      "Kedi")
                                                                                  .doc(document.id)
                                                                                  .delete()
                                                                                  .then((value) =>
                                                                                      Navigator.pop(
                                                                                          context));
                                                                            },
                                                                            child: const Text(
                                                                              'Sil',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                      Colors.red),
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
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                          ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: birdSnapshot.data!.docs.map((document) {
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              birdSnapshot.connectionState !=
                                                                      ConnectionState.waiting
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius: 40,
                                                                        backgroundImage:
                                                                            NetworkImage(document[
                                                                                "Pet Photo URL"]),
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child:
                                                                          CircularProgressIndicator
                                                                              .adaptive(),
                                                                    ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      document["Pet Name"],
                                                                      style: const TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Text(
                                                                      "${document["Pet Age"]} yaşında ",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Türü: ${document["Pet Kind"]}",
                                                                      style: const TextStyle(
                                                                        fontSize: 17,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Irk: ${document["Pet Race"]}",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Not: ${document["Pet Alert"]}",
                                                                      maxLines: 5,
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            showCupertinoModalPopup(
                                                                context: context,
                                                                builder: (BuildContext context) =>
                                                                    CupertinoAlertDialog(
                                                                        title: const Text(
                                                                            "Dostunu silmek istediğine emin misin ?"),
                                                                        actions: <CupertinoDialogAction>[
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            child: const Text(
                                                                                'Vazgeç'),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () async {
                                                                              await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                      "pets")
                                                                                  .doc(FirebaseAuth
                                                                                      .instance
                                                                                      .currentUser!
                                                                                      .uid)
                                                                                  .collection("Kuş")
                                                                                  .doc(document.id)
                                                                                  .delete()
                                                                                  .then((value) =>
                                                                                      Navigator.pop(
                                                                                          context));
                                                                            },
                                                                            child: const Text(
                                                                              'Sil',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                      Colors.red),
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
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                          ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: hamsterSnapshot.data!.docs.map((document) {
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: [
                                                              hamsterSnapshot.connectionState !=
                                                                      ConnectionState.waiting
                                                                  ? Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child: CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius: 40,
                                                                        backgroundImage:
                                                                            NetworkImage(document[
                                                                                "Pet Photo URL"]),
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child:
                                                                          CircularProgressIndicator
                                                                              .adaptive(),
                                                                    ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      document["Pet Name"],
                                                                      style: const TextStyle(
                                                                          fontSize: 25,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 50,
                                                                    ),
                                                                    Text(
                                                                      "${document["Pet Age"]} yaşında ",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Türü: ${document["Pet Kind"]}",
                                                                      style: const TextStyle(
                                                                        fontSize: 17,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Irk: ${document["Pet Race"]}",
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    ),
                                                                    Text(
                                                                      "Not: ${document["Pet Alert"]}",
                                                                      maxLines: 5,
                                                                      style: const TextStyle(
                                                                          fontSize: 17),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            showCupertinoModalPopup(
                                                                context: context,
                                                                builder: (BuildContext context) =>
                                                                    CupertinoAlertDialog(
                                                                        title: const Text(
                                                                            "Dostunu silmek istediğine emin misin ?"),
                                                                        actions: <CupertinoDialogAction>[
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            child: const Text(
                                                                                'Vazgeç'),
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            isDefaultAction: true,
                                                                            onPressed: () async {
                                                                              await FirebaseFirestore
                                                                                  .instance
                                                                                  .collection(
                                                                                      "pets")
                                                                                  .doc(FirebaseAuth
                                                                                      .instance
                                                                                      .currentUser!
                                                                                      .uid)
                                                                                  .collection("Kuş")
                                                                                  .doc(document.id)
                                                                                  .delete()
                                                                                  .then((value) =>
                                                                                      Navigator.pop(
                                                                                          context));
                                                                            },
                                                                            child: const Text(
                                                                              'Sil',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                      Colors.red),
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
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                },
                              );
                            });
                      });
                }),
          ),
        ),
      ),
    );
  }
}
