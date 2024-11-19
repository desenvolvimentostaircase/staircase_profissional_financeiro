import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login/Home/home_page.dart';
import 'Login/login_page.dart';
import 'firebase_analytics_registro_login.dart';


class ChecagemPage extends StatefulWidget {
  const ChecagemPage({Key? key}) : super(key: key);

  @override
  State<ChecagemPage> createState() => _ChecagemPageState();
}

class _ChecagemPageState extends State<ChecagemPage> {
  //
  StreamSubscription? streamSubscription;

  //
  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          //Ir para o Login Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else {
          //Ir para a Home Page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          //Resgistro de evento de login
          logLoginEvent();
        }
      },
    );
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  
}
