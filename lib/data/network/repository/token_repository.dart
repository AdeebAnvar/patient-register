abstract class TokenRepository {
  Future<void> saveToken({required String token, required DateTime expirationDateTime});
  Future<String?> getToken();
  bool checkTokenExpired(DateTime tokenExpiryDateTime);
  Future<void> clearTokenFromLocal();
}
