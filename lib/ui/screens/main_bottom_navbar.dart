import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/nav_controller.dart';
import 'package:task_manager_with_getx/ui/screens/Complete_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/add_new_task.dart';
import 'package:task_manager_with_getx/ui/screens/canceled_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/new_task_screen.dart';
import 'package:task_manager_with_getx/ui/screens/progress_task_screen.dart';
import 'package:task_manager_with_getx/ui/utils/app_theme/app_theme.dart';
import 'package:task_manager_with_getx/ui/widgets/screeen_background.dart';

import '../widgets/tm_app_bar.dart';

class MainBottomNavbar extends StatefulWidget {
  const MainBottomNavbar({super.key});

  static const String name = 'main_bottom_nav_bar';

  @override
  State<MainBottomNavbar> createState() => _MainBottomNavbarState();
}

class _MainBottomNavbarState extends State<MainBottomNavbar> {
  final NavController _navController = Get.find<NavController>();
  final List<Widget> widgetList=[
    NewTaskScreen(),
    CompleteTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(builder: (controller){
      return Scaffold(

        body: widgetList[controller.index],
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppTheme.appTheme,
          foregroundColor: Colors.white,
          onPressed: (){
            Get.toNamed(AddNewTask.name);
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: _bottom_navBar(),
      );
    });
  }

  Widget _bottom_navBar() {
    return GetBuilder<NavController>(
      builder: (controller) {
        return NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: controller.index,
          onDestinationSelected: (index) {
            controller.changeIndex(index);
          },
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          indicatorColor: AppTheme.appTheme,
          labelTextStyle: WidgetStateTextStyle.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return TextStyle(
                backgroundColor: AppTheme.appTheme,
                color: Colors.white,
              );
            }
            return TextStyle();
          }),

          destinations: [
            NavigationDestination(
              icon: Icon(Icons.task_outlined),
              label: 'New Task',
            ),
            NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
            NavigationDestination(
              icon: Icon(Icons.cancel_outlined),
              label: 'Canceled',
            ),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          ],
        );
      },
    );
  }
}
