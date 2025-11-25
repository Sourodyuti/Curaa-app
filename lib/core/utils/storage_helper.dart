import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class StorageHelper {
  static final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Secure Storage (for sensitive data like tokens)
  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: StorageKeys.token, value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: StorageKeys.token);
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: StorageKeys.token);
  }

  // Regular Storage
  static Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs?.clear();
  }
}
