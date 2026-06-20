import 'package:dio/dio.dart';
void main() async {
  try {
    final dio = Dio();
    final response = await dio.post(
      'https://fsm.tryasp.net/api/ApplicationUser/Api/V1/User/Create',
      data: {
        'fullName': 'test',
        'userName': 'test',
        'email': 'test@test.com',
        'password': '123',
        'confirmPassword': '123'
      },
    );
  } on DioException catch(e) {
    print('Dio Error Data: ${e.response?.data}');
  }
}
