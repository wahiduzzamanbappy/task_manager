import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;

  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  /// Save token and user data to SharedPreferences
  static Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    /// Save token
    await sharedPreferences.setString(_accessTokenKey, token);

    /// Save user data as JSON string
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));

    accessToken = token;
    userModel = model;
  }

  /// Retrieve user data and token from SharedPreferences
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    /// Retrieve token
    String? token = sharedPreferences.getString(_accessTokenKey);

    /// Retrieve user data
    String? userData = sharedPreferences.getString(_userDataKey);
    accessToken = token;
    userModel = UserModel.fromJson(jsonDecode(userData!));
  }


  /// Check if the user is logged in by verifying the presence of a token
  static Future<bool> isUserLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ///Check for token existence
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }


  /// Clear user data and token from SharedPreferences
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
