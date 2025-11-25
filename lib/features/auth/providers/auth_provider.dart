import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/dio_client.dart';

// 1. Provider for Secure Storage
final storageProvider = Provider((ref) => const FlutterSecureStorage());

// 2. Provider for Dio Client
final dioClientProvider = Provider((ref) {
  return DioClient(Dio(), ref.watch(storageProvider));
});

// 3. Auth State Class
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  AuthState({this.isAuthenticated = false, this.isLoading = false, this.error});

  AuthState copyWith({bool? isAuthenticated, bool? isLoading, String? error}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 4. Auth Controller (Updated to Notifier)
class AuthNotifier extends Notifier<AuthState> {
  late final Dio _dio;
  late final FlutterSecureStorage _storage;

  @override
  AuthState build() {
    // Initialize dependencies
    _dio = ref.read(dioClientProvider).dio;
    _storage = ref.read(storageProvider);

    // Check initial status
    checkLoginStatus();

    return AuthState(); // Initial state
  }

  Future<void> checkLoginStatus() async {
    final token = await _storage.read(key: 'token');
    if (token != null) {
      state = state.copyWith(isAuthenticated: true);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _dio.post(ApiConstants.authLogin, data: {
        'email': email,
        'password': password,
      });

      final token = response.data['token'];
      await _storage.write(key: 'token', value: token);

      state = state.copyWith(isAuthenticated: true, isLoading: false);
      return true;
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? 'Login failed',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    state = state.copyWith(isAuthenticated: false);
  }
}

// 5. The Provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});