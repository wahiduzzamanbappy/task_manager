import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/progress_taskList_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../../data/models/task_model.dart';

class NavbarProgressTaskListScreen extends StatefulWidget {
  const NavbarProgressTaskListScreen({super.key, required this.status});

  final String status;

  @override
  State<NavbarProgressTaskListScreen> createState() =>
      _NavbarProgressTaskListScreenState();
}

class _NavbarProgressTaskListScreenState
    extends State<NavbarProgressTaskListScreen> {
  final ProgressTaskListController _progressTaskListController =
      Get.find<ProgressTaskListController>();

  @override
  void initState() {
    super.initState();
    _progressTaskListController.getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<ProgressTaskListController>(
            builder: (controller) {
              if (controller.inProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.progressTasks.isEmpty) {
                return const Center(child: Text("No tasks found."));
              }

              return _buildTaskListView(controller.progressTasks);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> progressTasks) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: progressTasks.length,
      itemBuilder: (context, index) => TaskItemWidget(
        text: 'Progress',
        color: Colors.deepPurpleAccent,
        taskModel: progressTasks[index],
      ),
    );
  }
}
