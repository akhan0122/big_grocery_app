class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.escuelajs.co/api/v1',
  );

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String products = '/products';
  static const String categories = '/categories';

  static String productDetails(int id) => '$products/$id';
}
