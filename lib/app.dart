import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/controller_binder.dart';
import 'package:task_manager_with_getx/ui/screens/add_new_task.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_pin_verification.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_verify_email.dart';
import 'package:task_manager_with_getx/ui/screens/forgot_password_verify_email_reset_password.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/screens/sign_up_screen.dart';
import 'package:task_manager_with_getx/ui/screens/splash_screen.dart';
import 'package:task_manager_with_getx/ui/screens/update_profile_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_theme/app_theme.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});
  static GlobalKey<NavigatorState>navigateKey =GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigateKey,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        colorSchemeSeed: AppTheme.appTheme,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 16,color: Colors.black45)
        ),
        inputDecorationTheme: InputDecorationThemeData(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:  ElevatedButton.styleFrom(
              backgroundColor: AppTheme.appTheme,
              fixedSize: Size.fromWidth(double.maxFinite),
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
          ),
        ),

      ),
      initialRoute: SplashScreen.name,
      onGenerateRoute: (setting){
        late Widget widget;
        if(setting.name==SplashScreen.name){
          widget =const SplashScreen();
        }else if(setting.name == SignInScreen.name){
          widget = const SignInScreen();
        }
        else if(setting.name == SignUpScreen.name){
          widget = const SignUpScreen();
        }
        else if(setting.name == ForgotPasswordVerifyEmail.name){
          widget = const ForgotPasswordVerifyEmail();
        }
        else if(setting.name == ForgotPasswordPinVerification.name){
          String email = setting.arguments as String;
          widget =  ForgotPasswordPinVerification(email: email,);
        }
        else if(setting.name == ForgotPasswordVerifyEmailResetPassword.name){

          widget =  ForgotPasswordVerifyEmailResetPassword(verificationInfo: setting.arguments as List<String>,);
        }
        else if(setting.name == MainBottomNavbar.name){
          widget = const MainBottomNavbar();
        }
        else if(setting.name == AddNewTask.name){
          widget = const AddNewTask();
        }
        else if(setting.name == UpdateProfileScreen.name){
          widget = const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (context)=>widget);
      },
    );
  }
}
