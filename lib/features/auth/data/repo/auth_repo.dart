import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/error_handler.dart';

class AuthRepo {
  final Dio _dio;

  AuthRepo(this._dio);

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.signIn,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 && response.data['succeeded'] == true) {
        final String token = response.data['data']['accessToken'];
        await saveUserToken(token);
        return null;
      } else {
        return response.data['message'] ?? "Unknown error occurred";
      }
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      return errorModel.message;
    }
  }

  Future<String?> signUp({
    required String? fullName,
    required String userName,
    required String email,
    required String? country,
    required String? phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.signUp,
        data: {
          "fullName": fullName,
          "userName": userName,
          "email": email,
          "country": country,
          "phoneNumber": phoneNumber,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          String? token = responseData['token'];
          if (token == null && responseData['data'] is Map<String, dynamic>) {
            token = responseData['data']['token'];
          }
          if (token != null) {
            await saveUserToken(token);
          }
          if (responseData['succeeded'] == false) {
            return responseData['message'] ?? "Signup failed";
          }
        }
        return null;
      } else {
        return "Unknown error occurred";
      }
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      return errorModel.message;
    }
  }

  Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
