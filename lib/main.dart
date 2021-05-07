import 'package:flutter/material.dart';
import 'package:mobclinic/database/app.dart';
import 'package:mobclinic/models/contacts.dart';
import 'package:mobclinic/screens/dashboard/dashboard.dart';

void main() {
  runApp(SlackApp());
  save(Contact(1, 'Diozefe', 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
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
