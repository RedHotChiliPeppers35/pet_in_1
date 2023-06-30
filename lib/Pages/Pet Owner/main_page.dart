import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Notification%20Page/notification_page.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Profile%20Page/account_and_security.dart';
import 'package:flutter_application_1/main.dart';

import 'Advertize/advertize.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //navigation bar homepage index

  int selectedNavIndex = 2;

  final user = FirebaseAuth.instance.currentUser;

  // Screens
  final List<Widget> _screens = [
    const NotificationPage(),
    const AdvertizePage(),
    const AnaSayfa(),
    const ProfilePage(),
  ];

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
                  icon: const Icon(Icons.add_circle),
                  label: 'İlanlarım'),
              BottomNavigationBarItem(
                  backgroundColor: applicationPurple,
                  icon: const Icon(Icons.pets),
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
