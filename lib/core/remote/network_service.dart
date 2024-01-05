import 'dart:io';

import 'package:dio/io.dart';
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

    // ignore: deprecated_member_use
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      ((client) {
    final certBytes = envReader.getCertificate();
    final SecurityContext context = SecurityContext();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    context.setTrustedCertificatesBytes(certBytes);
    return HttpClient(context: context);
  });
  return _dio;
});
