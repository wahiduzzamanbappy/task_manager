import 'package:task_manager/data/models/task_model.dart';

class TaskListByStatusModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListByStatusModel({this.status, this.taskList});

  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status == json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((a) {
        taskList!.add(TaskModel.fromJson(a));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((a) => a.toJson()).toList();
    }
    return data;
  }
}
