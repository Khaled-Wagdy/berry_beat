import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bery_beat/features/home/data/model/disease_prediction_model.dart';
import 'package:bery_beat/features/home/data/model/treatment_model.dart';

class HomeRepo {
  static Dio dio = Dio();

  static Future<DiseasePredictionModel?> uploadImage(File image) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await dio.post(
        "https://riboku314-straberry-space.hf.space/predict",
        data: formData,
      );

      if (response.statusCode == 200) {
        return DiseasePredictionModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }

  static Future<TreatmentModel?> getTreatment(String disease, String languageCode) async {
    try {
      final response = await dio.get(
        "https://fsm.tryasp.net/api/TreatMent/get-treatment",
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
      throw Exception("Failed to get treatment: $e");
    }
  }
}
