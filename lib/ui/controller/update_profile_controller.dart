import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/data/urls/urls.dart';

class UpdateProfileController extends GetxController{
  bool _inProgress = false;
  String? _errorMsg;
  bool get inProgress =>_inProgress;
  String? get errorMsg =>_errorMsg;
  XFile? _pickedImage;
  XFile? get pickedImage=>_pickedImage;
  Future<void>pickImage()async{
    ImagePicker picker = ImagePicker();
    XFile? xFile =await picker.pickImage(source: ImageSource.gallery);
    _pickedImage = xFile;
    update();
  }
  Future<bool> postUpdate(Map<String,dynamic>requestBody)async{
    _inProgress=true;
    update();
    bool isSuccess=false;
    NetworkResponse response =await NetworkCaller.postRequest(url: Urls.updateProfileUrl,body: requestBody);
    if(response.isSuccess){
       isSuccess=true;
       _errorMsg =null;
    }
    else{
      _errorMsg = response.errorMsg;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }

}