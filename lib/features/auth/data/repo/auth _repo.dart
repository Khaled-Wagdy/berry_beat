import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Dio dio = Dio();

  static Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "https://fsm.tryasp.net/Api/V1/Authentication/SignIn",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200 && response.data['succeeded'] == true) {
        final String token = response.data['data']['accessToken'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null;
      } else {
        return response.data['message'] ?? "Unknown error occurred";
      }
    } on DioException catch (e) {
      return e.response?.data?['message'] ?? "Connection error";
    } catch (e) {
      return "An error occurred. Please try again.";
    }
  }

  static Future<String?> signUp({
    required String? fullName,
    required String userName,
    required String email,

    required String? country,
    required String? phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.post(
        'https://fsm.tryasp.net/api/ApplicationUser/Api/V1/User/Create',
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
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        final errorData = e.response?.data;
        if (errorData?['message'] != null &&
            errorData?['message'].toString().isNotEmpty == true) {
          return errorData?['message'];
        }
        if (errorData?['errors'] is Map) {
          final Map errors = errorData?['errors'];
          if (errors.isNotEmpty) {
            return errors.values.first.first.toString();
          }
        }
      }
      return "Connection error";
    } catch (e) {
      return "An error occurred. Please try again.";
    }
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
