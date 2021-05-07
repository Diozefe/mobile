import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobclinic/models/contacts.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameControler = TextEditingController();

  final TextEditingController _accountNumerConttroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _nameControler,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                ),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumerConttroller,
                decoration: InputDecoration(
                  labelText: 'Número da conta',
                ),
                style: TextStyle(fontSize: 20.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _nameControler.text;
                    final int accountNumber =
                        int.tryParse(_accountNumerConttroller.text);
                    final Contact newContact = Contact(0, name, accountNumber);
                    Navigator.pop(context, newContact);
                  },
                  child: Text('Criar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
