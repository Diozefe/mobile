import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

void findAll() async {
  final client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final res = await client.get(
    Uri.parse('http://192.168.1.119:8080/transactions'),
  );
}
