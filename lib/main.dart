import 'package:client/screens/affectInternPage.dart';
import 'package:client/screens/instituteScreen.dart';
import 'package:client/screens/loginScreen.dart';
import 'package:client/screens/supervisorPage.dart';
import 'package:flutter/material.dart';
import 'screens/homePage.dart';

void main() async {
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homePage',
      routes: {
        '/': (context) => loginScreen(),
        '/homePage': (context) => homePage(),
        '/supervisorPage': (context) => supervisorPage(),
        '/institute': (context) => instituteScreen(),
        '/affectInternScreen': (context) => affectInternScreen(),
      },
    );
  }
}
