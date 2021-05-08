import 'package:http/src/response.dart';
import 'package:mobclinic/http/webclient.dart';
import 'package:mobclinic/models/contacts.dart';
import 'package:mobclinic/models/transaction.dart';
import 'dart:convert';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final res = await client
        .get(
          Uri.parse(baseUrl),
        )
        .timeout(Duration(seconds: 5));
    return _toTransactions(res);
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJSON = jsonEncode(transaction.toJson());
    final res = await client
        .post(Uri.parse(baseUrl),
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJSON)
        .timeout(Duration(seconds: 5));

    return _toTransaction(res);
  }

  List<Transaction> _toTransactions(Response res) {
    final List<dynamic> decodedJson = jsonDecode(res.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _toTransaction(Response res) {
    Map<String, dynamic> json = jsonDecode(res.body);
    return Transaction.fromJson(json);
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    return transactionMap;
  }
}
