import "package:flutter/material.dart";
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/account_and_security.dart';
import "package:flutter_application_1/Pages/Pet%20Sitter/sitter_list.dart";
import "package:flutter_application_1/main.dart";
import "../Pet Owner/Notification Page/notification_page.dart";

class PetSitterMainPage extends StatefulWidget {
  const PetSitterMainPage({super.key});

  @override
  State<PetSitterMainPage> createState() => _PetSitterMainPageState();
}

class _PetSitterMainPageState extends State<PetSitterMainPage> {
  final List<Widget> _screens = [
    const NotificationPage(),
    const PetSitterListPage(),
    const ProfilePage()
  ];

  int selectedNavIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedNavIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Colors.transparent,
          child: BottomNavigationBar(
            showSelectedLabels: true,
            selectedItemColor: applicationOrange,
            unselectedItemColor: Colors.white,
            onTap: (i) {
              setState(() {
                selectedNavIndex = i;
              });
            },
            currentIndex: selectedNavIndex,
            backgroundColor: applicationPurple,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  backgroundColor: applicationPurple,
                  icon: const Icon(Icons.notifications),
                  label: 'Bildirimler'),
              BottomNavigationBarItem(
                  backgroundColor: applicationPurple,
                  icon: const Icon(Icons.home),
                  label: 'Ana sayfa'),
              BottomNavigationBarItem(
                  backgroundColor: applicationPurple,
                  icon: const Icon(Icons.person),
                  label: 'Profilim'),
            ],
          ),
        ),
      ),
    );
  }
}
