import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/forgot_password_controller.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';

import '../utils/app_theme/app_theme.dart';

class ForgotPasswordVerifyEmailResetPassword extends StatefulWidget {
  const ForgotPasswordVerifyEmailResetPassword({super.key, required this.verificationInfo});
  final List<String> verificationInfo;

  static const String name = 'forgot-password/verify-email/reset-password';

  @override
  State<ForgotPasswordVerifyEmailResetPassword> createState() =>
      _ForgotPasswordVerifyEmailResetPasswordState();
}

class _ForgotPasswordVerifyEmailResetPasswordState
    extends State<ForgotPasswordVerifyEmailResetPassword> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ForgotPasswordController  forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Text('Set Password', style: textTheme.titleLarge),
                  Text(
                    'Minimum length password 8 character with latter and number combination',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordTEController,
                    decoration: InputDecoration(hintText: 'New Password'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter New Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter Confirm Password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  GetBuilder<ForgotPasswordController>(
                    builder: (controller) {
                      if(controller.inProgress){
                        return CenteredProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () async{
                          String newPass =_newPasswordTEController.text;
                          String confirmPass =_confirmPasswordTEController.text;
                          if (_formKey.currentState!.validate() && newPass==confirmPass) {
                            await onTapPasswordReset();

                          }
                        },
                        child: Text('Confirm'),
                      );
                    }
                  ),
                  SizedBox(height: 40),
                  Center(child: _signupSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        text: "Have account? ",
        children: [
          TextSpan(
            style: TextStyle(color: AppTheme.appTheme),
            text: 'SignIn',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.offNamed(SignInScreen.name);
              },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();
  }

  Future<void> onTapPasswordReset() async {
    Map<String,dynamic> requestBody={
      "email":widget.verificationInfo[0],
      "OTP":widget.verificationInfo[1],
      "password":_confirmPasswordTEController.text
    };
    bool isSuccess = await forgotPasswordController.postNewPassword(requestBody: requestBody);
    if(isSuccess){
      Get.snackbar('ResetPass', forgotPasswordController.errorMsg??'Successfully reset your pass');
      Get.offAllNamed(SignInScreen.name);
    }
    else{
      Get.snackbar('ResetPass', forgotPasswordController.errorMsg!);
    }
  }
}
