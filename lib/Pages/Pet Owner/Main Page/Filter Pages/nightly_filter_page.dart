import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/main_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/main.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'first_filter_page.dart';

class NightlyFilterPage extends StatefulWidget {
  const NightlyFilterPage({super.key});

  @override
  State<NightlyFilterPage> createState() => _NightlyFilterPageState();
}

class _NightlyFilterPageState extends State<NightlyFilterPage> {
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
                TextButton(
                    onPressed: () {
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
                      } else if (listCounter == 0) {
                        debugPrint("Bakıcı evinde konaklama");
                        print(start);
                        print(end);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                      } else if (listCounter == 1) {
                        debugPrint("Kendi evinde konaklama");
                        print(start);
                        print(end);
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
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceSelectorLogic extends StatelessWidget {
  const PlaceSelectorLogic({super.key});

  @override
  Widget build(BuildContext context) {
    if (listCounter == 0) {
      return const Text(
        "Bakıcı evinde konaklama",
        style: TextStyle(fontSize: 17),
      );
    } else if (listCounter == 1) {
      return const Text(
        "Kendi evinde konaklama",
        style: TextStyle(fontSize: 17),
      );
    } else if (listCounter == 2) {
      return const Text(
        "Gün içi bakım",
        style: TextStyle(fontSize: 17),
      );
    } else if (listCounter == 3) {
      return const Text(
        "Köpek gezdirme",
        style: TextStyle(fontSize: 17),
      );
    } else if (listCounter == 4) {
      return const Text(
        "Pet Kuaför",
        style: TextStyle(fontSize: 17),
      );
    } else if (listCounter == 5) {
      return const Text(
        "Köpek Eğitimi",
        style: TextStyle(fontSize: 17),
      );
    } else {
      return const FirstFilterPage();
    }
  }
}
