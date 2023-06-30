import 'package:flutter/material.dart';

bool notificationExists = false;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Bildirimlerim"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: Builder(
                  builder: (context) {
                    if (notificationExists == true) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return null;
                        },
                      );
                    } else {
                      return const Column(
                        children: [
                          Icon(
                            Icons.notifications_off,
                            size: 30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Henüz bildirimin yok",
                          ),
                        ],
                      );
                    }
                  },
                ))
          ],
        ),
      )),
    );
  }
}
