import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/Cancelled_taskList_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../../data/models/task_model.dart';

class NavbarCancelledTaskListScreen extends StatefulWidget {
  const NavbarCancelledTaskListScreen({super.key});

  @override
  State<NavbarCancelledTaskListScreen> createState() =>
      _NavbarCancelledTaskListScreenState();
}

class _NavbarCancelledTaskListScreenState
    extends State<NavbarCancelledTaskListScreen> {
final CancelledTaskListController _cancelledTaskListController = Get.find<CancelledTaskListController>();

  @override
  void initState() {
    super.initState();
    _cancelledTaskListController.getCancelledTaskList();
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
            child: GetBuilder<CancelledTaskListController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.cancelledTasks.isEmpty) {
                  return const Center(child: Text("No completed tasks found."));
                }

                return _buildTaskListView(controller.cancelledTasks);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> cancelledTask) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: cancelledTask.length,
        itemBuilder: (context, index) => TaskItemWidget(
          text: 'Cancelled',
          color: Colors.red,
          taskModel: cancelledTask[index],
      ),
    );
  }

}
