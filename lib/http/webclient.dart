import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobclinic/models/contacts.dart';
import 'package:mobclinic/models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final res = await client
      .get(
        Uri.parse('http://192.168.2.141:8080/transactions'),
      )
      .timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(res.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}
