import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/service/network_caller.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask (String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
        _errorMessage = response.errorMessage;
      }
    _inProgress = false;
    update();
    return isSuccess;
  }
}