// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/select_type_of_ad.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/main_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/main.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

int price = 250;
String? selectedPet;
String? selectedAdres;
DateRangePickerController _dateController = DateRangePickerController();

class NightlyAdvertize extends StatefulWidget {
  const NightlyAdvertize({super.key});

  @override
  State<NightlyAdvertize> createState() => _NightlyAdvertizeState();
}

class _NightlyAdvertizeState extends State<NightlyAdvertize> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        // ignore: lines_longer_than_80_chars;
        ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
      } else {}
    });
  }

  @override
  void dispose() {
    selectedPet = null;
    selectedAdres = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            actions: const [
              SizedBox(
                width: 25,
              )
            ],
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              ),
            ),
            title: const AdvertizeSelector(),
            backgroundColor: applicationOrange),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  listCounter == 1
                      ? const Column(
                          children: [
                            PetCaller(),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AdressCaller()
                          ],
                        )
                      : const PetCaller(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Takvim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 300,
                    width: 350,
                    child: SfDateRangePicker(
                      rangeSelectionColor: applicationPurple,
                      rangeTextStyle: const TextStyle(color: Colors.white),
                      startRangeSelectionColor: applicationOrange,
                      endRangeSelectionColor: applicationOrange,
                      todayHighlightColor: applicationOrange,
                      controller: _dateController,
                      minDate: DateTime.now().subtract(const Duration(hours: 1)),
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      enablePastDates: false,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const BudgetWidgetNightly(
                    max: 450,
                    min: 250,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AdvertizeButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BudgetWidgetNightly extends StatefulWidget {
  const BudgetWidgetNightly({super.key, @required this.max, @required this.min});

  final int? max;
  final int? min;

  @override
  State<BudgetWidgetNightly> createState() => _BudgetWidgetNightlyState();
}

class _BudgetWidgetNightlyState extends State<BudgetWidgetNightly> {
  @override
  void initState() {
    price = 350;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Fiyatınızı Belirleyin", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          height: 100,
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Text(
                      "Fiyatı gecelik ${widget.min}₺ \n${widget.max}₺ arasında \nbelirleyebilirsiniz",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      setState(() {
                        price -= 10;
                        if (price <= widget.min!.toInt()) {
                          price = widget.min!.toInt();
                        }
                      });
                      print(price);
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${price.toString()} ₺",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton.small(
                    backgroundColor: applicationPurple,
                    onPressed: () {
                      setState(() {
                        price += 10;
                        if (price >= widget.max!.toInt()) {
                          price = widget.max!.toInt();
                        }
                      });
                      print(price);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PetCaller extends StatefulWidget {
  const PetCaller({super.key});

  @override
  State<PetCaller> createState() => _PetCallerState();
}

class _PetCallerState extends State<PetCaller> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("pets")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Balık")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> fishSnapshot) {
          return StreamBuilder(
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
                              builder:
                                  (BuildContext context, AsyncSnapshot<QuerySnapshot> dogSnapshot) {
                                if (dogSnapshot.connectionState == ConnectionState.waiting &&
                                    catSnapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator.adaptive();
                                } else {
                                  return Column(
                                    children: [
                                      const Text(
                                        "Dostlarınız",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        height: 105,
                                        width: 350,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Row(
                                                  children: [
                                                    PetCard(petSnapshot: dogSnapshot),
                                                    PetCard(petSnapshot: catSnapshot),
                                                    PetCard(petSnapshot: birdSnapshot),
                                                    PetCard(petSnapshot: hamsterSnapshot),
                                                    PetCard(petSnapshot: fishSnapshot)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          });
                    });
              });
        });
  }
}

class PetCard extends StatefulWidget {
  const PetCard({@required this.petSnapshot, super.key});

  final AsyncSnapshot<QuerySnapshot<Object?>>? petSnapshot;

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.petSnapshot!.data!.docs.map(
        (document) {
          return TextButton(
            onPressed: () {
              print(document.id);
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Center(
                  child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    foregroundImage: NetworkImage(document["Pet Photo URL"]),
                  ),
                  Text(
                    document["Pet Name"],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              )),
            ),
          );
        },
      ).toList(),
    );
  }
}

class AdressCaller extends StatefulWidget {
  const AdressCaller({super.key});

  @override
  State<AdressCaller> createState() => _AdressCallerState();
}

class _AdressCallerState extends State<AdressCaller> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Adres Seçimi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 350,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Seçilen adres:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("adresses")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("User Adresses")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> adressSnapshot) {
                    if (!adressSnapshot.hasData) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return SizedBox(
                        height: 50,
                        width: 100,
                        child: CupertinoPicker(
                          selectionOverlay: null,
                          backgroundColor: Colors.transparent,
                          itemExtent: 20,
                          onSelectedItemChanged: (value) {},
                          children: adressSnapshot.data!.docs
                              .map(
                                (document) => DropdownMenuItem(
                                    value: document["Title"],
                                    child: Center(
                                      child: Text(
                                        document["Title"],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    )),
                              )
                              .toList(),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class AdvertizeButton extends StatefulWidget {
  const AdvertizeButton({super.key});

  @override
  State<AdvertizeButton> createState() => _AdvertizeButtonState();
}

class _AdvertizeButtonState extends State<AdvertizeButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var start = _dateController.selectedRange?.startDate;
        var end = _dateController.selectedRange?.endDate;
        if (end == null || start == null || end == start) {
          if (Platform.isIOS) {
            showIOSAlert(context, const Text("Tarihleri minimum 1 gece olacak şekilde seçiniz"));
          } else {
            showAndroidAlert(
                context, const Text("Tarihleri minimum 1 gece olacak şekilde seçiniz"));
          }
        } else if (listCounter == 0 && selectedPet != null) {
          debugPrint("Bakıcı evinde konaklama");
          print(start);
          print(end);

          final data = FirebaseFirestore.instance
              .collection("advertize")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Nightly on Hosts House")
              .doc();

          await data.set({
            "Price": price,
            "Pet": selectedPet,
            "Time-Start": start,
            "Time-End": end,
            "ID": data.id
          });
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const MainPage(),
              ));
        } else if (listCounter == 1 && selectedAdres != null && selectedPet != null) {
          debugPrint("Kendi evinde konaklama");
          print(start);
          print(end);
          final data = FirebaseFirestore.instance
              .collection("advertize")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Nightly on Pet Owners House")
              .doc();

          await data.set({
            "Price": price,
            "Pet": selectedPet,
            "Adress": selectedAdres,
            "Time-Start": start,
            "Time-End": end,
            "ID": data.id
          });
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        }
      },
      child: Container(
        height: 40,
        width: 150,
        decoration:
            BoxDecoration(color: applicationOrange, borderRadius: BorderRadius.circular(20)),
        child: const Center(
          child: Text(
            "İlan Ver",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
