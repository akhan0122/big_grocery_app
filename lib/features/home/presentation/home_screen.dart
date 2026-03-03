import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/text_values.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/widgets/custom_curve_clipper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ClipPath(
//                   clipper: InwardBottomClipper(),
//                   child: PageView.builder(
//                     controller: controller.pageController,
//                     itemCount: controller.imagesList.length,
//                     itemBuilder: (_, index) => Image.asset(
//                       controller.imagesList[index],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Center(
//               child: AppText(
//                 text: TextValues.welcomeMessage,
//                 fontSize: 28.sp,
//                 fontWeight: FontWeight.bold,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 30.h),
//             Center(
//               child: AppText(
//                 text:
//                     "Lorem ipsum dolor sit amet,consetetur\n sadipscing elitr, sed diam nonumy",
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w500,
//                 textAlign: TextAlign.center,
//                 color: AppColors.hintFont,
//               ),
//             ),
//             SizedBox(height: 30.h),
//             GetBuilder<HomeController>(
//               builder: (controller) {
//                 return Center(
//                   child: DotsIndicator(
//                     dotsCount: controller.imagesList.length,
//                     position: controller.currentPage.toDouble(),
//                     decorator: DotsDecorator(
//                       activeColor: AppColors.primaryDark,
//                       color: AppColors.primary,
//                       size: const Size.square(9.0),
//                       activeSize: const Size(18.0, 9.0),
//                       activeShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 15.0,
//                 vertical: 20,
//               ),
//               child: AppElevatedButton(
//                 onPressed: controller.nextPage,
//                 title: TextValues.next,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Android
        statusBarBrightness: Brightness.light, // iOS (light bg -> dark icons)
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Top image goes behind status bar
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipPath(
                  clipper: InwardBottomClipper(),
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.imagesList.length,
                    itemBuilder: (_, index) => Image.asset(
                      controller.imagesList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // ✅ Bottom content stays within safe area
            SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: AppText(
                      text: TextValues.welcomeMessage,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: AppText(
                      text:
                          "Lorem ipsum dolor sit amet,consetetur\n sadipscing elitr, sed diam nonumy",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      color: AppColors.hintFont,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  GetBuilder<HomeController>(
                    builder: (controller) {
                      return Center(
                        child: DotsIndicator(
                          dotsCount: controller.imagesList.length,
                          position: controller.currentPage.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: AppColors.primaryDark,
                            color: AppColors.primary,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: AppElevatedButton(
                      onPressed: controller.nextPage,
                      title: TextValues.next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
