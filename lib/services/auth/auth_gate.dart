import 'package:flutter/material.dart';
import 'package:instamessenger/services/auth/login_page.dart';
import 'package:instamessenger/services/auth/signup_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool isLogin = true;

  void toggelPage(){
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(isLogin){
      return LoginPage(signup: toggelPage);
    }
    return SignUpPage(login: toggelPage);
  }
}