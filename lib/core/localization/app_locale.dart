mixin AppLocale {
  // Title
  static const String appName = 'appName';

  // Welcome Screen
  static const String welcomeTitle = 'welcomeTitle';
  static const String welcomeSubtitle1 = 'welcomeSubtitle1';
  static const String welcomeSubtitle2 = 'welcomeSubtitle2';
  static const String welcomeSubtitle3 = 'welcomeSubtitle3';

  // Info Screen
  static const String infoTitle = 'infoTitle';
  static const String infoSubtitle = 'infoSubtitle';
  static const String getStarted = 'getStarted';

  // Feature Screen
  static const String ourFeatures = 'ourFeatures';
  static const String earlyDetectionTitle = 'earlyDetectionTitle';
  static const String earlyDetectionDesc = 'earlyDetectionDesc';
  static const String aiDiagnosisTitle = 'aiDiagnosisTitle';
  static const String aiDiagnosisDesc = 'aiDiagnosisDesc';
  static const String readyTreatmentTitle = 'readyTreatmentTitle';
  static const String readyTreatmentDesc = 'readyTreatmentDesc';
  static const String signIn = 'signIn';
  static const String signUp = 'signUp';

  // Sign In Screen
  static const String email = 'email';
  static const String emailHint = 'emailHint';
  static const String password = 'password';
  static const String passwordHint = 'passwordHint';
  static const String forgotPassword = 'forgotPassword';
  static const String dontHaveAccount = 'dontHaveAccount';

  // Sign Up Screen
  static const String username = 'username';
  static const String confirmPassword = 'confirmPassword';
  static const String confirmPasswordHint = 'confirmPasswordHint';
  static const String alreadyHaveAccount = 'alreadyHaveAccount';

  // Forget Password
  static const String forgotPasswordTitle = 'forgotPasswordTitle';
  static const String forgetPasswordDesc = 'forgetPasswordDesc';
  static const String resetPassword = 'resetPassword';
  static const String verificationCode = 'verificationCode';
  static const String otpDesc = 'otpDesc';
  static const String verify = 'verify';
  static const String createNewPassword = 'createNewPassword';
  static const String newPasswordDesc = 'newPasswordDesc';
  static const String confirmNewPassword = 'confirmNewPassword';
  static const String updatePassword = 'updatePassword';
  static const String rememberPassword = 'rememberPassword';
  static const String login = 'login';
  static const String pleaseEnterEmail = 'pleaseEnterEmail';
  static const String pleaseEnterOtp = 'pleaseEnterOtp';
  static const String savePassword = 'savePassword';
  static const String passwordsDoNotMatch = 'passwordsDoNotMatch';
  static const String pleaseFillAllFields = 'pleaseFillAllFields';
  static const String passwordResetSuccess = 'passwordResetSuccess';

  // Home Screen
  static const String chooseImageSource = 'chooseImageSource';
  static const String camera = 'camera';
  static const String gallery = 'gallery';
  static const String files = 'files';
  static const String close = 'close';
  static const String disease = 'disease';
  static const String getTreatment = 'getTreatment';
  static const String mlModel = 'mlModel';
  static const String mlModelDesc = 'mlModelDesc';
  static const String water = 'water';
  static const String waterDesc = 'waterDesc';
  static const String airflow = 'airflow';
  static const String airflowDesc = 'airflowDesc';
  static const String sanitation = 'sanitation';
  static const String sanitationDesc = 'sanitationDesc';
  static const String preventionTips = 'preventionTips';
  static const String monitorHealth = 'monitorHealth';
  static const String useFungicides = 'useFungicides';
  static const String pruneDead = 'pruneDead';
  static const String uploadImage = 'uploadImage';
  static const String logout = 'logout';
  static const String treatment = 'treatment';
  static const String error = 'error';
  static const String failedToPredict = 'failedToPredict';
  static const String failedToFetchTreatment = 'failedToFetchTreatment';

  static const Map<String, dynamic> EN = {
    appName: 'BerryBeat',
    welcomeTitle: 'Detect Early,\nKeep the Beat\nHealthy',
    welcomeSubtitle1: 'Detect Early,\nKeep the ',
    welcomeSubtitle2: 'Beat',
    welcomeSubtitle3: '\nHealthy',
    infoTitle: 'The system that applies artificial intelligence in agriculture',
    infoSubtitle:
        'Through this work, we seek smarter farming practices, improved crop quality, and reduced agricultural losses.',
    getStarted: 'Get Started',
    ourFeatures: 'our features',
    earlyDetectionTitle: 'early detection',
    earlyDetectionDesc:
        'We detect strawberry diseases and nutrient deficiencies at an early stage before they spread and cause serious damage.',
    aiDiagnosisTitle: 'Accurate AI Diagnosis',
    aiDiagnosisDesc:
        'Upload a plant image and our program analyzes the symptoms to identify the exact problem quickly and accurately.',
    readyTreatmentTitle: 'Ready Treatment',
    readyTreatmentDesc:
        'Once the issue is detected, we provide clear, ready-to-apply treatment recommendations to restore plant health.',
    signIn: 'Sign In',
    signUp: 'Sign Up',
    email: 'Email',
    emailHint: 'Enter your email',
    password: 'Password',
    passwordHint: 'Enter your password',
    forgotPassword: 'Forgot Password?',
    dontHaveAccount: 'Don\'t have an account?',
    username: 'Username',
    confirmPassword: 'Confirm Password',
    confirmPasswordHint: 'Confirm your password',
    alreadyHaveAccount: 'Already have an account?',
    forgotPasswordTitle: 'Forgot Password',
    forgetPasswordDesc: 'Enter your email to receive a reset code.',
    resetPassword: 'Send Code',
    verificationCode: 'Verification Code',
    otpDesc: 'Enter the 6-digit code sent to your email.',
    verify: 'Verify Code',
    createNewPassword: 'Create New Password',
    newPasswordDesc:
        'Your new password must be different from previous used passwords.',
    confirmNewPassword: 'Confirm New Password',
    updatePassword: 'Reset Password',
    rememberPassword: 'Remember Password? ',
    login: 'Login',
    pleaseEnterEmail: 'Please enter your email',
    pleaseEnterOtp: 'Please enter the 6-digit code',
    savePassword: 'Save Password',
    passwordsDoNotMatch: 'Passwords do not match',
    pleaseFillAllFields: 'Please fill all fields',
    passwordResetSuccess: 'Password reset successfully',
    chooseImageSource: 'Choose Image Source',
    camera: 'Camera',
    gallery: 'Gallery',
    files: 'Files',
    close: 'Close',
    disease: 'Disease',
    getTreatment: 'Get Treatment',
    mlModel: 'Machine Learning Model',
    mlModelDesc:
        'An advanced machine learning model trained to detect strawberry diseases and provide treatment options.',
    water: 'Water',
    waterDesc: 'Manage irrigation to prevent excess moisture on fruits.',
    airflow: 'Airflow',
    airflowDesc: 'Ensure proper spacing for ventilation between plants.',
    sanitation: 'Sanitation',
    sanitationDesc: 'Remove infected parts immediately to stop the spread.',
    preventionTips: 'Prevention Tips',
    monitorHealth: 'Monitor plant health daily',
    useFungicides: 'Use organic fungicides',
    pruneDead: 'Prune dead leaves regularly',
    uploadImage: 'Upload Image',
    logout: 'Logout',
    treatment: 'Treatment',
    error: 'Error',
    failedToPredict: 'Failed to predict disease. Please try again.',
    failedToFetchTreatment: 'Failed to fetch treatment. Please try again.',
  };

  static const Map<String, dynamic> AR = {
    appName: 'بيري بيت',
    welcomeTitle: 'تشخيص مبكر\nلحياة تنبض\nبالصحة',
    welcomeSubtitle1: 'تشخيص مبكر\nلحياة تنبض بـ ',
    welcomeSubtitle2: 'الصحة',
    welcomeSubtitle3: '',
    infoTitle: 'النظام الذي يطبق الذكاء الاصطناعي في الزراعة',
    infoSubtitle:
        '. من خلال هذا العمل، نسعى إلى ممارسات زراعية أكثر ذكاءً، وتحسين جودة المحاصيل، وتقليل الخسائر الزراعية',
    getStarted: 'ابدأ الآن',
    ourFeatures: 'مميزاتنا',
    earlyDetectionTitle: 'الكشف المبكر',
    earlyDetectionDesc:
        'نكتشف أمراض الفراولة ونقص العناصر الغذائية في مرحلة مبكرة قبل أن تنتشر وتسبب أضراراً جسيمة',
    aiDiagnosisTitle: 'تشخيص دقيق بالذكاء الاصطناعي',
    aiDiagnosisDesc:
        'قم بتحميل صورة النبات ويقوم برنامجنا بتحليل الأعراض لتحديد المشكلة بالضبط بسرعة ودقة',
    readyTreatmentTitle: 'علاج جاهز',
    readyTreatmentDesc:
        '  بمجرد اكتشاف المشكلة، نقدم توصيات علاجية واضحة وجاهزة للتطبيق لاستعادة صحة النبات',
    signIn: 'تسجيل الدخول',
    signUp: 'إنشاء حساب',
    email: 'البريد الإلكتروني',
    emailHint: 'أدخل بريدك الإلكتروني',
    password: 'كلمة المرور',
    passwordHint: 'أدخل كلمة المرور الخاصة بك',
    forgotPassword: 'هل نسيت كلمة المرور؟',
    dontHaveAccount: 'ليس لديك حساب؟',
    username: 'اسم المستخدم',
    confirmPassword: 'تأكيد كلمة المرور',
    confirmPasswordHint: 'تأكيد كلمة المرور الخاصة بك',
    alreadyHaveAccount: 'لديك حساب بالفعل؟',
    forgotPasswordTitle: 'نسيت كلمة المرور',
    forgetPasswordDesc: 'أدخل بريدك الإلكتروني لتلقي رمز إعادة التعيين.',
    resetPassword: 'إرسال الرمز',
    verificationCode: 'رمز التحقق',
    otpDesc: 'أدخل الرمز المكون من 6 أرقام المرسل إلى بريدك الإلكتروني.',
    verify: 'التحقق من الرمز',
    createNewPassword: 'إنشاء كلمة مرور جديدة',
    newPasswordDesc:
        'يجب أن تكون كلمة المرور الجديدة مختلفة عن كلمات المرور السابقة المستخدمة.',
    confirmNewPassword: 'تأكيد كلمة المرور الجديدة',
    updatePassword: 'إعادة تعيين كلمة المرور',
    rememberPassword: 'تذكرت كلمة المرور؟ ',
    login: 'تسجيل الدخول',
    pleaseEnterEmail: 'الرجاء إدخال البريد الإلكتروني',
    pleaseEnterOtp: 'الرجاء إدخال الرمز المكون من 6 أرقام',
    savePassword: 'حفظ كلمة المرور',
    passwordsDoNotMatch: 'كلمات المرور غير متطابقة',
    pleaseFillAllFields: 'الرجاء ملء جميع الحقول',
    passwordResetSuccess: 'تمت إعادة تعيين كلمة المرور بنجاح',
    chooseImageSource: 'اختر مصدر الصورة',
    camera: 'الكاميرا',
    gallery: 'المعرض',
    files: 'الملفات',
    close: 'إغلاق',
    disease: 'المرض',
    getTreatment: 'الحصول على العلاج',
    mlModel: 'نموذج تعلم الآلة',
    mlModelDesc: 'نموذج تعلم آلة متطور مدرب لتشخيص أمراض الفراولة وتقديم إرشادات العلاج المناسبة.',
    water: 'الماء',
    waterDesc: 'إدارة الري لمنع زيادة الرطوبة على الثمار',
    airflow: 'تدفق الهواء',
    airflowDesc: 'تأكد من وجود مسافات مناسبة للتهوية بين النباتات',
    sanitation: 'النظافة والتعقيم',
    sanitationDesc: 'أزل الأجزاء المصابة فوراً لوقف انتشار المرض',
    preventionTips: 'نصائح الوقاية',
    monitorHealth: 'مراقبة صحة النبات يومياً',
    useFungicides: 'استخدم مبيدات فطريات عضوية',
    pruneDead: 'تقليم الأوراق الميتة بانتظام',
    uploadImage: 'تحميل صورة',
    logout: 'تسجيل الخروج',
    treatment: 'العلاج',
    error: 'خطأ',
    failedToPredict: 'فشل في تحديد المرض. يرجى المحاولة مرة أخرى',
    failedToFetchTreatment: 'فشل في جلب العلاج. يرجى المحاولة مرة أخرى',
  };
}
