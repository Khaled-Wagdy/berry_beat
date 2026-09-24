import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bery_beat/features/home/data/repo/home_repo.dart';
import 'package:bery_beat/features/home/data/model/disease_prediction_model.dart';
import 'package:bery_beat/features/home/data/model/treatment_model.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final ImagePicker _picker = ImagePicker();

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        emit(HomeImagePicked(imageFile));
        await uploadImage(imageFile);
      }
    } catch (e) {
      emit(HomeError("Failed to pick image: ${e.toString()}"));
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.single.path != null) {
        File imageFile = File(result.files.single.path!);
        emit(HomeImagePicked(imageFile));
        await uploadImage(imageFile);
      }
    } catch (e) {
      emit(HomeError("Failed to pick file: ${e.toString()}"));
    }
  }

  Future<void> uploadImage(File image) async {
    try {
      emit(HomeLoading());
      final prediction = await _homeRepo.uploadImage(image);
      if (prediction != null) {
        emit(HomePredictionSuccess(image, prediction));
      } else {
        emit(HomeError("Failed to predict disease. Please try again."));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> getTreatment(File image, DiseasePredictionModel prediction) async {
    try {
      emit(HomeTreatmentLoading(image, prediction));
      final String languageCode = FlutterLocalization.instance.currentLocale?.languageCode ?? 'en';
      
      TreatmentModel? treatment;
      try {
        treatment = await _homeRepo.getTreatment(prediction.prediction, languageCode);
      } catch (e) {
        treatment = null;
      }
      
      if (treatment == null || treatment.title.isEmpty || treatment.description.isEmpty) {
        treatment = _getLocalTreatmentFallback(
          prediction.prediction,
          languageCode,
          treatment ?? TreatmentModel(title: '', description: ''),
        );
      }
      
      emit(HomeTreatmentSuccess(image, prediction, treatment));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  TreatmentModel _getLocalTreatmentFallback(String disease, String languageCode, TreatmentModel original) {
    final isAr = languageCode == 'ar';
    final diseaseNormalized = disease.toLowerCase().trim();
    
    if (diseaseNormalized.contains('spot')) {
      return TreatmentModel(
        title: isAr ? 'تبقع الأوراق (Leaf Spot)' : 'Leaf Spot',
        description: isAr 
            ? "- الوقاية: استخدام شتلات صحية ومعتمدة، وإزالة مخلفات المحاصيل، وإدارة الري والتغذية لتقليل إجهاد النبات.   \r\n\r\n- العلاج: رش مبيدات فطريات تلامسية واسعة المدى (مثل كابتان أو مانكوزيب) أو مبيد فطريات جهازي معتمد لتبقع الأوراق، وإزالة الأوراق المصابة بشدة.   \r\n\r\n- ملاحظات: التناوب بين استخدام مبيدات الفطريات ذات طرق التأثير المختلفة لتقليل مخاطر مقاومة الفطريات للمبيد."
            : "- Prevention: Use healthy, certified transplants, remove crop residues, and manage irrigation and nutrition to reduce plant stress.   \r\n\r\n- Treatment: Apply broad-spectrum contact fungicides (e.g., captan or mancozeb) or a registered systemic fungicide for leaf spots; remove heavily infected leaves.   \r\n\r\n- Notes: Rotate fungicide modes of action to reduce resistance risk.",
      );
    } else if (diseaseNormalized.contains('anthracnose') || diseaseNormalized.contains('rot')) {
      return TreatmentModel(
        title: isAr ? 'عفن ثمار الأنثراكنوز (Anthracnose Fruit Rot)' : 'Anthracnose Fruit Rot',
        description: isAr
            ? "- الوقاية: زراعة شتلات خالية من الأمراض، وتقليل رطوبة الزهور والثمار، وتجنب ملامسة الثمار للتربة (باستخدام التغطية أو المالتش).   \r\n\r\n- العلاج: استخدام مبيدات الفطريات الفعالة ضد فطر كوليتوتريشوم (مثل ديفينوكونازول أو الستروبيلورين المناسب) وإزالة النباتات المصابة بشدة؛ معالجة شتلات المشتل إذا كان خطر الإصابة مرتفعاً.   \r\n\r\n- ملاحظات: اتبع فترة الأمان قبل الحصاد (PHI) المكتوبة على الملصق وقم بتدوير المواد الفعالة للمبيدات."
            : "- Prevention: Plant disease-free nursery stock, reduce wetness on flowers and fruit, and avoid contact between fruit and soil (use mulch).   \r\n\r\n- Treatment: Use fungicides effective against Colletotrichum (e.g., difenoconazole or suitable strobilurins) and remove severely infected plants; treat nursery material if infection risk is high.   \r\n\r\n- Notes: Follow label PHI (pre-harvest interval) and rotate active ingredients.",
      );
    } else if (diseaseNormalized.contains('mold') || diseaseNormalized.contains('botrytis') || diseaseNormalized.contains('grey') || diseaseNormalized.contains('gray')) {
      return TreatmentModel(
        title: isAr ? 'العفن الرمادي (Gray Mold)' : 'Gray Mold',
        description: isAr
            ? "- الوقاية: تحسين التهوية، وتجنب الرطوبة الطويلة على الزهور والثمار، وجمع وإتلاف المواد النباتية المصابة والثمار المحنطة.   \r\n\r\n- العلاج: إجراء رشات وقائية عند الإزهار وقبل الحصاد باستخدام منتجات مسجلة فعالة ضد فطر البوتريتيس (مثل خلطات بوسكاليد + بيراكلوستروبين أو فينهيكساميد) ودمج المكافحة الحيوية كبدائل للرش.   \r\n\r\n- ملاحظات: حدد وقت الرش حول فترات الرطوبة وفترة الإزهار؛ قم بإزالة الزهور/الثمار المصابة على الفور."
            : "- Prevention: Improve ventilation, avoid prolonged wetness on flowers/fruits, and collect and destroy infected plant material and mummified fruits.   \r\n\r\n- Treatment: Make protective sprays at flowering and pre-harvest using registered products effective against Botrytis (examples include boscalid + pyraclostrobin mixes or fenhexamid) and integrate biological controls as tank-mix alternatives.   \r\n\r\n- Notes: Time sprays around wet periods and bloom; remove infected flowers/fruit promptly.",
      );
    } else if (diseaseNormalized.contains('mildew')) {
      return TreatmentModel(
        title: isAr ? 'البياض الدقيقي (Powdery Mildew)' : 'Powdery Mildew',
        description: isAr
            ? "- الوقاية: منع ملامسة الثمار للتربة (باستخدام التغطية)، والحصاد الفوري، وتقليل الرطوبة حول الثمار مع ضمان تدفق هواء جيد.   \r\n\r\n- العلاج: استخدام مبيدات الفطريات الآمنة للاستخدام القريب من الحصاد (مثل تركيبات معينة من كابتان أو بوسكاليد المسجلة للثمار) ودمج المكافحة الحيوية؛ مع احترام فترات الأمان قبل الحصاد.   \r\n\r\n- ملاحظات: معالجة الإصابات في مرحلة الثمار تتطلب اتباع قيود الغسيل وفترة الأمان (PHI) بصرامة."
            : "- Prevention: Prevent fruit-soil contact (mulch), harvest promptly, and reduce humidity around fruit with good airflow.   \r\n\r\n- Treatment: Use fungicides safe for use close to harvest (e.g., certain captan or boscalid formulations registered for fruit) and incorporate biologicals; respect pre-harvest intervals.   \r\n\r\n- Notes: Treating fruit-stage infections requires strictly following wash/PHI restrictions.",
      );
    } else if (diseaseNormalized.contains('scorch')) {
      return TreatmentModel(
        title: isAr ? 'لفحة الأوراق (Leaf Scorch)' : 'Leaf Scorch',
        description: isAr
            ? "- الوقاية: زراعة أصناف مقاومة للمرض، وضمان التباعد الجيد بين النباتات لتحسين تدفق الهواء والتهوية، والري الصباحي لتجف الأوراق بسرعة.   \r\n\r\n- العلاج: إزالة الأوراق المصابة والتخلص منها بشكل آمن لمنع انتشار العدوى، ورش مبيدات الفطريات النحاسية أو المبيدات الفطرية الوقائية المسجلة عند ظهور الأعراض الأولى.   \r\n\r\n- ملاحظات: تجنب الإفراط في التسميد النيتروجيني الذي يشجع النمو الخضري الغض والحساس للمرض."
            : "- Prevention: Plant resistant cultivars, maintain optimal plant spacing to maximize airflow, and irrigate early in the day so foliage dries quickly.   \r\n\r\n- Treatment: Prune and destroy infected leaves to reduce inoculum load, and apply copper-based or protective fungicides at first sign of disease.   \r\n\r\n- Notes: Avoid excessive nitrogen fertilization which encourages lush, susceptible vegetative growth.",
      );
    }
    
    return original.title.isNotEmpty ? original : TreatmentModel(
      title: isAr ? 'علاج المرض' : 'Disease Treatment',
      description: isAr 
          ? 'الرجاء استشارة خبير زراعي للحصول على أفضل طريقة لعلاج هذا المرض.' 
          : 'Please consult an agricultural expert for the best way to treat this disease.',
    );
  }
}
