import 'dart:convert';

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;
  String get fullName=>'$firstName $lastName';
  UserModel.fromJson(Map<String,dynamic>data){
    email =data['email'];
    firstName=data['firstName'];
    lastName=data['lastName'];
    mobile=data['mobile'];
    photo=data['photo'];
  }
  Map<String,dynamic>toJson(){
    return {
      'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'mobile':mobile,
      'photo':photo,
    };
  }
}