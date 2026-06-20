import 'package:dio/dio.dart';

class ForgetPasswordRepo {
  static final Dio dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<String?> sendResetPasswordCode({required String email}) async {
    try {
      final response = await dio.post(
        "https://fsm.tryasp.net/Api/V1/Authentication/SendResetPasswordCode",
        data: {"Email": email},
      );
      if (response.statusCode == 200) {
        if (response.data['succeeded'] == true) {
          return null; // Success
        } else {
          return response.data['message'] ?? "Failed to send code";
        }
      } else {
        return "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map) {
          return data['message']?.toString() ?? "Error: ${e.response!.statusCode}";
        }
        return "Error: ${e.response!.statusCode}";
      }
      return "Connection error. Check your internet.";
    } catch (e) {
      return "An error occurred. Please try again.";
    }
  }

  static Future<String?> confirmCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await dio.post(
        "https://fsm.tryasp.net/Api/V1/Authentication/ConfirmResetPasswordCode",
        data: {
          "Email": email,
          "Code": code,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['succeeded'] == true) {
          return null; // Success
        } else {
          return response.data['message'] ?? "Invalid code";
        }
      } else {
        return "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map) {
          return data['message']?.toString() ?? "Error: ${e.response!.statusCode}";
        }
        return "Error: ${e.response!.statusCode}";
      }
      return "Connection error. Check your internet.";
    } catch (e) {
      return "An error occurred. Please try again.";
    }
  }

  static Future<String?> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        "https://fsm.tryasp.net/Api/V1/Authentication/ResetPassword",
        data: {
          "Email": email,
          "Code": code,
          "Password": newPassword,
          "ConfirmPassword": newPassword,
        },
      );
      if (response.statusCode == 200) {
        if (response.data['succeeded'] == true) {
          return null; // Success
        } else {
          return response.data['message'] ?? "Failed to reset password";
        }
      } else {
        return "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map) {
          return data['message']?.toString() ?? "Error: ${e.response!.statusCode}";
        }
        return "Error: ${e.response!.statusCode}";
      }
      return "Connection error. Check your internet.";
    } catch (e) {
      return "An error occurred. Please try again.";
    }
  }
}
