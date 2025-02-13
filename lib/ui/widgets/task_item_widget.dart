import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controllers/delete_taskList_item_controller.dart';
import 'package:task_manager/ui/controllers/update_task_status_controller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({
    super.key,
    required this.text,
    required this.color,
    required this.taskModel,
  });

  final String text;
  final Color color;
  final TaskModel taskModel;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  final DeleteTaskListItemController _deleteTaskListItemController =
      Get.find<DeleteTaskListItemController>();
  final UpdateTaskStatusController _updateTaskStatusController =
      Get.find<UpdateTaskStatusController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ' '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text('Date: ${widget.taskModel.createdDate ?? ''}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Chip(
                    label: Text(
                      widget.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: widget.color,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _updateTaskStatus(
                            widget.taskModel.sId?.toString() ?? '',
                            widget.taskModel.status ?? '');
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteTaskListItem(
                            widget.taskModel.sId?.toString() ?? '');
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTaskListItem(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Task'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await _deleteTaskItem(id);
                  Get.back();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        });
  }

  void _updateTaskStatus(String id, String status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update Task Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New', style: TextStyle(color: Colors.blue)),
                onTap: () {
                  widget.taskModel.status = 'New';
                  _updateTaskItem(id, 'New');
                  Get.back();
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Progress',
                    style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  widget.taskModel.status = 'Progress';
                  _updateTaskItem(id, 'Progress');
                  Get.back();
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Completed',
                    style: TextStyle(color: Colors.green)),
                onTap: () {
                  widget.taskModel.status = 'Completed';
                  _updateTaskItem(id, 'Completed');
                  Get.back();
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Cancelled',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  widget.taskModel.status = 'Cancelled';
                  _updateTaskItem(id, 'Cancelled');
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteTaskItem(String id) async {
    final bool isSuccess =
        await _deleteTaskListItemController.deleteTaskListItem(id);
    if (!isSuccess) {
      showSnackBarMessage(context, _deleteTaskListItemController.errorMessage!);
    }
  }

  Future<void> _updateTaskItem(String id, String status) async {
    final bool isSuccess =
        await _updateTaskStatusController.updateTaskStatus(id, status);

    if (!isSuccess) {
      showSnackBarMessage(context, _updateTaskStatusController.errorMessage!);
    }
  }
}
