import 'dart:ffi';

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

    final res = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJSON);

    if (res.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(res.body));
    }

    HttpException(_getMessage(res.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusHttpResponses.containsKey(statusCode)) {
      return _statusHttpResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusHttpResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    409: 'Transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
