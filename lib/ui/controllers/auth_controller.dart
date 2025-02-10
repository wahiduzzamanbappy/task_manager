import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthController extends GetxController {
  String? accessToken;
  UserModel? userModel;

  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  /// Save user data to SharedPreferences
  Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));

    accessToken = token;
    userModel = model;
  }

  /// Retrieve user data from SharedPreferences
  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);

    if (token != null && userData != null) {
      accessToken = token;
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  /// Check if the user is logged in
  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  /// Clear user data and log out
  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    accessToken;
    userModel;

    Get.offAllNamed('/signIn');
  }
}
