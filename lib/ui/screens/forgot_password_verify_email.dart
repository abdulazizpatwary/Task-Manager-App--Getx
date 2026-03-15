import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/forgot_password_controller.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_pin_verification.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';

import '../utils/app_theme/app_theme.dart';

class ForgotPasswordVerifyEmail extends StatefulWidget {
  const ForgotPasswordVerifyEmail({super.key});

  static const String name = 'forgot-password/verify-email';

  @override
  State<ForgotPasswordVerifyEmail> createState() =>
      _ForgotPasswordVerifyEmailState();
}

class _ForgotPasswordVerifyEmailState extends State<ForgotPasswordVerifyEmail> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

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
                  Text('Your Email Address', style: textTheme.titleLarge),
                  Text(
                    'A 6 digit verification pin will send to your email address',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'email'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter email';
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
                          if (_formKey.currentState!.validate()) {
                            await onTapVerifyEmail();


                          }
                        },
                        child: Icon(Icons.arrow_forward_ios_rounded),
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
                Get.back();
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
    _emailTEController.dispose();
  }

  Future<void> onTapVerifyEmail() async {
    bool isSuccess = await forgotPasswordController.getEmailVerify(email: _emailTEController.text.trim());
    if(isSuccess){

      Get.snackbar('email Verifification', forgotPasswordController.errorMsg??'Great Success pin Send To your email');
      Get.toNamed(ForgotPasswordPinVerification.name,arguments: _emailTEController.text.trim());
      _emailTEController.clear();
    }
    else{
      Get.snackbar('Verification Error', forgotPasswordController.errorMsg!);
    }
  }
}
