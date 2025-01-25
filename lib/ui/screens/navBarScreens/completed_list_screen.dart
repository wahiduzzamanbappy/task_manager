import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class NavbarCompletedTaskListScreen extends StatefulWidget {
  const NavbarCompletedTaskListScreen({super.key});

  @override
  State<NavbarCompletedTaskListScreen> createState() =>
      _NavbarCompletedTaskListScreenState();
}

class _NavbarCompletedTaskListScreenState
    extends State<NavbarCompletedTaskListScreen> {
  TaskListByStatusModel? completedTaskListModel;
  bool _getCompletedTaskListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTaskListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: completedTaskListModel?.data?.length ?? 0,
      itemBuilder: (context, index) => TaskItemWidget(
        text: 'Completed',
        color: Colors.green,
        taskModel: completedTaskListModel!.data![index],
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskListInProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Completed'));
    if (response.isSuccess) {
      completedTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {});
  }
}
