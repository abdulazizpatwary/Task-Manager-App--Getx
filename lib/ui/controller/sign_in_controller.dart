import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';

import '../../data/urls/urls.dart';

class SignInController extends GetxController{
  bool _inProgress=false;
  String? _errorMsg;
  String get errorMsg=>_errorMsg!;
  bool get inProgress=>_inProgress;
  
  Future<bool> signIn({required Map<String, dynamic>requestBody})async{
    AuthController authController = Get.find<AuthController>();
    _inProgress=true;
    update();
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.loginUrl,body:requestBody );
    if(response.isSuccess){
      UserModel userModel=UserModel.fromJson(response.responseBody!['data']);
      String token =response.responseBody!['token'];
      await authController.saveUserData(userModel, token);
      await authController.getUserData();
      print(userModel.firstName);

      isSuccess = true;
      _errorMsg=null;
    }else{
      _errorMsg=response.errorMsg;
    }
    _inProgress=false;
    update();

    return isSuccess;

  }
}