import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/daily_care_filter_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/nightly_filter_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'first_filter_page.dart';

class OzelFilterPage extends StatefulWidget {
  const OzelFilterPage({super.key});

  @override
  State<OzelFilterPage> createState() => _OzelFilterPageState();
}

class _OzelFilterPageState extends State<OzelFilterPage> {
  final DatePickerController _datePickerController = DatePickerController();

  @override
  void initState() {
    super.initState();
    selectedDayStart = DateTime.now();
    selectedStartTime = null;
  }

  String getStartDate() {
    var selectedStart = DateFormat("dd-MM-yyyy  HH:mm").format(selectedDayStart!);
    return selectedStart;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                        child: Text(
                      searchController.text.toString(),
                      style: const TextStyle(fontSize: 25),
                    )),
                    const SizedBox(height: 20),
                    const Center(child: PlaceSelectorLogic()),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 75,
                  width: 350,
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
                          "Rezervasyon zamanı seç",
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
                TextButton(
                    onPressed: () {
                      if (_datePickerController.selectedDate == null || selectedStartTime == null) {
                        if (Platform.isIOS) {
                          showIOSAlert(context, const Text("Lütfen rezervasyon saati seçiniz"));
                        } else {
                          showAndroidAlert(context, const Text("Lütfen rezervasyon saati seçiniz"));
                        }
                      } else if (listCounter == 4) {
                        print(selectedDayStart);
                        debugPrint("Coiffeur");
                      } else if (listCounter == 5) {
                        print(selectedDayStart);
                        debugPrint("Education");
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
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
