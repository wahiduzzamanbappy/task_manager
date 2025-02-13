import 'package:get/get.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import '../../data/service/network_caller.dart';

class SignInController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.logInUrl, body: requestBody);
    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await authController.saveUserData(token, userModel);
      isSuccess = true;
      _errorMessage = null;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Username/Password is incorrect';
      } else {
        _errorMessage = response.errorMessage;
      }
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
