import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zegen_test_app/app/models/product_model.dart';
import 'package:zegen_test_app/app/utils/api_endpoints.dart';
import 'package:zegen_test_app/app/models/user_model.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  String? _token;
  static const _kTokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    _token = token;
    await sp.setString(_kTokenKey, token);
  }

  Future<String?> loadToken() async {
    if (_token != null) return _token;
    final sp = await SharedPreferences.getInstance();
    _token = sp.getString(_kTokenKey);
    _token = _token;
    return _token;
  }

  Future<String> login(String username, String password) async {
    final uri = Uri.parse(ApiEndpoints.login);
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final body = resp.body;
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final json = jsonDecode(body) as Map<String, dynamic>;
      final token = json['token'] as String?;
      if (token == null) {
        throw ApiException('Token not found in response');
      }
      await saveToken(token);
      return token;
    } else {
      try {
        final json = jsonDecode(body) as Map<String, dynamic>;
        final msg = (json['message'] ?? json['error'] ?? body).toString();
        throw ApiException(msg);
      } catch (_) {
        throw ApiException(body.isNotEmpty ? body : 'Login failed');
      }
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final uri = Uri.parse(ApiEndpoints.users);
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List<dynamic>;
      return data.map((e) => UserModel.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      throw ApiException('Failed to load users');
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    final uri = Uri.parse(ApiEndpoints.products);
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List<dynamic>;
      return data
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      throw ApiException('Failed to fetch products');
    }
  }
}