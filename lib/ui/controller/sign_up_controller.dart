import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls/urls.dart';

class SignUpController extends GetxController{
   bool _inProgress =false;
  bool get inProgress=>_inProgress;
  Future<bool>signUp( {required Map<String,dynamic>requestBody})async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.registrationUrl,body: requestBody);
    if(response.isSuccess){
      isSuccess= true;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }

}