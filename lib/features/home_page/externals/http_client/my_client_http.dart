abstract class MyClientHttp<T> {
  final T client;

  MyClientHttp({required this.client});

  Future<dynamic> get({required String url});
}
