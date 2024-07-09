import 'dart:io';

import 'package:dio/dio.dart';
import 'package:novindus_mechine_test/data/network/service_provider/token_service_provider.dart';
import 'package:novindus_mechine_test/data/network/repository/token_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  Dio init({
    String baseUrl = 'https://flutter-amr.noviindus.in/api/',
  }) {
    final Dio dio = Dio();

    dio.options = BaseOptions(
        followRedirects: true,
        baseUrl: baseUrl,
        validateStatus: (int? status) {
          if (status != null) {
            return status < 500;
          } else {
            return false;
          }
        },
        contentType: 'application/json',
        headers: <String, dynamic>{});
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        maxWidth: 180,
      ),
    );

    return dio;
  }

  Future<Map<String, dynamic>?> getAuthHeader() async {
    final TokenRepository tokenRepository = TokenServiceProvider();
    final String? tok = await tokenRepository.getToken();
    if (tok != null) {
      final Map<String, dynamic> header = <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $tok',
      };

      return header;
    } else {
      return null;
    }
  }
}
