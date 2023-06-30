import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:string_extensions/string_extensions.dart';

class AddAdressPage extends StatefulWidget {
  const AddAdressPage({super.key});

  @override
  State<AddAdressPage> createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  TextEditingController hintText = TextEditingController();
  TextEditingController cityText = TextEditingController();
  TextEditingController districtText = TextEditingController();
  TextEditingController neighbourhoodText = TextEditingController();
  TextEditingController streetText = TextEditingController();
  TextEditingController apartmentText = TextEditingController();
  TextEditingController doorText = TextEditingController();
  TextEditingController noteText = TextEditingController();

  String? userAdress;
  Future addAdress() async {
    final data = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("User Adress")
        .doc();

    await data.set({
      "Title": hintText.text.capitalize,
      "City": cityText.text.capitalize,
      "District": districtText.text.capitalize,
      "Neighbourhood": neighbourhoodText.text.toTitleCase,
      "Street": streetText.text.capitalize,
      "Apartment No": apartmentText.text.capitalize,
      "Door No": doorText.text.capitalize,
      "Note": noteText.text.trim()
    });
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
        title: const Text("Adres ekle"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextFormField(
                              controller: hintText,
                              cursorColor: applicationPurple,
                              decoration: const InputDecoration(
                                  hintText: "Ev, İş, vb.", labelText: "Adres Başlığı"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    String neighbourhood = " Mahallesi";
                                    value.endsWith(neighbourhood)
                                        ? neighbourhoodText.text = value
                                        : neighbourhoodText.text = value + neighbourhood;
                                    neighbourhoodText.selection = TextSelection.fromPosition(
                                        TextPosition(
                                            offset: neighbourhoodText.text.length -
                                                neighbourhood.length));
                                  },
                                  controller: neighbourhoodText,
                                  cursorColor: applicationPurple,
                                  decoration: const InputDecoration(
                                      hintText: "Ör: Ataşehir Mahallesi", labelText: "Mahalle"),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    String street = " Sokak";
                                    value.endsWith(street)
                                        ? streetText.text = value
                                        : streetText.text = value + street;
                                    streetText.selection = TextSelection.fromPosition(TextPosition(
                                        offset: streetText.text.length - street.length));
                                  },
                                  controller: streetText,
                                  cursorColor: applicationPurple,
                                  decoration: const InputDecoration(
                                      hintText: "Ör: 1881 Sokak", labelText: "Sokak"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    String aptNo = "Bina No: ";
                                    value.startsWith(aptNo)
                                        ? apartmentText.text = value
                                        : apartmentText.text = aptNo + value;
                                    apartmentText.selection = TextSelection.fromPosition(
                                      TextPosition(offset: apartmentText.text.length),
                                    );
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: apartmentText,
                                  cursorColor: applicationPurple,
                                  decoration: const InputDecoration(
                                      hintText: "Ör: No 14", labelText: "Bina No"),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  onChanged: (value) {
                                    String doorNo = "Daire: ";
                                    value.startsWith(doorNo)
                                        ? doorText.text = value
                                        : doorText.text = doorNo + value;
                                    doorText.selection = TextSelection.fromPosition(
                                      TextPosition(offset: doorText.text.length),
                                    );
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: doorText,
                                  cursorColor: applicationPurple,
                                  decoration: const InputDecoration(
                                      hintText: "Ör: Daire 7", labelText: "Daire No"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextFormField(
                              controller: cityText,
                              cursorColor: applicationPurple,
                              decoration: const InputDecoration(hintText: "İl", labelText: "İl"),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextFormField(
                              controller: districtText,
                              cursorColor: applicationPurple,
                              decoration:
                                  const InputDecoration(hintText: "İlçe", labelText: "İlçe"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: applicationOrange,
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        autocorrect: false,
                        cursorColor: Colors.white,
                        controller: noteText,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Builder(
                            builder: (context) {
                              if (userAdress == null) {
                                return const Center(
                                    child: Text(
                                  "Not",
                                  textAlign: TextAlign.center,
                                ));
                              } else {
                                return Center(
                                    child: Text(
                                  userAdress!,
                                  textAlign: TextAlign.center,
                                ));
                              }
                            },
                          ),
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        addAdress();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Adres Ekle",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
