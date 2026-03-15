import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';
import 'package:task_manager_with_getx/ui/controller/sign_in_controller.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_verify_email.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_with_getx/ui/screens/sign_up_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';
import 'package:task_manager_with_getx/ui/widgets/snack_bar_message.dart';

import '../utils/app_theme/app_theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = 'signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();

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
                  Text('Get Started With', style: textTheme.titleLarge),
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
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'password'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter PassWord';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  GetBuilder<SignInController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress==false,
                        replacement: const CenteredProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                              await _onTapSignIn();

                            }
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed(ForgotPasswordVerifyEmail.name);
                          },
                          child: Text('Forgot Password?'),
                        ),
                        _signupSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void>_onTapSignIn()async{
    Map<String,dynamic> requestBody={
      'email':_emailTEController.text.trim(),
      'password':_passwordTEController.text,
    };
    bool isSuccess=await _signInController.signIn(requestBody: requestBody);
    if(isSuccess){
      snackBarMessage(context, message: 'Success');

      Get.offAllNamed(MainBottomNavbar.name);
    }else{
      snackBarMessage(context, message: _signInController.errorMsg);
    }

  }

  Widget _signupSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        text: "Don't have account? ",
        children: [
          TextSpan(
            style: TextStyle(color: AppTheme.appTheme),
            text: 'SignUp',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(SignUpScreen.name);
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
    _passwordTEController.dispose();
  }
}
