import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/error_handler.dart';
import '../model/disease_prediction_model.dart';
import '../model/treatment_model.dart';

class HomeRepo {
  final Dio _dio;

  HomeRepo(this._dio);

  Future<DiseasePredictionModel?> uploadImage(File image) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await _dio.post(
        ApiConstants.predictDisease,
        data: formData,
      );

      if (response.statusCode == 200) {
        return DiseasePredictionModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      throw Exception(errorModel.message);
    }
  }

  Future<TreatmentModel?> getTreatment(String disease, String languageCode) async {
    try {
      final response = await _dio.get(
        ApiConstants.getTreatment,
        queryParameters: {
          "disease": disease,
          "language": languageCode,
        },
      );

      if (response.statusCode == 200 && response.data['succeeded'] == true) {
        return TreatmentModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? "Unknown error occurred");
      }
    } catch (e) {
      final errorModel = ApiErrorHandler.handle(e);
      throw Exception(errorModel.message);
    }
  }
}
