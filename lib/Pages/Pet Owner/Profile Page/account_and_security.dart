import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/check_state.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/adress._page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/personal_info_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/pets.dart';
import 'package:flutter_application_1/Pages/Pet%20Sitter/sitter_main.dart';
import '../../../main.dart';
import '../main_page.dart';

bool isSitterActive = false;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextStyle myStyle = const TextStyle(color: Colors.white, fontSize: 17);
  TextStyle myHeader =
      TextStyle(fontSize: 25, color: applicationOrange, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Hesap ve Güvenlik",
              ),
              centerTitle: true,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
              toolbarHeight: 75,
              leadingWidth: 8,
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Hesap", style: myHeader),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: applicationPurple),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const PersonalInformationPage(),
                            )),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Kişisel bilgiler",
                              style: myStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: applicationPurple),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const PetsPage(),
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.pets,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Dostlar", style: myStyle),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: applicationPurple),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const AdressPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Adres Bilgileri", style: myStyle),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Divider(
                        color: Colors.black54,
                      ),
                    ),
                    Text("Güvenlik", style: myHeader),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: applicationPurple),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.system_security_update_warning,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Yasal Bilgilendirme", style: myStyle),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: applicationPurple),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("İstek ve Şikayet", style: myStyle),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Divider(
                        color: Colors.black54,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (isSitterActive == false) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), color: applicationOrange),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    CupertinoModalPopupRoute(builder: (context) {
                                  return const PetSitterMainPage();
                                }), (route) => false);
                                setState(() {
                                  isSitterActive = true;
                                });
                              },
                              child: Text("Bakıcı Moduna Geç", style: myStyle),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), color: applicationOrange),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(
                                  builder: (context) {
                                    return const MainPage();
                                  },
                                ), (route) => false);
                                setState(() {
                                  isSitterActive = false;
                                });
                              },
                              child: Text("Dost Sahibi Moduna Geç", style: myStyle),
                            ),
                          );
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Divider(
                        color: Colors.black54,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(
                            builder: (context) {
                              return const CheckState();
                            },
                          ), (route) => false);
                        });
                      },
                      child: Text("Çıkış Yap", style: myHeader),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
