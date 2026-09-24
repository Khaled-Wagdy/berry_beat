import 'package:dio/dio.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/error_handler.dart';

class ForgetPasswordRepo {
  final Dio _dio;

  ForgetPasswordRepo(this._dio);

  Future<String?> sendResetPasswordCode({required String email}) async {
    try {
      final response = await _dio.post(
        ApiConstants.sendResetPasswordCode,
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
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      return errorModel.message;
    }
  }

  Future<String?> confirmCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.confirmResetPasswordCode,
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
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      return errorModel.message;
    }
  }

  Future<String?> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.resetPassword,
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
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      return errorModel.message;
    }
  }
}
