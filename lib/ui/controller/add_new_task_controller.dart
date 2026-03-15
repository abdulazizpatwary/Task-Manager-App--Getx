import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';

import '../../data/urls/urls.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMsg;
  String? get errorMsg=>_errorMsg;
  bool get inProgress =>_inProgress;
  Future<bool>onCreateTask(Map<String,dynamic>requestBody)async{
    _inProgress = true;
    update();
    bool isSuccess = false;
    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.createTaskUrl,body: requestBody);
    if(response.isSuccess){
      isSuccess = true;
      _errorMsg =null;
    }else{
      _errorMsg=response.errorMsg;

    }
    _inProgress=false;
    update();

    return isSuccess;
  }
}