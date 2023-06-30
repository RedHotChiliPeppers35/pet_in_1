import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/check_state.dart';
import 'package:firebase_core/firebase_core.dart';

Color applicationPurple = const Color(0XFF7765E3);
Color applicationOrange = const Color(0XFFFC7753);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setLanguageCode("tr");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
            toolbarHeight: 75,
            elevation: 0,
            titleTextStyle:
                TextStyle(fontSize: 25, fontFamily: "Quicksand", fontWeight: FontWeight.bold),
          ),
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: applicationOrange, cursorColor: Colors.white),
          fontFamily: "Quicksand",
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 20),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0XFF7765E3),
            secondary: const Color(0XFFFC7753),
          ),
        ),
        home: const CheckState());
  }
}
