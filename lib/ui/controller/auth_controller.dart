import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_with_getx/data/models/user_model.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';

class AuthController extends GetxController{
   UserModel? _model;
   String? _token;
   UserModel? get userModel=>_model;
   String? get accessToken=>_token;

    static const String _tokenKey='tokenKey';
    static const String _model_key='user-model';
    Future<void> saveUserData(UserModel userModel, String userToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, userToken);
    sharedPreferences.setString(_model_key, jsonEncode(userModel.toJson()));
    _model=userModel;
    _token=userToken;
     update();
  }
  Future<void>updateUser(Map<String,dynamic>updateData)async{
      if(_model!=null &&_token !=null){
        if(updateData['firstName']?.toString().isNotEmpty??false){
          _model!.firstName=updateData['firstName'];
        }
        if(updateData['lastName']?.toString().isNotEmpty??false){
          _model!.lastName=updateData['lastName'];
        }
        if(updateData['mobile']?.toString().isNotEmpty??false){
          _model!.mobile=updateData['mobile'];
        }
        if(updateData['photo']?.toString().isNotEmpty??false){
          _model!.photo=updateData['photo'];
        }
        await saveUserData(_model!, _token!);
        update();


      }
  }
   Future<bool>isSignIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if(token !=null) {
      await getUserData();
      return true;
    }
    return false;
  }
   Future<void> getUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_model_key);
    _model = UserModel.fromJson(jsonDecode(data!));
    _token = sharedPreferences.getString(_tokenKey);
    update();

  }
    Future<void> clearData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
    _model=null;
    _token=null;
    update();
    Get.offAllNamed(SignInScreen.name);
  }

}