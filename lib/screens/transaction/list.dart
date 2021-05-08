import 'package:flutter/material.dart';
import 'package:mobclinic/components/centered_message.dart';
import 'package:mobclinic/components/progress.dart';
import 'package:mobclinic/http/webclient.dart';
import 'package:mobclinic/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transaction> transactions = snapshot.data;
              if (snapshot.hasData) {
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
                return CenteredMessage(
                  'No Transactions found',
                  icon: Icons.warning,
                );
              }
              return CenteredMessage(
                'No Transactions found',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage(
            'Erro desconhecido',
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}
