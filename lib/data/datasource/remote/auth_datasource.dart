import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:vigenesia/constant/api_config.dart';
import 'package:vigenesia/data/model/response/register_response_model.dart';

import '../../model/request/logn_request_model.dart';
import '../../model/request/register_request_model.dart';
import 'package:http/http.dart' as http;

import '../../model/response/login_response_model.dart';

class AuthDatasource {
  Future<Either<String, RegisterResponseModel>> register(RegisterRequestModel registerData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/register'),
      body: jsonEncode(registerData.toJson()),
      headers: {
        'Content-Type': 'application/json'
      },
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Right(RegisterResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(result['message']);
    }
  }

  Future<Either<String, LoginResponseModel>> login(LoginRequestModel loginData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/login'),
      body: jsonEncode(loginData.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(result['errors']);
    }
  }
}
