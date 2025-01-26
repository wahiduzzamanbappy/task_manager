import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

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
  bool _deleteTaskInProgress = false;

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
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: widget.color,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _updateTaskListItem(widget.taskModel.sId.toString(),
                            widget.taskModel.status.toString());
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteTaskListItem(widget.taskModel.sId.toString());
                      },
                      icon: Icon(
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
            title: Text('Delete Task'),
            content: Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await _deleteTaskItem(id);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        });
  }

  void _updateTaskListItem(String id, String status) {
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
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Progress',
                    style: TextStyle(color: Colors.deepPurpleAccent)),
                onTap: () {
                  widget.taskModel.status = 'Progress';
                  _updateTaskItem(id, 'New');
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: Text('Completed', style: TextStyle(color: Colors.green)),
                onTap: () {
                  widget.taskModel.status = 'Completed';
                  _updateTaskItem(id, 'New');
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 0),
              ListTile(
                title: Text('Cancelled', style: TextStyle(color: Colors.red)),
                onTap: () {
                  widget.taskModel.status = 'Cancelled';
                  _updateTaskItem(id, 'New');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteTaskItem(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(id));
    _deleteTaskInProgress = false;

    setState(() {});
    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task Deleted successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete! Try again.'),
        ),
      );
    }
  }

  Future<void> _updateTaskItem(String id, String status) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateStatusUrl(widget.taskModel.sId.toString(),
            widget.taskModel.status.toString()));

    setState(() {});
    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task Status updated successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update! Try again.'),
        ),
      );
    }
    _deleteTaskInProgress = false;
    setState(() {});
  }
}
