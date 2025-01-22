class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registrationUrl = '$_baseUrl/registration';
  static const String logInUrl = '$_baseUrl/logIn';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';
  static String taskListByStatusUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';
  static const String addNewTaskUrl = '$_baseUrl/addNewTask';
  static const String updateProfileUrl = '$_baseUrl/updateProfile';
  static const String deleteTaskUrl = '$_baseUrl/deleteTask';
  static String recoverVerifyEmailUrl(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String recoverVerifyOtpUrl(String otp, String email) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static const String recoverResetPassUrl = '$_baseUrl/RecoverResetPass';
}