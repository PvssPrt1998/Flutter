import 'package:flutter/material.dart';
import 'ATMPage.dart';
import 'package:atm/Model/ATM.dart';

class ATMApp extends StatelessWidget {
  const ATMApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'ATM',
      theme: theme.copyWith(
        scaffoldBackgroundColor: Colors.white
      ),
      home: ATMPage()
    );
  }
}