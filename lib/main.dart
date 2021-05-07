import 'package:flutter/material.dart';
import 'package:mobclinic/screens/dashboard/dashboard.dart';

void main() {
  runApp(SlackApp());
}

class SlackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        accentColor: Colors.blue[300],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: Dashboard(),
    );
  }
}
