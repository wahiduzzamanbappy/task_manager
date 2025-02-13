import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';
import '../../data/service/network_caller.dart';

class DeleteTaskListItemController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> deleteTaskListItem(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(id));

    if (response.isSuccess) {
      _errorMessage = 'Task Deleted successfully!';
      isSuccess = true;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
