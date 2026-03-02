import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    AppRouter.registerControllers();
  }
}
