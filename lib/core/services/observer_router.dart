// lib/core/routes/app_router_observer.dart

import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biggroceryapp/features/splash/logic/splash_controller.dart';
import 'package:biggroceryapp/features/landing/logic/landing_controller.dart';
import 'package:biggroceryapp/features/authentication/logic/authentication_controller.dart';

class AppRouterObserver extends NavigatorObserver {
  // WHY didPop: fires when user goes BACK (pops a screen)
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _deleteController(route.settings.name);
  }

  // WHY didReplace: fires when screen REPLACES another
  // example: splash.go(home) — splash is replaced, not popped
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _deleteController(oldRoute?.settings.name);
  }

  // WHY didRemove: fires when screen removed from stack
  // example: Get.offAll() removes everything
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _deleteController(route.settings.name);
  }

  // single cleanup method — all disposal logic lives here
  void _deleteController(String? routeName) {
    if (routeName == null) return;

    switch (routeName) {
      case 'splash':
        _delete<SplashController>();
        break;
      case 'home':
        _delete<HomeController>();
        break;
      case 'landing':
        _delete<LandingController>();
        break;
      case 'authentication':
      case 'login':
      case 'register':
        // WHY: only delete auth controller when leaving
        // the ENTIRE auth flow, not between auth screens
        final goingToAuth =
            Get.currentRoute == '/authentication' ||
            Get.currentRoute == '/login' ||
            Get.currentRoute == '/register';

        if (!goingToAuth) {
          _delete<AuthenticationController>();
        }
        break;
    }
  }

  // safe delete — won't crash if controller already gone
  void _delete<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>(force: true);
    }
  }
}
