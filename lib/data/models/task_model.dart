class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskModel(
      {this.sId, this.title, this.description, this.status, this.createdDate});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['_title'];
    description = json['_description'];
    status = json['_status'];
    createdDate = json['_createData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['_title'] = title;
    data['_description'] = description;
    data['_status'] = status;
    data['_createData'] = createdDate;
    return data;
  }
}
