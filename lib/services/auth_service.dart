import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal() {
    _users.add(User(
      id: 'default_user_1',
      username: 'Razi',
      email: 'rzshaaban@gmail.com',
      password: 'asdzxc',
    ));
  }

  final List<User> _users = [];
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  String? register({
    required String username,
    required String email,
    required String password,
  }) {
    if (username.isEmpty) return 'Username is required';
    if (email.isEmpty) return 'Email is required';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';

    if (_users.any((user) => user.email.toLowerCase() == email.toLowerCase())) {
      return 'Email already registered';
    }

    if (_users.any((user) => user.username.toLowerCase() == username.toLowerCase())) {
      return 'Username already taken';
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      email: email,
      password: password,
    );

    _users.add(newUser);
    notifyListeners();
    return null;
  }

  String? signIn({
    required String email,
    required String password,
  }) {
    if (email.isEmpty) return 'Email is required';
    if (password.isEmpty) return 'Password is required';

    try {
      final user = _users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );

      if (user.password != password) {
        return 'Invalid password';
      }

      _currentUser = user;
      notifyListeners();
      return null;
    } catch (e) {
      return 'User not found';
    }
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }

  List<User> getAllUsers() => List.unmodifiable(_users);
}
