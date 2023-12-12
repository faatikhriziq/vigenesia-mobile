// To parse this JSON data, do
//
//     final getMotivationResponseModel = getMotivationResponseModelFromJson(jsonString);

import 'dart:convert';

GetMotivationResponseModel getMotivationResponseModelFromJson(String str) => GetMotivationResponseModel.fromJson(json.decode(str));

String getMotivationResponseModelToJson(GetMotivationResponseModel data) => json.encode(data.toJson());

class GetMotivationResponseModel {
  String code;
  String status;
  String message;
  List<Datum> data;

  GetMotivationResponseModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMotivationResponseModel.fromJson(Map<String, dynamic> json) => GetMotivationResponseModel(
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
  int id;
  String username;
  String motivation;
  String createdAt;
  String updatedAt;

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
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "motivation": motivation,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
