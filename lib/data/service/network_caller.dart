import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/ui/controllers/auth_controller.dart';
import '../../ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('GET Request: $url');

      final authController = Get.find<AuthController>();

      http.Response response = await http.get(
        uri,
        headers: {'token': authController.accessToken ?? ' '},
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('POST Request: $url');
      debugPrint('BODY: $body');

      final authController = Get.find<AuthController>();

      http.Response response = await http.post(
        uri,
        headers: {
          'content-type': 'application/json',
          'token': authController.accessToken ?? ' ',
        },
        body: jsonEncode(body),
      );

      debugPrint('Response Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> _logout() async {
    final authController = Get.find<AuthController>();
    await authController.clearUserData();
    Get.offAllNamed(SignInScreen.name); // Redirect to sign-in screen
  }
}
