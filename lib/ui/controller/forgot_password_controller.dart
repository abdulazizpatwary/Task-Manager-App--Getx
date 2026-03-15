import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls/urls.dart';

class ForgotPasswordController extends GetxController {
  bool _inProgress = false;
  bool get inProgress =>_inProgress;
  
  String? _errorMsg;
  String? get errorMsg =>_errorMsg;
  
  Future<bool>getEmailVerify({required String email})async{
    _inProgress = true;
    update();
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.verifyEmailUrl(email));
    if(response.isSuccess){
      isSuccess =true;
      if(response.responseBody!['status']=='success'){
        _errorMsg=null;
      }
      else{
        _errorMsg ='SMTP service is off';
      }
    }else{
      _errorMsg  =response.errorMsg;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  Future<bool>getPinVerify({required String email,required String OTP})async{
    _inProgress = true;
    update();
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.pinVerificationUrl(email,OTP));
    if(response.isSuccess){
      isSuccess =true;
      if(response.responseBody!['status']=='success'){
        _errorMsg=null;
      }
      else{
        _errorMsg ='SMTP service is off';
      }
    }else{
      _errorMsg  =response.errorMsg;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  Future<bool>postNewPassword({required Map<String,dynamic>requestBody})async{
    _inProgress = true;
    update();
    bool isSuccess = false;

    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.resetPasswordUrl,body: requestBody
    );
    if(response.isSuccess){
      isSuccess =true;
      if(response.responseBody!['status']=='success'){
        _errorMsg=null;
      }
      else{
        _errorMsg ='SMTP service is off';
      }
    }else{
      _errorMsg  =response.errorMsg;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  
  
}