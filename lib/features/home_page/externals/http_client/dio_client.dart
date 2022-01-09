import 'package:app_food/features/home_page/externals/http_client/my_client_http.dart';
import 'package:dio/dio.dart';

class DioClient implements MyClientHttp<Dio> {
  @override
  final Dio client;

  const DioClient(this.client);

  @override
  Future<dynamic> get({required String url}) async {
    client.options.baseUrl = 'http://localhost:3021';
    client.options.connectTimeout = 5000; //5s
    client.options.receiveTimeout = 3000;

    return client.get(url);
  }
}
