import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/data/service/network_caller.dart';
import 'package:task_manager_with_getx/ui/controller/sign_up_controller.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';

import '../../data/urls/urls.dart';
import '../utils/app_theme/app_theme.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNamedTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpController signUpController = Get.find<SignUpController>();

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
                  Text('Join With Us', style: textTheme.titleLarge),
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
                    controller: _firstNamedTEController,
                    //keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? values) {
                      if (values?.trim().isEmpty ?? true) {
                        return 'Enter FirstName';
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
                        return 'Enter LastName';
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
                        return 'Enter mobile';
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
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress==false,
                        replacement: CenteredProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _onTapSignUp();
                            }
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 40),
                  Center(child: _signInSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignUp() async {
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNamedTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": "",
    };
    bool isSuccess = await signUpController.signUp(requestBody: requestBody);
    if (isSuccess) {
      snackBarMessage(context, message: 'SuccessFull');
      Get.back();
    } else {
      snackBarMessage(context, message: 'UnSuccessfull');
    }
  }

  Widget _signInSection() {
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
    _passwordTEController.dispose();
    _firstNamedTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
  }
}


