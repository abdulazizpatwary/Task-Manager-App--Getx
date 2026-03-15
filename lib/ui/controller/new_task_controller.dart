import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/task_count_by_status.dart';
import 'package:task_manager_with_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls/urls.dart';

import '../utils/task_status/task_status.dart';

class TaskController extends GetxController{
  bool _taskStatusCountInProgress =false;
  bool get taskStatusCountInProgress=>_taskStatusCountInProgress;
  bool _newTaskScreenLoading =false;
  bool get newTaskScreenLoading=>_newTaskScreenLoading;


  bool _taskListByStatusProgress =false;
  bool get taskListByStatusProgress=>_taskListByStatusProgress;

  TaskCountByStatusModel? _taskCountByStatusModel;
  TaskCountByStatusModel? get taskCountByStatusModel=>_taskCountByStatusModel;

  TaskListByStatusModel? _taskListByStatusModel;
  TaskListByStatusModel? get taskListByStatusModel=>_taskListByStatusModel;


  String? _errorMsg;
  String? get errorMsg=>_errorMsg;
  void removeTaskById(String id){
    _taskListByStatusModel!.taskListbyStatus!.removeWhere((e)=>id==e.sId);
    update();
  }
  Future<void>loadNewTaskScreen()async{
    _newTaskScreenLoading=true;
    update();
    await taskStatusCount();
    await getTaskListByStatus(status:TaskStatus.newTask);
    _newTaskScreenLoading=false;
    update();
  }



  Future<bool>taskStatusCount()async{
    _taskStatusCountInProgress=true;
    update();
    bool isSuccess=false;
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
      _taskCountByStatusModel =TaskCountByStatusModel.fromJson(response.responseBody!);
      update();
      _errorMsg =null;
      isSuccess=true;
    }
    else{
      _errorMsg = response.errorMsg;
    }
    _taskStatusCountInProgress=false;
    update();
    return isSuccess;
    
  }
  Future<bool>getTaskListByStatus({required String status})async{
    _taskListByStatusProgress=true;
    update();
    bool isSuccess=false;
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl(status));
    if(response.isSuccess){
      _taskListByStatusModel =TaskListByStatusModel.fromJson(response.responseBody!);
      update();
      _errorMsg =null;
      isSuccess=true;
    }
    else{
      _errorMsg = response.errorMsg;
    }
    _taskListByStatusProgress=false;
    update();
    return isSuccess;

  }
  
}