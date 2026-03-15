class TaskListByStatusModel {
  String? status;
  List<TaskModel>? taskListbyStatus;

  TaskListByStatusModel({this.status, this.taskListbyStatus});

  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskListbyStatus = <TaskModel>[];
      json['data'].forEach((v) {
        taskListbyStatus!.add( TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (taskListbyStatus != null) {
      data['data'] = taskListbyStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskModel({this.sId, this.title, this.description, this.status, this.createdDate});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }
}
