import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/models/task_count_by_status_model.dart';
import '../../data/service/network_caller.dart';

class TaskCountByStatusController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  TaskCountByStatusModel? _taskCountByStatusModel;

  List<TaskCountModel> get taskCount =>
      _taskCountByStatusModel?.taskByStatusList ?? [];

  Future<bool> getTaskCount() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
    if (response.isSuccess) {
      _taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
