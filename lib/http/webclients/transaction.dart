import 'package:flutter/cupertino.dart';
import 'package:http/src/response.dart';
import 'package:mobclinic/http/webclient.dart';
import 'package:mobclinic/models/transaction.dart';
import 'dart:convert';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final res = await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(res.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(
    Transaction transaction,
    String password,
    BuildContext context,
  ) async {
    final String transactionJSON = jsonEncode(transaction.toJson());
    final res = await client
        .post(baseUrl,
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJSON)
        .timeout(Duration(seconds: 5));

    return Transaction.fromJson(jsonDecode(res.body));
  }

  List<Transaction> _toTransactions(Response res) {}
}
