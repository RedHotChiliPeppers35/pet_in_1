import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/daily/daily_advertize.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Advertize/nightly/nightly_advertize.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';

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
          child: Column(
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
                              Navigator.push(context, CupertinoPageRoute(
                                builder: (context) {
                                  return const NightlyAdvertize();
                                },
                              ));

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
                            Navigator.push(context, CupertinoPageRoute(
                              builder: (context) {
                                return const NightlyAdvertize();
                              },
                            ));
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
                              print(listCounter);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return const DailyAdvertize();
                                  },
                                ),
                              );
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
                                    return const DailyAdvertize();
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
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return const DailyAdvertize();
                                  },
                                ),
                              );
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
                          "Çok Yakında",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black26),
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
                                  style: TextStyle(fontSize: 17, color: Colors.black26),
                                ),
                                Text(
                                  "Evcil hayvanınız için tüy bakımı yaptırın.",
                                  style: TextStyle(fontSize: 12, color: Colors.black26),
                                ),
                              ],
                            )),
                        const Divider(
                          height: 20,
                          color: Colors.black26,
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
                                  style: TextStyle(fontSize: 17, color: Colors.black26),
                                ),
                                Text(
                                  "Köpeğiniz için itaat eğitimi satın alın.",
                                  style: TextStyle(fontSize: 12, color: Colors.black26),
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
        ),
      )),
    );
  }
}

class AdvertizeSelector extends StatelessWidget {
  const AdvertizeSelector({super.key});

  final TextStyle myStyle =
      const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    if (listCounter == 0) {
      return Text("Bakıcı evinde konaklama", style: myStyle);
    } else if (listCounter == 1) {
      return Text("Kendi evinde konaklama", style: myStyle);
    } else if (listCounter == 2) {
      return Text(
        "Gün içi bakım (Kendi Evimde)",
        style: myStyle,
      );
    } else if (listCounter == 3) {
      return Text("Gün içi bakım (Bakıcı Evinde)", style: myStyle);
    } else if (listCounter == 4) {
      return Text("Köpek gezdirme", style: myStyle);
    } else if (listCounter == 5) {
      return Text("Pet Kuaför", style: myStyle);
    } else if (listCounter == 6) {
      return Text(
        "Köpek Eğitimi",
        style: myStyle,
      );
    } else {
      return const SelectTypeOfAdvertize();
    }
  }
}
