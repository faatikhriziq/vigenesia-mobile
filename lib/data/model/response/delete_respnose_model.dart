// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeleteResponseModel {
  final String code;
  final String status;
  final String message;
  DeleteResponseModel({
    required this.code,
    required this.status,
    required this.message,
  });

  DeleteResponseModel copyWith({
    String? code,
    String? status,
    String? message,
  }) {
    return DeleteResponseModel(
      code: code ?? this.code,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'status': status,
      'message': message,
    };
  }

  factory DeleteResponseModel.fromMap(Map<String, dynamic> map) {
    return DeleteResponseModel(
      code: map['code'] as String,
      status: map['status'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteResponseModel.fromJson(String source) => DeleteResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeleteResponseModel(code: $code, status: $status, message: $message)';

  @override
  bool operator ==(covariant DeleteResponseModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.status == status && other.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ status.hashCode ^ message.hashCode;
}
