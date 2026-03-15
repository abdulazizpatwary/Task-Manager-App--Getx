import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';


class NetworkResponse{
  final int statusCode;
  final bool isSuccess;
  String errorMsg;

  Map<String,dynamic>?responseBody;
  NetworkResponse({required this.statusCode,required this.isSuccess,this.errorMsg='Something Went Wrong',this.responseBody});



}
class NetworkCaller {


  static Future<NetworkResponse> postRequest({Map<String,dynamic>?body,required String url})async{
    AuthController authController =Get.find<AuthController>();
    try{

      Uri uri = Uri.parse(url);
      http.Response response = await http.post(uri, headers: {
        'Content-type': 'application/json',
        'token':authController.accessToken??' '
      }, body: jsonEncode(body));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(statusCode: response.statusCode,
            isSuccess: true,
            responseBody: jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        await authController.clearData();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false,);
      }
    }catch(e){
      return NetworkResponse(statusCode: -1, isSuccess: false,errorMsg: e.toString());
    }
  }
  static Future<NetworkResponse> getRequest({Map<String,dynamic>?body,required String url})async{
    AuthController authController = Get.find<AuthController>();
    try{
      Uri uri = Uri.parse(url);
      http.Response response = await http.get(uri,headers: {
        'token':authController.accessToken??' '
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(statusCode: response.statusCode,
            isSuccess: true,
            responseBody: jsonDecode(response.body));
      }
      else if (response.statusCode == 401) {
        await authController.clearData();

        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode, isSuccess: false,);
      }
    }catch(e){
      return NetworkResponse(statusCode: -1, isSuccess: false,errorMsg: e.toString());
    }
  }

}