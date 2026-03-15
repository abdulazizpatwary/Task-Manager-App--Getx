import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';
import 'package:task_manager_with_getx/ui/controller/forgot_password_controller.dart';
import 'package:task_manager_with_getx/ui/controller/nav_controller.dart';
import 'package:task_manager_with_getx/ui/controller/new_task_controller.dart';
import 'package:task_manager_with_getx/ui/controller/sign_in_controller.dart';
import 'package:task_manager_with_getx/ui/controller/sign_up_controller.dart';
import 'package:task_manager_with_getx/ui/controller/update_profile_controller.dart';
import 'package:task_manager_with_getx/ui/controller/update_status_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>NavController());
    Get.lazyPut(()=>SignUpController());
    Get.lazyPut(()=>SignInController());
    Get.lazyPut(()=>AuthController());
    Get.lazyPut(()=>UpdateProfileController());
    Get.lazyPut(()=>AddNewTaskController());
    Get.lazyPut(()=>TaskController());
    Get.lazyPut(()=>UpdateStatusController());
    Get.lazyPut(()=>ForgotPasswordController());
  }

}