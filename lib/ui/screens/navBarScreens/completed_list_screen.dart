import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/completed_taskList_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../../data/models/task_model.dart';

class NavbarCompletedTaskListScreen extends StatefulWidget {
  const NavbarCompletedTaskListScreen({super.key});

  @override
  State<NavbarCompletedTaskListScreen> createState() =>
      _NavbarCompletedTaskListScreenState();
}

class _NavbarCompletedTaskListScreenState
    extends State<NavbarCompletedTaskListScreen> {
  final CompletedTaskListController _completedTaskListController =
  Get.find<CompletedTaskListController>();

  @override
  void initState() {
    super.initState();
    _completedTaskListController.getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<CompletedTaskListController>(
            builder: (controller) {
              if (controller.inProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.completedTasks.isEmpty) {
                return const Center(child: Text("No completed tasks found."));
              }

              return _buildTaskListView(controller.completedTasks);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> completedTasks) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: completedTasks.length,
      itemBuilder: (context, index) => TaskItemWidget(
        text: 'Completed',
        color: Colors.green,
        taskModel: completedTasks[index],
      ),
    );
  }
}