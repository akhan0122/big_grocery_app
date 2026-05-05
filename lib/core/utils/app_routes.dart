class AppRoutes {
  static const String splash = '/splash';
  static const String landing = '/landing';
  static const String authentication = '/authentication';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String homeScreen = '/homeScreen';
  static const String profileScreen = '/profileScreen';
  static const String favoritesScreen = '/favoritesScreen';
  static const String cartScreen = '/cartScreen';
  static const String productDetails = '/productDetails/:id';

  static String productDetailsById(int id) => '/productDetails/$id';
}
