import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/data/model/response/login_response_model.dart';

class AuthLocalDatasource {
  Future<bool> saveAuthData(LoginResponseModel model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = await pref.setString('auth', jsonEncode(model.toJson()));
    await pref.setBool("everLaunched", true);
    return res;
  }

  Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString('auth') ?? '';
    final data = LoginResponseModel.fromJson(jsonDecode(res));
    return data.data.token;
  }

  Future<String> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString('auth') ?? '';
    final data = LoginResponseModel.fromJson(jsonDecode(res));
    return data.data.name;
  }

  Future<Data> getAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString('auth') ?? '';
    final data = LoginResponseModel.fromJson(jsonDecode(res));
    return data.data;
  }

  Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString('auth') ?? '';
    final data = LoginResponseModel.fromJson(jsonDecode(res));
    return data.data.id;
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = await pref.remove('auth');
    return res;
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString('auth') ?? '';
    return res.isNotEmpty;
  }

  Future<bool> getEverLaunched() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getBool("everLaunched") ?? false;
    return res;
  }
}
