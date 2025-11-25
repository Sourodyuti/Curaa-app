class ApiConfig {
  // Update with your actual backend URL
  static const String baseUrl = 'https://your-backend-url.com';

  // Or for local development:
  // static const String baseUrl = 'http://localhost:3000';
  // For Android emulator accessing localhost:
  // static const String baseUrl = 'http://10.0.2.2:3000';

  static const Duration timeout = Duration(seconds: 30);

  // API Endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String products = '/products';
  static const String services = '/services';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String pets = '/api/pets';
  static const String users = '/users';
}
