import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging.dart';

final Uri baseUrl = Uri.parse('http://192.168.1.119:8080/transactions');
final client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 5));
