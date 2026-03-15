class Urls {
   static const String _baseUrl='https://task.teamrabbil.com/api/v1';
   static const String registrationUrl='$_baseUrl/registration';
   static const String loginUrl='$_baseUrl/login';
   static const String updateProfileUrl='$_baseUrl/profileUpdate';
   static const String createTaskUrl='$_baseUrl/createTask';
   static const String resetPasswordUrl='$_baseUrl/RecoverResetPass';
   static const String taskStatusCountUrl='$_baseUrl/taskStatusCount';
   static String taskListByStatusUrl(String status)=>'$_baseUrl/listTaskByStatus/$status';
   static String deleteTaskUrl(String sid)=>'$_baseUrl/deleteTask/$sid';
   static String verifyEmailUrl(String email)=>'$_baseUrl/RecoverVerifyEmail/$email';
   static String updateTaskStatusUrl(String sid,String status)=>'$_baseUrl/updateTaskStatus/$sid/$status';
   static String pinVerificationUrl(String email,String OTP)=>'$_baseUrl/RecoverVerifyOTP/$email/$OTP';

}