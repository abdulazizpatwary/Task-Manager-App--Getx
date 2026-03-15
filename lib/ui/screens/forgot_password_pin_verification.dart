import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_with_getx/ui/controller/forgot_password_controller.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_verify_email_reset_password.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';

import '../utils/app_theme/app_theme.dart';

class ForgotPasswordPinVerification extends StatefulWidget {
  const ForgotPasswordPinVerification({super.key, required this.email});
  final String email;

  static const String name = 'forgot-password/verify-email/pin-verification';

  @override
  State<ForgotPasswordPinVerification> createState() =>
      _ForgotPasswordPinVerificationState();
}

class _ForgotPasswordPinVerificationState
    extends State<ForgotPasswordPinVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PinInputController _pinInputController = PinInputController();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text('Pin Verification', style: textTheme.titleLarge),
                  Text(
                    'A 6 digit verification pin hase been send to your email address',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 16),
                  MaterialPinField(
                    length: 6,
                    keyboardType: TextInputType.number,
                    pinController: _pinInputController,

                    theme: MaterialPinTheme(
                      borderRadius: BorderRadius.circular(5),
                      cellSize: Size(48, 48),
                      elevation: 0,
                      fillColor: Colors.white,
                      //completeFillColor: Colors.white,
                      filledFillColor: Colors.white,
                      focusedFillColor: Colors.white,
                      shape: MaterialPinShape.outlined,
                      disabledFillColor: Colors.white,
                      entryAnimation: MaterialPinAnimation.fade,
                      animationDuration: Duration(microseconds: 100),
                      filledBorderColor: Colors.white,
                      focusedBorderColor: Colors.white,
                      borderColor: Colors.white,
                    ),
                  ),

                  SizedBox(height: 16),
                  GetBuilder<ForgotPasswordController>(
                    builder: (controller) {
                      if(controller.inProgress){
                        return CenteredProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () async{

                          if (_pinInputController.text.length == 6) {
                            await onTapVerifyPin();


                          }
                        },
                        child: Text('Verify'),
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
                Get.offNamedUntil(SignInScreen.name, (predicate) => false);
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
    _pinInputController.dispose();
  }

  Future<void> onTapVerifyPin() async {
    bool isSuccess= await forgotPasswordController.getPinVerify(email: widget.email, OTP: _pinInputController.text);
    if(isSuccess){
      List<String> verificationData=[];
      verificationData.add(widget.email);
      verificationData.add(_pinInputController.text);
      _pinInputController.clear();
      Get.snackbar('PinVerify', forgotPasswordController.errorMsg??'SuccessFully verified');
      Get.offAllNamed(
        ForgotPasswordVerifyEmailResetPassword.name,arguments: verificationData
      );


    }
    else{
      Get.snackbar('PinVerify', forgotPasswordController.errorMsg!);
    }
  }
}
