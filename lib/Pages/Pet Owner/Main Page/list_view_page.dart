import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/personal_info_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/Filter%20Pages/first_filter_page.dart';
import 'package:flutter_application_1/main.dart';

TextEditingController searchController = TextEditingController();
MaterialStatesController bakiciController = MaterialStatesController();
String? imageURL;
bool isLoading = false;

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    getFirstName();
    getPhoto();
    super.initState();
  }

  Future getFirstName() async {
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);

    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        userFirstName = data["First Name"];
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );
    setState(() {
      userFirstName;
    });
  }

  Future getPhoto() async {
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        imageURL = data["Profile picture"];
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );
    setState(() {
      imageURL;
    });
  }

  Widget petWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 200,
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Image(image: AssetImage("images/petinone.png")),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Ata Çinetçi",
                    style:
                        TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 15,
                          ),
                          Text(
                            "Gecelik Bakım",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 15,
                          ),
                          Text(
                            "Gün içi Bakım",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: applicationPurple.withAlpha(50),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 120,
                    child: const Text(
                      "2 Yıllık tecrübeli köpek bakıcısıyım. Dostlarımızı asla aynı odaya koymuyorum.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fiyatları gör",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: applicationOrange,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final Stream _stream = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return WillPopScope(
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      automaticallyImplyLeading: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      toolbarHeight: 100,
                      leadingWidth: 8,
                      centerTitle: false,
                      title: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "Hoşgeldin $userFirstName",
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 180,
                                  child: TextField(
                                    style: const TextStyle(
                                      fontSize: 14,
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
                                    keyboardType: TextInputType.streetAddress,
                                    textAlign: TextAlign.start,
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        alignment: Alignment.topCenter,
                                        onPressed: () {
                                          showSearch(
                                            context: context,
                                            delegate: CitySearch(controller: searchController),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.location_on,
                                          size: 20,
                                        ),
                                      ),
                                      hintText: "Şehir ara",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => const FirstFilterPage(),
                                          ));
                                    },
                                    icon: const Icon(Icons.filter_list))
                              ],
                            )
                          ],
                        ),
                      ),
                      actions: [
                        StreamBuilder(
                            stream: _stream,
                            builder: (context, snapshot) {
                              return TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const PersonalInformationPage(),
                                    )),
                                child: Builder(
                                  builder: (context) {
                                    if (imageURL != null) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(imageURL!),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 2, color: applicationOrange)),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            size: 60,
                                            color: applicationOrange,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                  body: Center(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return petWidget();
                      },
                    ),
                  ),
                ),
              );
            }));
  }
}
