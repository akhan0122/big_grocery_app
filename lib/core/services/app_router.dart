// lib/core/routes/app_router.dart
import 'package:biggroceryapp/core/services/observer_router.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/authentication/presentation/create_account.dart';
import 'package:biggroceryapp/features/authentication/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

// screens
import 'package:biggroceryapp/features/splash/presentation/splash_screen.dart';
import 'package:biggroceryapp/features/authentication/presentation/authentication_screen.dart';
import 'package:biggroceryapp/features/home/presentation/home_screen.dart';

// controllers
import 'package:biggroceryapp/features/splash/logic/splash_controller.dart';
import 'package:biggroceryapp/features/authentication/logic/authentication_controller.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';

class AppRouter {
  AppRouter._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    observers: [AppRouterObserver()],
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) {
          _register<SplashController>(() => SplashController());
          return null;
        },
      ),

      GoRoute(
        path: AppRoutes.authentication,
        name: 'authentication',
        builder: (context, state) => const AuthenticationScreen(),
        redirect: (context, state) {
          _register<AuthenticationController>(() => AuthenticationController());
          return null;
        },
      ),

      GoRoute(
        path: AppRoutes.loginScreen,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        redirect: (context, state) {
          _register<AuthenticationController>(() => AuthenticationController());
          return null;
        },
      ),

      GoRoute(
        path: AppRoutes.signUpScreen,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
        redirect: (context, state) {
          _register<AuthenticationController>(() => AuthenticationController());
          return null;
        },
      ),

      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        redirect: (context, state) {
          _register<HomeController>(() => HomeController());
          return null;
        },
      ),
    ],
  );

  static void _register<T>(T Function() builder) {
    if (!Get.isRegistered<T>()) {
      Get.lazyPut<T>(builder);
    }
  }

  static void go(String route) => router.go(route);
  static Future<T?> push<T>(String route) => router.push<T>(route);
  static void pop(BuildContext context) => GoRouter.of(context).pop();
}
