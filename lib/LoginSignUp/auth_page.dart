import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginSignUp/login_page.dart';
import 'package:flutter_application_1/LoginSignUp/sign_up_page.dart.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

bool showLoginPage = true;


void toggleScreen() {
setState(() {
  showLoginPage = !showLoginPage;
});


}
  @override
  Widget build(BuildContext context) {
  if(showLoginPage){
    return LoginPage(showRegisterPage: toggleScreen);
  }else{
    return SignUpPage(showLoginPage: toggleScreen,);
  } 
  }
}