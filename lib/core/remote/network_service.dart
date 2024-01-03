import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:project_setup/core/env/env_reader.dart';
import 'package:project_setup/core/remote/network_service_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final envReader = ref.watch(envReaderProvider);

  final options = BaseOptions(
    baseUrl: envReader.getBaseUrl(),
    connectTimeout: const Duration(minutes: 1),
    sendTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
  );

  final _dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(),
    ]);

  return _dio;
});
