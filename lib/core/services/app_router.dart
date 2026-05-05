// lib/core/routes/app_router.dart
import 'package:biggroceryapp/core/services/observer_router.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/authentication/presentation/create_account.dart';
import 'package:biggroceryapp/features/authentication/presentation/login_screen.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/presentation/dummy_nav_screen.dart';
import 'package:biggroceryapp/features/home/presentation/home_sceen.dart';
import 'package:biggroceryapp/features/home/presentation/product_detail_screen.dart';
import 'package:biggroceryapp/features/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

// screens
import 'package:biggroceryapp/features/splash/presentation/splash_screen.dart';
import 'package:biggroceryapp/features/authentication/presentation/welcome_screen.dart';
import 'package:biggroceryapp/features/landing/presentation/landing_screen.dart';

// controllers
import 'package:biggroceryapp/features/splash/logic/splash_controller.dart';
import 'package:biggroceryapp/features/authentication/logic/authentication_controller.dart';
import 'package:biggroceryapp/features/landing/logic/landing_controller.dart';

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
        path: AppRoutes.landing,
        name: 'landing',
        builder: (context, state) => const LandingScreen(),
        redirect: (context, state) {
          _register<LandingController>(() => LandingController());
          return null;
        },
      ),

      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
        redirect: (context, state) {
          _register<HomeController>(() => HomeController());
          return null;
        },
      ),
      GoRoute(
        path: AppRoutes.profileScreen,
        name: AppRoutes.profileScreen,
        builder: (context, state) => const DummyNavScreen(
          title: 'Profile',
          icon: Icons.person_outline,
          activeItem: HomeNavItem.profile,
        ),
      ),
      GoRoute(
        path: AppRoutes.favoritesScreen,
        name: AppRoutes.favoritesScreen,
        builder: (context, state) => const DummyNavScreen(
          title: 'Favorites',
          icon: Icons.favorite_border,
          activeItem: HomeNavItem.favorites,
        ),
      ),
      GoRoute(
        path: AppRoutes.cartScreen,
        name: AppRoutes.cartScreen,
        builder: (context, state) => const DummyNavScreen(
          title: 'Cart',
          icon: Icons.shopping_bag_outlined,
          activeItem: HomeNavItem.cart,
        ),
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        name: AppRoutes.productDetails,
        builder: (context, state) {
          final productId = int.tryParse(state.pathParameters['id'] ?? '');
          return ProductDetailScreen(productId: productId);
        },
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

  static void go(String route, {Object? extra}) => router.go(route, extra: extra);
  static Future<T?> push<T>(String route, {Object? extra}) =>
      router.push<T>(route, extra: extra);
  static void pop(BuildContext context) => GoRouter.of(context).pop();
}
