import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/daily_walking.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/nightly_filter_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/special_filter_page.dart';

import 'daily_care_filter_page.dart';

List index = [0, 1, 2, 3, 4, 5];
int listCounter = 0;

class FirstFilterPage extends StatefulWidget {
  const FirstFilterPage({super.key});

  @override
  State<FirstFilterPage> createState() => _FirstFilterPageState();
}

class _FirstFilterPageState extends State<FirstFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Hizmet Seç",
          style: TextStyle(color: Colors.black87, fontSize: 25),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.start,
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CitySearch(controller: searchController),
                      );
                    },
                    icon: const Icon(Icons.location_on),
                  ),
                  hintText: "Şehir ara",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                readOnly: true,
                textAlignVertical: TextAlignVertical.bottom,
                textCapitalization: TextCapitalization.words,
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CitySearch(controller: searchController),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Hizmetler",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Gecelik",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          TextButton(
                              statesController: bakiciController,
                              onPressed: () {
                                if (searchController.text.toString() != "") {
                                  listCounter = index[0];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const NightlyFilterPage(),
                                      ));
                                } else {
                                  if (Platform.isIOS) {
                                    showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                  } else {
                                    showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                  }
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bakıcı evinde konaklama",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Bakıcı evcil hayvanlarınızı misafir edecek.",
                                    style: TextStyle(fontSize: 12, color: Colors.black45),
                                  ),
                                ],
                              )),
                          const Divider(
                            height: 20,
                            color: Colors.black,
                          ),
                          TextButton(
                            onPressed: () {
                              if (searchController.text.toString() != "") {
                                listCounter = index[1];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NightlyFilterPage(),
                                    ));
                              } else {
                                if (Platform.isIOS) {
                                  showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                } else {
                                  showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                }
                              }
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kendi evinde konaklama",
                                  style: TextStyle(fontSize: 17, color: Colors.black87),
                                ),
                                Text(
                                  "Bakıcı evcil hayvanınızla sizin evinizde ilgilenecek.",
                                  style: TextStyle(fontSize: 12, color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Gün içi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                          ),
                          TextButton(
                              statesController: bakiciController,
                              onPressed: () {
                                if (searchController.text.toString() != "") {
                                  listCounter = index[2];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DailyCareFilterPage(),
                                      ));
                                } else {
                                  if (Platform.isIOS) {
                                    showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                  } else {
                                    showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                  }
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gün içi bakım",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Bakıcı belirlediğiniz saatlerde evcil hayvanınızı misafir edecek. ",
                                    style: TextStyle(fontSize: 12, color: Colors.black45),
                                  ),
                                ],
                              )),
                          const Divider(
                            height: 20,
                            color: Colors.black,
                          ),
                          TextButton(
                              statesController: bakiciController,
                              onPressed: () {
                                if (searchController.text.toString() != "") {
                                  listCounter = index[3];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DailyWalkingPage(),
                                      ));
                                } else {
                                  if (Platform.isIOS) {
                                    showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                  } else {
                                    showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                  }
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Köpek gezdirme",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Bakıcı belirlediğiniz saatlerde köpeğinizi yürüyüşe çıkartacak.",
                                    style: TextStyle(fontSize: 12, color: Colors.black45),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Özel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                          ),
                          TextButton(
                              statesController: bakiciController,
                              onPressed: () {
                                if (searchController.text.toString() != "") {
                                  listCounter = index[4];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OzelFilterPage(),
                                      ));
                                } else {
                                  if (Platform.isIOS) {
                                    showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                  } else {
                                    showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                  }
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pet Kuaför",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Evcil hayvanınız için tüy bakımı yaptırın.",
                                    style: TextStyle(fontSize: 12, color: Colors.black45),
                                  ),
                                ],
                              )),
                          const Divider(
                            height: 20,
                            color: Colors.black,
                          ),
                          TextButton(
                              statesController: bakiciController,
                              onPressed: () {
                                if (searchController.text.toString() != "") {
                                  listCounter = index[5];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OzelFilterPage(),
                                      ));
                                } else {
                                  if (Platform.isIOS) {
                                    showIOSAlert(context, const Text("Lütfen şehir seçiniz"));
                                  } else {
                                    showAndroidAlert(context, const Text("Lütfen şehir seçiniz"));
                                  }
                                }
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Köpek eğitimi",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Köpeğiniz için itaat eğitimi satın alın.",
                                    style: TextStyle(fontSize: 12, color: Colors.black45),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
