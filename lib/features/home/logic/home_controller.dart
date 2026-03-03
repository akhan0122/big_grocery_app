import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt cartItems = 0.obs;
  int currentPage = 0;
  void addItem() {
    cartItems.value++;
  }

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (currentPage != page) {
        currentPage = page;
        update(); // triggers GetBuilder to rebuild
      }
    });
  }

  final List<String> imagesList = [
    AssetPng.landingPage1,
    AssetPng.landingPage2,
    AssetPng.landingPage3,
    AssetPng.landingPage4,
  ];
  final PageController pageController = PageController();
  void nextPage() {
    if (currentPage < imagesList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      AppRouter.go(AppRoutes.authentication);
    }
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}

