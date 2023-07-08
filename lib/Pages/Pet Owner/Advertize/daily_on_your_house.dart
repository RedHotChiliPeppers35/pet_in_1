import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/nightly_filter_page.dart';
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

class DailyOnYourHouse extends StatefulWidget {
  const DailyOnYourHouse({super.key});

  @override
  State<DailyOnYourHouse> createState() => _DailyOnYourHouseState();
}

class _DailyOnYourHouseState extends State<DailyOnYourHouse> {
  final DatePickerController _datePickerController = DatePickerController();
  @override
  void initState() {
    super.initState();
    selectedDayStart = DateTime.now();
    selectedStartTime = null;
    selectedEndTime = null;
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: PlaceSelectorLogic(),
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
                              builder:
                                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 75,
                  width: 300,
                  child: HorizontalDatePickerWidget(
                    normalTextColor: applicationPurple,
                    selectedTextColor: applicationOrange,
                    normalColor: Colors.white,
                    selectedColor: applicationPurple,
                    disabledColor: Colors.white,
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
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: applicationPurple),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Başlangıç zamanı seç",
                          style: TextStyle(fontSize: 20, color: applicationOrange),
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
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: applicationPurple),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bitiş zamanı seç ",
                          style: TextStyle(fontSize: 20, color: applicationOrange),
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
                TextButton(
                    onPressed: () async {
                      if (selectedDayStart == null || selectedDayEnd == null) {
                        showIOSAlert(context, const Text("Başlangıç ve Bitiş zamanı seçiniz"));
                      } else if (selectedDayStart!.isBefore(selectedDayEnd!)) {
                        print(selectedDayStart);
                        print(selectedDayEnd);
                        print("Daily Care");
                        final data = FirebaseFirestore.instance
                            .collection("advertize")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("advertizement")
                            .doc();

                        await data.set({
                          "Adres": selectedAdres,
                          "Pet": selectedPet,
                          "Time-Start": selectedDayStart,
                          "Time-End": selectedDayEnd,
                          "ID": data.id
                        });
                        Navigator.pop(context);
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
                          "Filtrele",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ))
              ],
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
