/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/utils/app_color.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../controllers/auth_controller.dart';
import '../screens/sign_in_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    required this.textTheme,
    this.fromUpdateProfile = false,
  });

  final TextTheme textTheme;
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: authController.userModel?.photo != null &&
                    authController.userModel!.photo!.isNotEmpty
                ? MemoryImage(base64Decode(authController.userModel!.photo!))
                : null,
            child: authController.userModel?.photo == null ||
                    authController.userModel!.photo!.isEmpty
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (fromUpdateProfile == false) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.userModel?.fullName ?? '',
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  Text(
                    authController.userModel?.email ?? '',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _logOutFromTaskListScreen(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _logOutFromTaskListScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () async {
                final AuthController authController =
                    Get.find<AuthController>();

                await authController.clearUserData();

                showSnackBarMessage(context, 'Logged Out successfully');

                Get.offAllNamed(SignInScreen.name);
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/utils/app_color.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../controllers/auth_controller.dart';
import '../screens/sign_in_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    required this.textTheme,
    this.fromUpdateProfile = false,
  });

  final TextTheme textTheme;
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: (authController.userModel?.photo != null &&
                authController.userModel!.photo!.isNotEmpty)
                ? MemoryImage(base64Decode(authController.userModel!.photo!))
                : null,
            child: (authController.userModel?.photo == null ||
                authController.userModel!.photo!.isEmpty)
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!fromUpdateProfile) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.userModel?.fullName ?? 'Guest',
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    authController.userModel?.email ?? 'No Email',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: 'Log Out',
            onPressed: () => _logOutFromTaskListScreen(context),
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _logOutFromTaskListScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () async {
                final AuthController authController =
                Get.find<AuthController>();

                await authController.clearUserData();

                showSnackBarMessage(context, 'You have been logged out.');

                Get.offAllNamed(SignInScreen.name);
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
