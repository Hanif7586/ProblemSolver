import 'package:flutter/material.dart';

import '../core/services/api_service.dart';
import '../models/register_model.dart';

class RegisterController with ChangeNotifier {

  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    notifyListeners();

    final user = User(
      name: name,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    final result = await _apiService.register(user);

    _isLoading = false;
    _errorMessage = result['success'] ? null : result['message'];
    notifyListeners();

    return result['success'];
  }
}
