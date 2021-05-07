import 'package:flutter/material.dart';
import 'package:mobclinic/screens/transferencia/lista.dart';

void main() => runApp(MobClinic());

class MobClinic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        primaryColor: Colors.purple[400],
        accentColor: Colors.purpleAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purpleAccent[600],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}
