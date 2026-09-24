class ApiConstants {
  static const String baseUrl = 'https://fsm.tryasp.net/';
  static const String aiBaseUrl = 'https://riboku314-straberry-space.hf.space/';

  // Endpoints
  static const String signIn = 'Api/V1/Authentication/SignIn';
  static const String signUp = 'api/ApplicationUser/Api/V1/User/Create';
  static const String sendResetPasswordCode =
      'Api/V1/Authentication/SendResetPasswordCode';
  static const String confirmResetPasswordCode =
      'Api/V1/Authentication/ConfirmResetPasswordCode';
  static const String resetPassword = 'Api/V1/Authentication/ResetPassword';
  static const String predictDisease =
      'https://riboku314-straberry-space.hf.space/predict';
  static const String getTreatment = 'api/TreatMent/get-treatment';

  // Headers & Options
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';

  // Timeout durations
  static const Duration apiTimeout = Duration(seconds: 30);
}
