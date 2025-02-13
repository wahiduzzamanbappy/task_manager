import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/service/network_caller.dart';

class UpdateTaskStatusController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  TaskModel? taskModel;

  Future<bool> updateTaskStatus(String id, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateStatusUrl(
        taskModel?.sId ?? id,
        taskModel?.status ?? status,
      ),
    );

    if (response.isSuccess) {
      _errorMessage = 'Task Status updated successfully!';
      isSuccess = true;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
