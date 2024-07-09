import 'dart:convert';
import 'dart:developer';

import 'package:novindus_mechine_test/data/models/token_model.dart';
import 'package:novindus_mechine_test/data/network/repository/token_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenServiceProvider implements TokenRepository {
  @override
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tokenJson = prefs.getString('token');
    if (tokenJson != null) {
      final Map<String, dynamic> tokenModelMap = jsonDecode(tokenJson) as Map<String, dynamic>;
      final TokenModel tokenModel = TokenModel.fromMap(tokenModelMap);
      final bool isExpired = checkTokenExpired(tokenModel.expirationDateTime);
      if (isExpired) {
        return null;
      } else {
        return tokenModel.token;
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> saveToken({required String token, required DateTime expirationDateTime}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final TokenModel tokenModel = TokenModel(expirationDateTime: expirationDateTime, token: token);
    final String tokenModelJson = json.encode(tokenModel.toMap());
    log('fgfrffrre');
    await prefs.setString('token', tokenModelJson);
  }

  @override
  bool checkTokenExpired(DateTime tokenExpiryDateTime) {
    if (tokenExpiryDateTime.isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> clearTokenFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
