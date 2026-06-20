class DiseasePredictionModel {
  final String filename;
  final String prediction;

  DiseasePredictionModel({required this.filename, required this.prediction});

  factory DiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return DiseasePredictionModel(
      filename: json['filename'] ?? '',
      prediction: json['prediction'] ?? '',
    );
  }
}
