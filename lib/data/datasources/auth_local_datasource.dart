import 'package:flutter_pos/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_pref', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_pref');
  }

  Future<AuthResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_pref');

    return AuthResponseModel.fromJson(authData!);
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_pref');

    return authData != null;
  }
}
