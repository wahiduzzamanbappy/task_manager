import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class NavbarCancelledTaskListScreen extends StatefulWidget {
  const NavbarCancelledTaskListScreen({super.key});

  @override
  State<NavbarCancelledTaskListScreen> createState() =>
      _NavbarCancelledTaskListScreenState();
}

class _NavbarCancelledTaskListScreenState
    extends State<NavbarCancelledTaskListScreen> {
  TaskListByStatusModel? cancelledTaskListModel;
  bool _getCancelledTaskListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
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
      itemCount: cancelledTaskListModel?.data?.length ?? 0,
      itemBuilder: (context, index) => TaskItemWidget(
        text: 'Cancelled',
        color: Colors.redAccent,
        taskModel: cancelledTaskListModel!.data![index],
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Cancelled'));
    if (response.isSuccess) {
      cancelledTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
