import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controllers/new_taskList_controller.dart';
import 'package:task_manager/ui/controllers/task_count_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import 'package:task_manager/ui/widgets/task_status_summary_counter_widget.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';
import '../../widgets/centered_circle_indicator.dart';
import '../add_new_task_screen.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();
  final TaskCountByStatusController _taskCountByStatusController =
      Get.find<TaskCountByStatusController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTaskCountByStatus();
      _getNewTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(
        textTheme: textTheme,
        fromUpdateProfile: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (context) {
                return GetBuilder<TaskCountByStatusController>(
                    builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    ),
                    child: _buildTasksSummaryByStatus(controller.taskCount),
                  );
                });
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GetBuilder<NewTaskListController>(builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const Padding(
                      padding: EdgeInsets.only(top: 220),
                      child: CenteredCircularProgressIndicator(),
                    ),
                    child: _buildTaskListView(controller.taskList),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          taskModel: taskList[index],
          text: 'New',
          color: Colors.lightBlue,
        );
      },
    );
  }

  Widget _buildTasksSummaryByStatus(List<TaskCountModel> taskCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: taskCount.length,
          itemBuilder: (context, index) {
            final TaskCountModel model = taskCount[index];
            return TaskStatusSummaryCounterWidget(
              title: model.sId ?? '',
              count: model.sum.toString(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    final bool isSuccess = await _taskCountByStatusController.getTaskCount();
    if (isSuccess) {
      showSnackBarMessage(context, _taskCountByStatusController.errorMessage!);
    }
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccess = await _newTaskListController.getTaskList();
    if (isSuccess) {
      showSnackBarMessage(context, _newTaskListController.errorMessage!);
    }
  }
}
