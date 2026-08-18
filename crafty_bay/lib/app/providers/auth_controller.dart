import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';

class AuthController {
  static const String _tokenKey = 'token';
  static const String _userModelKey = 'user-data';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(String token, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(user.toJson()));
    accessToken = token;
    userModel = user;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userModelKey);
    if (token != null && userData != null) {
      accessToken = token;
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    return token != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userModelKey);
    accessToken = null;
    userModel = null;
  }
}
