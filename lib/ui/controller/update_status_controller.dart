import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls/urls.dart';
import 'package:task_manager_with_getx/ui/controller/new_task_controller.dart';

class UpdateStatusController extends GetxController {
  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  Future<bool> changeStatus({
    required String sid,
    required String status,
  }) async {
    bool isSuccess = false;
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(sid, status),
    );
    if (response.isSuccess) {
      TaskController taskController = Get.find<TaskController>();
      taskController.removeTaskById(sid);


      isSuccess = true;
      _errorMsg = null;
    } else {
      _errorMsg = response.errorMsg;
    }
    return isSuccess;
  }
  Future<bool> deleteTask({
    required String sid,
  }) async {
    bool isSuccess = false;
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(sid),
    );
    if (response.isSuccess) {
      TaskController taskController = Get.find<TaskController>();
      taskController.removeTaskById(sid);


      isSuccess = true;
      _errorMsg = null;
    } else {
      _errorMsg = response.errorMsg;
    }
    return isSuccess;
  }
}
