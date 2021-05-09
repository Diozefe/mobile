import 'dart:async';
import 'package:mobclinic/components/progress.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:mobclinic/components/response_dialog.dart';
import 'package:mobclinic/components/transaction_auth.dart';
import 'package:mobclinic/http/webclients/transaction.dart';
import 'package:mobclinic/models/contacts.dart';
import 'package:mobclinic/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebclient _webclient = TransactionWebclient();
  final String transactionId = Uuid().v4();

  bool _seding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Progress(
                  message: 'Sending...',
                ),
                visible: _seding,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact, transactionId);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (password) async {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction =
        await _send(transactionCreated, password, context);

    _sucessfulMessage(transaction, context);
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _seding = true;
    });
    Transaction transaction = await _webclient
        .save(transactionCreated, password, context)
        .catchError((e) => _showFailedMessage(context, message: e.message),
            test: (e) => e is HttpException)
        .catchError((e) => _showFailedMessage(context, message: e.message),
            test: (e) => e is TimeoutException)
        .catchError((e) => _showFailedMessage(context),
            test: (e) => e is Exception)
        .whenComplete(() {
      setState(() {
        _seding = false;
      });
    });
    return transaction;
  }

  void _sucessfulMessage(Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (context) {
            return SuccessDialog('Sucessful Transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _showFailedMessage(
    BuildContext context, {
    String message = 'Unknow Error',
  }) async =>
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(message);
          });
}
