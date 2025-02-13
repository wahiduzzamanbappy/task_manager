import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/service/network_caller.dart';

class ResetPasswordController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(String email, String password, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "OTP": otp.toString(),
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPassUrl, body: requestBody);

    if (response.responseData?["status"] == "success") {
      _errorMessage = 'Password updated successful!';
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
