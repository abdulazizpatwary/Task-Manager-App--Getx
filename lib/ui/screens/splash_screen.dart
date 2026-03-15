import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import '../widgets/app_logo.dart';
import '../widgets/screeen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController  = Get.find<AuthController>();
  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    _moveToNextScreen();
  }
  Future<void>_moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    bool isSignIn=await authController.isSignIn();
    if(isSignIn){

        Get.offNamed(MainBottomNavbar.name,);


    }else{
      Get.offNamed(SignInScreen.name);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundWidgets(child: AppLogoWidget(),),
    );
  }
}




