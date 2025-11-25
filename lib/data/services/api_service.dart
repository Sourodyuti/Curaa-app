import 'package:dio/dio.dart';
import '../../config/api_config.dart';
import '../../core/utils/storage_helper.dart';
import '../../core/constants/api_constants.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.timeout,
        receiveTimeout: ApiConfig.timeout,
        headers: {
          ApiConstants.contentType: 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageHelper.getToken();
          if (token != null) {
            options.headers[ApiConstants.authorization] =
            '${ApiConstants.bearer} $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          _handleError(error);
          return handler.next(error);
        },
      ),
    );
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw Exception('Connection timeout');
      case DioExceptionType.badResponse:
        throw Exception(error.response?.data['message'] ?? 'Server error');
      case DioExceptionType.cancel:
        throw Exception('Request cancelled');
      default:
        throw Exception('Network error');
    }
  }

  // Generic methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
