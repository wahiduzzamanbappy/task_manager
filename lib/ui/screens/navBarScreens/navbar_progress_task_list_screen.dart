import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../../data/models/task_list_by_status_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';

class NavbarProgressTaskListScreen extends StatefulWidget {
  const NavbarProgressTaskListScreen({super.key});

  @override
  State<NavbarProgressTaskListScreen> createState() =>
      _NavbarProgressTaskListScreenState();
}

class _NavbarProgressTaskListScreenState
    extends State<NavbarProgressTaskListScreen> {
  TaskListByStatusModel? progressTaskListModel;
  bool _getProgressTaskListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();

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
      itemCount: progressTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context, index) => TaskItemWidget(
        text: 'Progress',
        color: Colors.deepPurple,
        taskModel: progressTaskListModel!.taskList![index],
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Progress'));
    if (response.isSuccess) {
      progressTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
