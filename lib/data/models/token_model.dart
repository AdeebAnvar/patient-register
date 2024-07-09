import 'dart:convert';

class TokenModel {
  String token;
  DateTime expirationDateTime;
  TokenModel({
    required this.token,
    required this.expirationDateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'expirationDateTime': expirationDateTime.millisecondsSinceEpoch,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      token: map['token'] as String,
      expirationDateTime: DateTime.fromMillisecondsSinceEpoch(map['expirationDateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
