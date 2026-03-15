class TaskCountByStatusModel {
  String? status;
  List<StatusCountModel>? statusCountList;

  TaskCountByStatusModel({this.status, this.statusCountList});

  TaskCountByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      statusCountList = <StatusCountModel>[];
      json['data'].forEach((v) {
        statusCountList!.add( StatusCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (this.statusCountList != null) {
      data['data'] = this.statusCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusCountModel {
  String? sId;
  int? sum;

  StatusCountModel({this.sId, this.sum});

  StatusCountModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
