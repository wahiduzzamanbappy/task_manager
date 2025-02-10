import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/Cancelled_taskList_controller.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/controllers/completed_taskList_controller.dart';
import 'package:task_manager/ui/controllers/new_taskList_controller.dart';
import 'package:task_manager/ui/controllers/progress_taskList_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import 'package:task_manager/ui/controllers/task_count_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
import 'package:task_manager/ui/controllers/verify_email_controller.dart';
import 'package:task_manager/ui/controllers/verify_otp_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.put(VerifyEmailController());
    Get.put(VerifyOTPController());
    Get.put(NewTaskListController());
    Get.put(TaskCountByStatusController());
    Get.put(AddNewTaskController());
    Get.put(CompletedTaskListController());
    Get.put(ProgressTaskListController());
    Get.put(CancelledTaskListController());
    Get.put(UpdateProfileController());
  }
}
