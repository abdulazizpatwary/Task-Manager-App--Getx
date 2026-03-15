import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';
import 'package:task_manager_with_getx/ui/controller/update_profile_controller.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_with_getx/ui/widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = 'update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _photoTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNamedTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();
  UpdateProfileController updateProfileController = Get.find<UpdateProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text=authController.userModel?.email??' ';
    _firstNamedTEController.text=authController.userModel?.firstName??' ';
    _lastNameTEController.text=authController.userModel?.lastName??' ';
    _mobileTEController.text=authController.userModel?.mobile??' ';


  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TmAppBar(isProfileUpdate: true,),
      body: ScreenBackgroundWidgets(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, top: 24, right: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text('Update Profile', style: textTheme.titleLarge),
                  SizedBox(height: 16),
                  Container(
                    width: double.maxFinite,
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      
                    ),
                    child: GetBuilder<UpdateProfileController>(
                      builder: (controller) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                await controller.pickImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black45,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomLeft: Radius.circular(6))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                                  child: Center(child: Text('Photo')),
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(controller.pickedImage == null ? 'No photos found ':controller.pickedImage!.name),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'email'),

                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNamedTEController,
                    //keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter email';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    //keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter email';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'mobile'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter email';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'password'),

                  ),
                  SizedBox(height: 16),
                  GetBuilder<UpdateProfileController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress==false,
                        replacement: CenteredProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                              await _onTapUpdateProfile();
                            }
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }





  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }

  Future<void> _onTapUpdateProfile() async {
    Map<String,dynamic>requestBody={};
    if(_firstNamedTEController.text !=authController.userModel?.firstName ){
      requestBody['firstName'] =_firstNamedTEController.text.trim();
    }if(_lastNameTEController.text !=authController.userModel?.lastName){
      requestBody['lastName'] =_lastNameTEController.text.trim();
    }
    if(_mobileTEController.text !=authController.userModel?.mobile){
      requestBody['mobile'] =_mobileTEController.text.trim();
    }
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password']=_passwordTEController.text;
    }
    if(updateProfileController.pickedImage !=null){
      List<int> imageBytes=await updateProfileController.pickedImage!.readAsBytes();
      requestBody['photo']=base64Encode(imageBytes);
    }
    bool isSuccess=await updateProfileController.postUpdate(requestBody);
    if(isSuccess){
      snackBarMessage(context, message: 'Success');
      await authController.updateUser(requestBody);
      Get.offNamed(MainBottomNavbar.name);
    }
    else{
      snackBarMessage(context, message: updateProfileController.errorMsg??' ');
    }

  }
}
