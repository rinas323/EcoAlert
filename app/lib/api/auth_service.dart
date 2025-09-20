import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class AuthService {
  static Uri _url(String path) => Uri.parse('${ApiConfig.baseUrl}$path');

  /// Logs in with email and password
  /// Returns a map: { token: string, user: { id, username, email, first_name, last_name } }
  static Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final resp = await http.post(
      _url(ApiConfig.loginPath),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return jsonDecode(resp.body) as Map<String, dynamic>;
    } else {
      try {
        final body = jsonDecode(resp.body);
        throw Exception(body['detail'] ?? 'Login failed (${resp.statusCode})');
      } catch (_) {
        throw Exception('Login failed (${resp.statusCode})');
      }
    }
  }

  /// Signs up a new user
  /// Returns a map: { token: string, user: { ... } }
  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    final resp = await http.post(
      _url(ApiConfig.signupPath),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'first_name': firstName ?? '',
        'last_name': lastName ?? '',
        'phone': phone ?? '',
      }),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return jsonDecode(resp.body) as Map<String, dynamic>;
    } else {
      try {
        final body = jsonDecode(resp.body);
        throw Exception(body['detail'] ?? 'Signup failed (${resp.statusCode})');
      } catch (_) {
        throw Exception('Signup failed (${resp.statusCode})');
      }
    }
  }
}
