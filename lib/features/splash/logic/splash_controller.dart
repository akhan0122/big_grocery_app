import 'dart:async';

import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer(const Duration(seconds: 2), () {
      AppRouter.router.go(AppRoutes.home);
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
