import '../services/api_service.dart';
import '../models/user_model.dart';
import '../../config/api_config.dart';
import '../../core/utils/storage_helper.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['token'];
      final user = UserModel.fromJson(response.data['user']);

      // Save token and user data
      await StorageHelper.saveToken(token);
      await StorageHelper.saveString('userId', user.id);
      await StorageHelper.saveString('userEmail', user.email);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.signup,
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );

      final token = response.data['token'];
      final user = UserModel.fromJson(response.data['user']);

      await StorageHelper.saveToken(token);
      await StorageHelper.saveString('userId', user.id);
      await StorageHelper.saveString('userEmail', user.email);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> logout() async {
    await StorageHelper.clearAll();
  }

  Future<bool> isLoggedIn() async {
    final token = await StorageHelper.getToken();
    return token != null;
  }
}
