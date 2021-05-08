import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging.dart';

const String baseUrl = 'http://192.168.2.141:8080/transactions';
final client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
