import 'package:biggroceryapp/core/network/api_client.dart';
import 'package:biggroceryapp/core/network/api_endpoints.dart';
import 'package:biggroceryapp/core/network/api_exception.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final TextEditingController emailController = TextEditingController(
    text: 'john@mail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'changeme',
  );

  bool isLoggingIn = false;
  String? loginError;

  Future<void> login() async {
    if (isLoggingIn) return;

    isLoggingIn = true;
    loginError = null;
    update(['login']);

    try {
      final response = await ApiClient.instance.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {
          'email': emailController.text.trim(),
          'password': passwordController.text,
        },
      );

      final token = response.data?['access_token']?.toString();
      if (token == null || token.isEmpty) {
        throw const ApiException(message: 'Login token was not returned.');
      }

      ApiClient.instance.setAuthToken(token);

      final homeController = Get.isRegistered<HomeController>()
          ? Get.find<HomeController>()
          : Get.put(HomeController(), permanent: true);

      await homeController.loadInitialData();

      if (homeController.productsError != null ||
          homeController.categoriesError != null ||
          homeController.apiProducts.isEmpty ||
          homeController.categories.isEmpty) {
        throw const ApiException(message: 'Unable to load home data.');
      }

      isLoggingIn = false;
      update(['login']);
      AppRouter.go(AppRoutes.homeScreen);
      return;
    } on ApiException catch (error) {
      loginError = error.message;
    } catch (_) {
      loginError = 'Unable to login. Please try again.';
    }

    isLoggingIn = false;
    update(['login']);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
