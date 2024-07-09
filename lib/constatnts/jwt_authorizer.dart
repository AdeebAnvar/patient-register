import 'package:jwt_decode/jwt_decode.dart';

DateTime? getExpirationDateOfToken(String token) {
  final Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
  final DateTime? expirationDate = decodedToken['exp'] != null ? DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000) : null;
  return expirationDate;
}
