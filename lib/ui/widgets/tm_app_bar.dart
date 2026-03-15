import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controller/auth_controller.dart';
import 'package:task_manager_with_getx/ui/screens/sign_in_screen.dart';
import 'package:task_manager_with_getx/ui/screens/update_profile_screen.dart';

import '../utils/app_theme/app_theme.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  TmAppBar({super.key, this.isProfileUpdate = false});

  final bool isProfileUpdate;
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (!isProfileUpdate) {
          Get.toNamed(UpdateProfileScreen.name);
        }
      },
      child: AppBar(
        backgroundColor: AppTheme.appTheme,
        title: GetBuilder<AuthController>(
          builder: (controller) {
            return Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: MemoryImage(
                      base64Decode(controller.userModel?.photo??'')

                  ),
                  onBackgroundImageError: (_, __) => Icon(Icons.person),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userModel?.fullName ?? ' ',
                        style: textheme.titleSmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        controller.userModel?.email ?? ' ',
                        style: textheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await authController.clearData();
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
