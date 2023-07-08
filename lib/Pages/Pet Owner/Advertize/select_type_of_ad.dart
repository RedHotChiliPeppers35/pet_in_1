import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/daily_on_your_house.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/daily_walking.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/special_filter_page.dart';

int listCounter = 0;

class SelectTypeOfAdvertize extends StatefulWidget {
  const SelectTypeOfAdvertize({super.key});

  @override
  State<SelectTypeOfAdvertize> createState() => _SelectTypeOfAdvertizeState();
}

class _SelectTypeOfAdvertizeState extends State<SelectTypeOfAdvertize> {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                                listCounter = 0;

                                // move for nightly adveritize page
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
                              listCounter = 1;
                              // move for second nightly advertize page
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
                                listCounter = 2;
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gün içi bakım (Kendi Evimde)",
                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Bakıcı belirlediğiniz saatlerde evcil hayvanınıza sizin evinizde eşlik edecek. ",
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
                                listCounter = 3;
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) {
                                      return DailyOnYourHouse();
                                    },
                                  ),
                                );
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gün içi bakım (Bakıcı Evinde)",
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
                                listCounter = 4;
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
                                listCounter = 4;
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
                                listCounter = 5;
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
