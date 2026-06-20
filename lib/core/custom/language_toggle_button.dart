import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageToggleButton extends StatefulWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const LanguageToggleButton({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  State<LanguageToggleButton> createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  bool _isTranslating = false;

  @override
  Widget build(BuildContext context) {
    final localization = FlutterLocalization.instance;
    final currentLocale = localization.currentLocale;
    final isAr = currentLocale?.languageCode == 'ar';

    final defaultBg = Colors.black.withOpacity(0.3);
    final defaultText = Colors.white;
    final defaultBorder = Colors.white.withOpacity(0.5);

    return GestureDetector(
      onTap: _isTranslating
          ? null
          : () async {
              setState(() {
                _isTranslating = true;
              });
              try {
                localization.translate(isAr ? 'en' : 'ar');
                await Future.delayed(const Duration(milliseconds: 500));
              } catch (_) {
                // Ignore errors
              } finally {
                if (mounted) {
                  setState(() {
                    _isTranslating = false;
                  });
                }
              }
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? defaultBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: widget.borderColor ?? defaultBorder,
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isAr ? '🇪🇬' : '🇺🇸',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 6.w),
            Text(
              isAr ? 'العربية' : 'EN',
              style: TextStyle(
                color: widget.textColor ?? defaultText,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
