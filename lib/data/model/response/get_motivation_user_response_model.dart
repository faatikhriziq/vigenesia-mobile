// To parse this JSON data, do
//
//     final getMotivationUserResponseModel = getMotivationUserResponseModelFromJson(jsonString);

import 'dart:convert';

GetMotivationUserResponseModel getMotivationUserResponseModelFromJson(String str) => GetMotivationUserResponseModel.fromJson(json.decode(str));

String getMotivationUserResponseModelToJson(GetMotivationUserResponseModel data) => json.encode(data.toJson());

class GetMotivationUserResponseModel {
  final String code;
  final String status;
  final String message;
  final List<Datum> data;

  GetMotivationUserResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMotivationUserResponseModel.fromJson(Map<String, dynamic> json) => GetMotivationUserResponseModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String username;
  final String motivation;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.username,
    required this.motivation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
        motivation: json["motivation"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        updatedAt: DateTime.parse(json["updated_at"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "motivation": motivation,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
