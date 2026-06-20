import 'package:dio/dio.dart';

void main() async {
  try {
    final dio = Dio();
    final response = await dio.post(
      'https://fsm.tryasp.net/Api/V1/Authentication/SignIn',
      data: {'email': 'testuser999@example.com', 'password': 'Password123!'},
    );
    print('Type of data: ${response.data.runtimeType}');
    print('Data: ${response.data}');
    print('succeeded: ${response.data['succeeded']}');
  } on DioException catch(e) {
    print('Dio Error: ${e.response?.statusCode}');
    print('Dio Error Data: ${e.response?.data}');
  } catch(e) {
    print('Error: $e');
  }
}
