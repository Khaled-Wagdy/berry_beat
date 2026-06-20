import 'dart:io';
import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:bery_beat/features/home/cubit/home_cubit.dart';
import 'package:bery_beat/features/home/cubit/home_state.dart';
import 'package:bery_beat/features/home/data/model/disease_prediction_model.dart';
import 'package:bery_beat/features/home/ui/widgets/feature_tile.dart';
import 'package:bery_beat/features/home/ui/widgets/prevention_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' hide ImageSource;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocale.chooseImageSource.getString(context),
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF134E3D),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().pickImage(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      AppLocale.camera.getString(context),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22B387),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      AppLocale.gallery.getString(context),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22B387),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomeCubit>().pickFile();
                    },
                    icon: const Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      AppLocale.files.getString(context),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22B387),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTreatmentDialog(BuildContext context, String title, String desc) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF134E3D),
            ),
          ),
          content: SingleChildScrollView(
            child: HtmlWidget(
              desc,
              textStyle: GoogleFonts.poppins(fontSize: 14.sp),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocale.close.getString(context),
                style: GoogleFonts.poppins(
                  color: const Color(0xFF22B387),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9EBEF),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is HomeTreatmentSuccess) {
              _showTreatmentDialog(
                context,
                state.treatment.title.isEmpty
                    ? AppLocale.treatment.getString(context)
                    : state.treatment.title,
                state.treatment.description,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Banner Image
                  Stack(
                    children: [
                      Container(
                        height: 220.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/image/strawberry_image.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 20.w,
                        child: Text(
                          'BerryBeat',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              const Shadow(
                                blurRadius: 10,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        right: 20.w,
                        child: const LanguageToggleButton(),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is HomePredictionSuccess ||
                            state is HomeTreatmentLoading ||
                            state is HomeTreatmentSuccess) ...[
                          // Display Uploaded Image
                          Builder(
                            builder: (context) {
                              File? imageFile;
                              DiseasePredictionModel? predictionData;
                              if (state is HomePredictionSuccess) {
                                imageFile = state.image;
                                predictionData = state.prediction;
                              } else if (state is HomeTreatmentLoading) {
                                imageFile = state.image;
                                predictionData = state.prediction;
                              } else if (state is HomeTreatmentSuccess) {
                                imageFile = state.image;
                                predictionData = state.prediction;
                              }

                              return Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Image.file(
                                      imageFile!,
                                      height: 200.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  // Prediction Hint Section
                                  Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                        color: const Color(0xFF22B387),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.health_and_safety,
                                              color: const Color(0xFF134E3D),
                                              size: 30.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Text(
                                                '${AppLocale.disease.getString(context)}: ${predictionData!.prediction}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF134E3D,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.h),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 45.h,
                                          child: ElevatedButton(
                                            onPressed:
                                                state is HomeTreatmentLoading
                                                ? null
                                                : () {
                                                    context
                                                        .read<HomeCubit>()
                                                        .getTreatment(
                                                          imageFile!,
                                                          predictionData!,
                                                        );
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF134E3D,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            child: state is HomeTreatmentLoading
                                                ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                : Text(
                                                    AppLocale.getTreatment.getString(context),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 25.h),
                        ],

                        // Machine Learning Model Section
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.asset(
                                  'assets/image/featuers_image.png',
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocale.mlModel.getString(context),
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF134E3D),
                                      ),
                                    ),
                                    Text(
                                      AppLocale.mlModelDesc.getString(context),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 25.h),

                        // Features List
                        FeatureTile(
                          title: AppLocale.water.getString(context),
                          desc: AppLocale.waterDesc.getString(context),
                          icon: Icons.water_drop,
                        ),
                        FeatureTile(
                          title: AppLocale.airflow.getString(context),
                          desc: AppLocale.airflowDesc.getString(context),
                          icon: Icons.air,
                        ),
                        FeatureTile(
                          title: AppLocale.sanitation.getString(context),
                          desc: AppLocale.sanitationDesc.getString(context),
                          icon: Icons.clean_hands,
                        ),

                        SizedBox(height: 25.h),

                        // Prevention Tips Header
                        Center(
                          child: Text(
                            AppLocale.preventionTips.getString(context),
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF134E3D),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // Prevention Cards Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PreventionCard(
                              icon: Icons.favorite,
                              text: AppLocale.monitorHealth.getString(context),
                            ),
                            PreventionCard(
                              icon: Icons.park,
                              text: AppLocale.useFungicides.getString(context),
                            ),
                            PreventionCard(
                              icon: Icons.content_cut,
                              text: AppLocale.pruneDead.getString(context),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.h),

                        // Upload Button
                        SizedBox(
                          width: double.infinity,
                          height: 55.h,
                          child: ElevatedButton(
                            onPressed: state is HomeLoading
                                ? null
                                : () => _showImageSourceDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22B387),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                              elevation: 5,
                            ),
                            child: state is HomeLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    AppLocale.uploadImage.getString(context),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: AppBottom(
                            text: AppLocale.logout.getString(context),
                            barColor: Colors.red,
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('token');
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.welcomeScreen,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
