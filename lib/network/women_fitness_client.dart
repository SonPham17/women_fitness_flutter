import 'package:dio/dio.dart';

class WomenFitnessClient{
  static BaseOptions _options = BaseOptions(
    baseUrl: 'http://isub.mobi',
    connectTimeout: 5000,
  );

  static Dio _dio = Dio(_options);

  WomenFitnessClient._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }

  static final WomenFitnessClient instance = WomenFitnessClient._internal();

  Dio get dio => _dio;
}