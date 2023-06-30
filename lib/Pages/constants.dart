import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:string_extensions/string_extensions.dart';

String userFirstName = "";
String userLastName = "";
String userEmail = "";
String userPhone = "";
String userPassword = "";

User firebaseUser = FirebaseAuth.instance.currentUser!;

Future getFirstName() async {
  final docRef = FirebaseFirestore.instance.collection(firebaseUser.uid).doc("User Info");

  await docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      userFirstName = data["First Name"];
    },
    onError: (e) => debugPrint("Error getting document: $e"),
  );
}

void showIOSAlert(BuildContext context, Text myContent) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text("HATA"),
      content: myContent,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Geri dön'),
        ),
      ],
    ),
  );
}

void showAndroidAlert(BuildContext context, Text myContent) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("HATA"),
        content: myContent,
        //buttons?
        actions: <Widget>[
          TextButton(
            child: const Text("Geri dön"),
            onPressed: () {
              Navigator.of(context).pop();
            }, //closes popup
          ),
        ],
      );
    },
  );
}

//RESPECT!!!
class GetUserFirstName extends StatelessWidget {
  GetUserFirstName({super.key});

  final CollectionReference ref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: ref.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> myData = snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "Hoşgeldin ${myData["First Name"]}".toTitleCase!,
            style: const TextStyle(fontSize: 17),
          );
        }
        return const Text("");
      },
    );
  }
}

class CitySearch extends SearchDelegate {
  @override
  String get searchFieldLabel => "Şehir ara";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white, fontSize: 20);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        color: applicationPurple,
        elevation: 0,
        //toolbarTextStyle: , to change toolbar text style
      ),
      hintColor: Colors.white,
    );
  }

  TextEditingController controller;
  CitySearch({required this.controller});

  List<String> turkeyCities = [
    "İstanbul",
    "İzmir",
    "Ankara",
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkâri",
    "Hatay",
    "Iğdır",
    "Isparta",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kilis",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == "") {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? turkeyCities
        : turkeyCities
            .where((element) => element.toLowerCase().contains(query) || element.contains(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        String sugText = suggestionList[index];
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          onTap: () {
            controller.text = sugText;
            close(context, null);
          },
        );
      },
    );
  }
}
