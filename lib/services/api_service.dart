import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com', // temporary API for testing
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}