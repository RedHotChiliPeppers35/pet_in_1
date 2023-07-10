import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/select_type_of_ad.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/daily_care_filter_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/main_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/main.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NightlyAdvertize extends StatefulWidget {
  const NightlyAdvertize({super.key});

  @override
  State<NightlyAdvertize> createState() => _NightlyAdvertizeState();
}

class _NightlyAdvertizeState extends State<NightlyAdvertize> {
  // ignore: prefer_final_fields
  DateRangePickerController _dateController = DateRangePickerController();

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
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) {
                    if (listCounter == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            const AdvertizeSelector(),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
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
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          children: [
                            const AdvertizeSelector(),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
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
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          ],
                        ),
                      );
                    }
                  },
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
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
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().add(const Duration(days: 1)),
                        DateTime.now().add(const Duration(days: 5))),
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    enablePastDates: false,
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () async {
                      var start = _dateController.selectedRange?.startDate;
                      var end = _dateController.selectedRange?.endDate;
                      if (end == null || start == null || end == start) {
                        if (Platform.isIOS) {
                          showIOSAlert(context,
                              const Text("Tarihleri minimum 1 gece olacak şekilde seçiniz"));
                        } else {
                          showAndroidAlert(context,
                              const Text("Tarihleri minimum 1 gece olacak şekilde seçiniz"));
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
                            .collection("Nightly on Hosts House")
                            .doc();

                        await data.set({
                          "Adress": selectedAdres,
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
                      }
                    },
                    child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: applicationOrange, borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          "Filtrele",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )))),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
