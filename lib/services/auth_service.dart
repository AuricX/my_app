import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    if (username.isEmpty) return 'Username is required';
    if (email.isEmpty) return 'Email is required';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';

    try {
      final response = await ApiService.post(
        '/register',
        body: {
          'name': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        
        _currentUser = User(
          id: data['id'].toString(),
          username: data['name'] ?? data['username'] ?? username,
          email: data['email'] ?? email,
          password: password,
        );
        
        notifyListeners();
        return null;
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      return 'Connection error. Please check your backend is running. Error: $e';
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) return 'Email is required';
    if (password.isEmpty) return 'Password is required';

    try {
      final response = await ApiService.post(
        '/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        _currentUser = User(
          id: data['id'].toString(),
          username: data['name'] ?? data['username'] ?? '',
          email: data['email'] ?? email,
          password: password,
        );
        
        notifyListeners();
        return null;
      } else {
        return 'Invalid email or password';
      }
    } catch (e) {
      return 'Connection error. Please check your backend is running. Error: $e';
    }
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }
}
