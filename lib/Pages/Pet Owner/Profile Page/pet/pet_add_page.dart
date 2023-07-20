import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/pet/pets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:image_picker/image_picker.dart';

TextEditingController petNameController = TextEditingController();
TextEditingController petKindController = TextEditingController();
TextEditingController petAgeController = TextEditingController();
TextEditingController petAlertController = TextEditingController();
TextEditingController petRaceController = TextEditingController();

String? petImage;
XFile? file;

class PetAddPage extends StatefulWidget {
  const PetAddPage({super.key});

  @override
  State<PetAddPage> createState() => _PetAddPageState();
}

class _PetAddPageState extends State<PetAddPage> {
  @override
  void initState() {
    petImage = null;
    super.initState();
  }

  Future uploadPicture() async {
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        petImage = file!.path;
      });
    } catch (e) {
      setState(() {
        print(e);
        petImage = null;
      });
    }
  }

  Future addPet() async {
    Reference ref = FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid);

    final data = FirebaseFirestore.instance
        .collection("pets")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(selectedpet.toString())
        .doc();

    if (file != null) {
      await ref.child("Pet Images").child(data.id).putFile(
            File(file!.path),
          );
    }
    petImage = await ref.child("Pet Images").child(data.id).getDownloadURL();

    await data.set(
      {
        "Pet Name": petNameController.text.trim(),
        "Pet Kind": selectedpet!.trim(),
        "Pet Race": petRaceController.text.trim(),
        "Pet Age": petAgeController.text.trim(),
        "Pet Alert": petAlertController.text.trim(),
        "Pet Photo URL": petImage,
      },
    ).then((value) {
      petNameController.clear();
      petKindController.clear();
      petAgeController.clear();
      petAlertController.clear();
      petRaceController.clear();
      petImage = null;
    });
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
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: CupertinoContextMenu.kEndBoxShadow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: applicationOrange,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    uploadPicture();
                  },
                  child: Builder(
                    builder: (context) {
                      if (petImage == null) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(width: 4, color: applicationOrange)),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.person_add_alt,
                              size: 60,
                              color: applicationOrange,
                            ),
                          ),
                        );
                      } else {
                        return StreamBuilder(
                          stream: Stream.value(petImage),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    border: Border.all(width: 4, color: applicationOrange)),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: FileImage(
                                    File(file!.path),
                                  ),
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator.adaptive();
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        child: TextField(
                          autocorrect: false,
                          cursorColor: Colors.white,
                          controller: petNameController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "Dostunuzun Adı",
                              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                              filled: true,
                              fillColor: applicationPurple.withAlpha(100),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.7,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: applicationPurple.withAlpha(100),
                              borderRadius: BorderRadius.circular(20)),
                          child: const DropDownPets()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        child: TextField(
                          autocorrect: false,
                          cursorColor: Colors.white,
                          controller: petRaceController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "Dostunuzun Irkı",
                              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                              filled: true,
                              fillColor: applicationPurple.withAlpha(100),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        child: TextField(
                          autocorrect: false,
                          cursorColor: Colors.white,
                          controller: petAgeController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "Dostunuzun Yaşı",
                              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                              filled: true,
                              fillColor: applicationPurple.withAlpha(100),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 100,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: 10,
                          autocorrect: false,
                          cursorColor: Colors.black,
                          controller: petAlertController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              label: const Text(
                                "Dostunuzun özel bilgileri (Alerji, obsesyon, diyet vb.)",
                                style: TextStyle(fontSize: 15),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: applicationPurple.withAlpha(100),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      petImage == null;
                    });
                    addPet();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: applicationOrange,
                    ),
                    child: const Center(
                      child: Text(
                        "Kaydet",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownPets extends StatefulWidget {
  const DropDownPets({super.key});

  @override
  State<DropDownPets> createState() => _DropDownPetsState();
}

class _DropDownPetsState extends State<DropDownPets> {
  List<String> pets = [
    "Köpek",
    "Kedi",
    "Kuş",
    "Hamster",
    "Balık",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        iconEnabledColor: Colors.black,
        iconSize: 30,
        style: const TextStyle(color: Colors.black, fontFamily: "Quicksand"),
        value: selectedpet,
        items: pets
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => selectedpet = value),
      ),
    );
  }
}
