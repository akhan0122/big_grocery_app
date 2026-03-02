import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/presentation/home_screen.dart';
import 'package:biggroceryapp/features/splash/logic/splash_controller.dart';
import 'package:biggroceryapp/features/splash/presentation/splash_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) {
          _lazyPutController<SplashController>(() => SplashController());
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) {
          _lazyPutController<HomeController>(() => HomeController());
          return const HomeScreen();
        },
      ),
    ],
  );

  static void registerControllers() {
    _lazyPutController<SplashController>(() => SplashController());
    _lazyPutController<HomeController>(() => HomeController());
  }

  static void _lazyPutController<T>(T Function() builder) {
    if (!Get.isRegistered<T>()) {
      Get.lazyPut<T>(builder, fenix: true);
    }
  }
}
