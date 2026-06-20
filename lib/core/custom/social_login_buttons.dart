// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SocialLoginButtons extends StatelessWidget {
//   const SocialLoginButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildSocialButton(
//           Image.asset(
//             'assets/icons/icon_google.png',
//             height: 24.h,
//             width: 24.w,
//           ),
//           onTap: () {
//             // Handle Google Login
//           },
//         ),
//         SizedBox(width: 25.w),
//         _buildSocialButton(
//           Image.asset('assets/icons/icon_appel.png', height: 24.h, width: 24.w),
//           onTap: () {
//             // Handle Apple Login
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialButton(Widget image, {required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60.h,
//         width: 60.w,
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15.r),
//         ),
//         child: image,
//       ),
//     );
//   }
// }
