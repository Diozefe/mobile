import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobclinic/models/contacts.dart';
import 'package:mobclinic/models/transaction.dart';

const String baseUrl = 'http://192.168.2.141:8080/transactions';
final client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

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
  final res = await client
      .get(
        Uri.parse(baseUrl),
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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJSON = jsonEncode(transactionMap);
  final res = await client
      .post(Uri.parse(baseUrl),
          headers: {
            'Content-type': 'application/json',
            'password': '1000',
          },
          body: transactionJSON)
      .timeout(Duration(seconds: 5));

  Map<String, dynamic> json = jsonDecode(res.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
