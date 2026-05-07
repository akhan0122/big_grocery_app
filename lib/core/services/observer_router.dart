import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/authentication/logic/authentication_controller.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/landing/logic/landing_controller.dart';
import 'package:biggroceryapp/features/splash/logic/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouterObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _deleteController(route.settings.name, previousRoute?.settings.name);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _deleteController(oldRoute?.settings.name, newRoute?.settings.name);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _deleteController(route.settings.name, previousRoute?.settings.name);
  }

  void _deleteController(String? routeName, String? nextRouteName) {
    if (routeName == null) return;

    switch (routeName) {
      case 'splash':
        _delete<SplashController>();
        break;
      case 'home':
      case AppRoutes.homeScreen:
        _delete<HomeController>();
        break;
      case 'landing':
        _delete<LandingController>();
        break;
      case 'authentication':
      case 'login':
      case 'signup':
        if (!_isAuthRoute(nextRouteName)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_isAuthRoute(Get.currentRoute)) {
              _delete<AuthenticationController>();
            }
          });
        }
        break;
    }
  }

  bool _isAuthRoute(String? routeNameOrPath) {
    return routeNameOrPath == 'authentication' ||
        routeNameOrPath == 'login' ||
        routeNameOrPath == 'signup' ||
        routeNameOrPath == AppRoutes.authentication ||
        routeNameOrPath == AppRoutes.loginScreen ||
        routeNameOrPath == AppRoutes.signUpScreen;
  }

  void _delete<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>(force: true);
    }
  }
}
