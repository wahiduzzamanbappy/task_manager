
class TaskCountModel{
  String? sId;
  int? sum;

  TaskCountModel({this.sId, this.sum});
  TaskCountModel.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    sum = json['_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['_sum'] = sum;
    return data;
  }
}