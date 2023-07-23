// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/nightly/nightly_advertize.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/select_type_of_ad.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/main_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/main.dart';
import 'package:intl/intl.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

DateTime? selectedStartTime;
DateTime? selectedEndTime;
DateTime? selectedDayStart;
DateTime? selectedDayEnd;
String? selectedAdres;
String? selectedPet;

class DailyAdvertize extends StatefulWidget {
  const DailyAdvertize({super.key});

  @override
  State<DailyAdvertize> createState() => _DailyAdvertizeState();
}

class _DailyAdvertizeState extends State<DailyAdvertize> {
  final DatePickerController _datePickerController = DatePickerController();
  @override
  void initState() {
    super.initState();
    selectedDayStart = DateTime.now();
    selectedStartTime = null;
    selectedEndTime = null;
  }

  @override
  void dispose() {
    selectedStartTime = null;
    selectedEndTime = null;
    selectedDayStart = null;
    selectedDayEnd = null;
    selectedAdres = null;
    selectedPet = null;
    super.dispose();
  }

  String getStartDate() {
    var selectedStart = DateFormat("dd-MM-yyyy  HH:mm").format(selectedDayStart!);
    return selectedStart;
  }

  String getEndDate() {
    var selectedEnd = DateFormat("dd-MM-yyyy  HH:mm").format(selectedDayEnd!);

    return selectedEnd.toString();
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
          actions: const [],
          toolbarHeight: 60,
          title: const AdvertizeSelector(),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              )),
          backgroundColor: applicationOrange,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      if (listCounter == 2 || listCounter == 3) {
                        return const Column(
                          children: [
                            PetCaller(),
                            SizedBox(
                              height: 30,
                            ),
                            AdressCaller(),
                          ],
                        );
                      } else {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("pets")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("Köpek")
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> dogSnapshot) {
                            if (dogSnapshot.connectionState == ConnectionState.waiting) {
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
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Row(
                                              children: [
                                                PetCard(petSnapshot: dogSnapshot),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const AdressCaller()
                                ],
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Takvim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 75,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HorizontalDatePickerWidget(
                        normalTextColor: applicationPurple,
                        selectedTextColor: applicationOrange,
                        normalColor: Colors.grey.shade200,
                        selectedColor: applicationPurple,
                        disabledColor: Colors.grey.shade200,
                        disabledTextColor: Colors.black38,
                        locale: 'tr_TR',
                        startDate: DateTime.now(),
                        endDate: DateTime.now().add(const Duration(days: 7)),
                        selectedDate: selectedDayStart!,
                        widgetWidth: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        datePickerController: _datePickerController,
                        onValueSelected: (date) {
                          setState(() {
                            selectedDayStart = date;
                            selectedDayEnd = date;
                            selectedStartTime = null;
                            selectedEndTime = null;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Saat",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectedDayStart == null) {
                        showIOSAlert(context, const Text("Lütfen tarih seçiniz"));
                      } else {
                        showCupertinoModalPopup(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: applicationPurple.withAlpha(50),
                                    ),
                                    height: 150,
                                    width: 150,
                                    child: const TimePickerStart(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedDayStart;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: applicationPurple,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Seç",
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Başlangıç zamanı seç",
                            style: TextStyle(fontSize: 20, color: applicationPurple),
                          ),
                          Builder(
                            builder: (context) {
                              if (selectedStartTime == null) {
                                return const Text("");
                              } else {
                                return Text(
                                  getStartDate(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: applicationPurple),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectedStartTime == null) {
                        showIOSAlert(context, const Text("Lütfen başlangıç saati seçiniz"));
                      } else {
                        showCupertinoModalPopup(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: applicationPurple.withAlpha(50),
                                    ),
                                    height: 150,
                                    width: 150,
                                    child: const TimePickerEnd(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedDayEnd;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: applicationPurple,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Seç",
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bitiş zamanı seç ",
                            style: TextStyle(fontSize: 20, color: applicationPurple),
                          ),
                          Builder(
                            builder: (context) {
                              if (selectedEndTime == null) {
                                return const Text("");
                              } else {
                                return Text(
                                  getEndDate(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: applicationPurple),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Fiyat",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BudgetWidgetDaily(max: 200, min: 100),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () async {
                        if (selectedDayStart == null || selectedDayEnd == null) {
                          showIOSAlert(context, const Text("Başlangıç ve Bitiş zamanı seçiniz"));
                        } else if (selectedPet == null || selectedAdres == null) {
                          showIOSAlert(context, const Text("Lütfen adresinizi ve dostunuzu seçin"));
                        } else if (selectedDayStart!.isBefore(selectedDayEnd!)) {
                          final data = FirebaseFirestore.instance
                              .collection("advertize")
                              .doc(FirebaseAuth.instance.currentUser!.uid);
                          if (listCounter == 2) {
                            await data.collection("Daily on Pet Owner House").doc().set({
                              "Adres": selectedAdres,
                              "Pet": selectedPet,
                              "Time-Start": selectedDayStart,
                              "Time-End": selectedDayEnd,
                              "ID": data.id
                            });
                          } else if (listCounter == 3) {
                            await data.collection("Daily on Hosts House").doc().set({
                              "Adres": selectedAdres,
                              "Pet": selectedPet,
                              "Time-Start": selectedDayStart,
                              "Time-End": selectedDayEnd,
                              "ID": data.id
                            });
                          } else if (listCounter == 4) {
                            await data.collection("Dog Walking").doc().set({
                              "Adres": selectedAdres,
                              "Pet": selectedPet,
                              "Time-Start": selectedDayStart,
                              "Time-End": selectedDayEnd,
                              "ID": data.id
                            });
                          }
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoDialogRoute(
                                  builder: (context) => const MainPage(), context: context),
                              (route) => false);
                        } else {
                          showIOSAlert(
                              context, const Text("Bitiş saati, başlangıç saaatinden önce olamaz"));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: applicationOrange,
                        ),
                        child: const Center(
                          child: Text(
                            "İlan ver",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimePickerStart extends StatefulWidget {
  const TimePickerStart({Key? key}) : super(key: key);

  @override
  _TimePickerStartState createState() => _TimePickerStartState();
}

class _TimePickerStartState extends State<TimePickerStart> {
  @override
  void initState() {
    super.initState();
    // set the initial date to the current date and time
    setState(() {
      selectedStartTime = DateTime.now().add(Duration(minutes: 15 - DateTime.now().minute % 15));
      selectedDayStart = DateTime(selectedDayStart!.year, selectedDayStart!.month,
          selectedDayStart!.day, selectedStartTime!.hour, selectedStartTime!.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      minimumDate: DateTime.now().subtract(const Duration(minutes: 1)),
      initialDateTime: selectedDayStart,
      minuteInterval: 15,
      use24hFormat: true,
      onDateTimeChanged: (DateTime newDateTime) {
        setState(() {
          selectedStartTime = newDateTime;
          selectedDayStart = DateTime(selectedDayStart!.year, selectedDayStart!.month,
              selectedDayStart!.day, selectedStartTime!.hour, selectedStartTime!.minute);
        });
      },
    );
  }
}

class TimePickerEnd extends StatefulWidget {
  const TimePickerEnd({Key? key}) : super(key: key);

  @override
  _TimePickerEndState createState() => _TimePickerEndState();
}

class _TimePickerEndState extends State<TimePickerEnd> {
  @override
  void initState() {
    super.initState();
    // set the initial date to the current date and time
    setState(() {
      selectedEndTime =
          selectedDayStart?.add(Duration(hours: 1, minutes: 15 - selectedDayStart!.minute % 15));
      selectedDayEnd =
          selectedDayStart?.add(Duration(hours: 1, minutes: 15 - selectedDayStart!.minute % 15));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      minimumDate: selectedDayStart!.add(const Duration(hours: 1)),
      initialDateTime:
          selectedDayStart!.add(Duration(hours: 1, minutes: 15 - selectedDayStart!.minute % 15)),
      minuteInterval: 15,
      use24hFormat: true,
      onDateTimeChanged: (DateTime newDateTime) {
        setState(() {
          selectedEndTime = newDateTime;
          selectedDayEnd = DateTime(selectedDayEnd!.year, selectedDayEnd!.month,
              selectedDayEnd!.day, selectedEndTime!.hour, selectedEndTime!.minute);
        });
      },
    );
  }
}

class BudgetWidgetDaily extends StatefulWidget {
  const BudgetWidgetDaily({super.key, @required this.max, @required this.min});

  final int? max;
  final int? min;

  @override
  State<BudgetWidgetDaily> createState() => _BudgetWidgetDailyState();
}

class _BudgetWidgetDailyState extends State<BudgetWidgetDaily> {
  int? max;
  int? min;

  @override
  void initState() {
    price = 150;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Text(
                  "Fiyatı saatlik ${widget.min}₺ \n${widget.max}₺ arasında \nbelirleyebilirsiniz",
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
                style: const TextStyle(fontSize: 30),
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
          ),
        ],
      ),
    );
  }
}
