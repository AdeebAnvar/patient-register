import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/data/network/service_provider/token_service_provider.dart';
import 'package:novindus_mechine_test/data/network/repository/token_repository.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool isInitialized = false;
  TokenRepository tokenRepository = TokenServiceProvider();
  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 2)).then((v) async {
      String? token = await tokenRepository.getToken();
      if (token != null) {
        isInitialized = true;
      } else {
        isInitialized = false;
      }
      notifyListeners();
    });
  }
}
