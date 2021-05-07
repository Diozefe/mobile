import 'package:flutter/material.dart';

void main() => runApp(SlackApp());

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

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/logo-slack.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 80,
              width: 130,
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  Text(
                    'Contatos',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
