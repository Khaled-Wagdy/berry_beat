class TreatmentModel {
  final String title;
  final String description;

  TreatmentModel({required this.title, required this.description});

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return TreatmentModel(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
