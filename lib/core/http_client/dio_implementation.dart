import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClientImplementation implements HttpClient {
  final Dio dio;
  DioHttpClientImplementation(this.dio);

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get<T>(
      url,
      queryParameters: queryParameters,
    );
  }
}
