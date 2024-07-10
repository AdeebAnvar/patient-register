// To parse this JSON data, do
//
//     final treatmentsModel = treatmentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:novindus_mechine_test/data/models/branch_model.dart';

TreatmentsModel treatmentsModelFromJson(String str) => TreatmentsModel.fromJson(json.decode(str));

String treatmentsModelToJson(TreatmentsModel data) => json.encode(data.toJson());

class TreatmentsModel {
  bool? status;
  String? message;
  List<Treatment>? treatments;

  TreatmentsModel({
    this.status,
    this.message,
    this.treatments,
  });

  factory TreatmentsModel.fromJson(Map<String, dynamic> json) => TreatmentsModel(
        status: json["status"],
        message: json["message"],
        treatments: json["treatments"] == null ? [] : List<Treatment>.from(json["treatments"]!.map((x) => Treatment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "treatments": treatments == null ? [] : List<dynamic>.from(treatments!.map((x) => x.toJson())),
      };
}

class Treatment {
  int? id;
  List<Branch>? branches;
  String? name;
  String? duration;
  String? price;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Address { KOCHI_KERALA_685565, KOTTAYAM_KERALA_686563, KOZHIKODE }

final addressValues = EnumValues({"Kochi, Kerala-685565": Address.KOCHI_KERALA_685565, "Kottayam, Kerala-686563": Address.KOTTAYAM_KERALA_686563, "Kozhikode": Address.KOZHIKODE});

enum Location { KOCHI, KOZHIKODE, KUMARAKOM_KOTTAYAM }

final locationValues = EnumValues({"Kochi": Location.KOCHI, "Kozhikode": Location.KOZHIKODE, "Kumarakom, Kottayam": Location.KUMARAKOM_KOTTAYAM});

enum Mail { USER123_GMAIL_COM }

final mailValues = EnumValues({"user123@gmail.com": Mail.USER123_GMAIL_COM});

enum Name { EDAPPALI, KUMARAKOM, NADAKKAVU, THONDAYADU }

final nameValues = EnumValues({"Edappali": Name.EDAPPALI, "KUMARAKOM": Name.KUMARAKOM, "Nadakkavu": Name.NADAKKAVU, "Thondayadu": Name.THONDAYADU});

enum Phone { PHONE_99463314529747331452, THE_9846123456, THE_99463314529747331452 }

final phoneValues =
    EnumValues({"9946331452, 9747331452": Phone.PHONE_99463314529747331452, "9846123456": Phone.THE_9846123456, "9946331452,9747331452": Phone.THE_99463314529747331452});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
