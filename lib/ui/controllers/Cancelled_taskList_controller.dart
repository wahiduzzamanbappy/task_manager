import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _cancelledTaskListModel;
  List<TaskModel> get cancelledTasks => _cancelledTaskListModel?.taskList ?? [];

  Future<void> getCancelledTaskList() async {
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Cancelled'));

    if (response.isSuccess) {
      _cancelledTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
  }
}