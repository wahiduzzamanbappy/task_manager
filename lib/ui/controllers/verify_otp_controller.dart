import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/service/network_caller.dart';

class VerifyOTPController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String Otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.recoverVerifyOtpUrl(email, Otp));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    }  else {
        _errorMessage = response.errorMessage;
      }
    _inProgress = false;
    update();
    return isSuccess;
  }
}