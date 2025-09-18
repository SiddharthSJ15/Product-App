import 'package:flutter/material.dart';
import 'package:product_app/constants/token_manager.dart';
import 'package:product_app/models/response_model.dart';
import 'package:product_app/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _service = ApiService();
  bool _isLoading = false;
  VerifyResponseModel? _verifyResponse;
  LoginResponseModel? _loginResponse;
  bool get isLoading => _isLoading;
  VerifyResponseModel? get verifyResponse => _verifyResponse;
  LoginResponseModel? get loginResponse => _loginResponse;

  Future<void> verifyUser(String number) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.verifyUser(number);
      if (response!.user == true) {
        await TokenManager().saveToken(response.accessToken);
        _verifyResponse = response;
      } else {}
    } catch (e) {
      print("Error in verifyUser: $e");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loginRegister(String number, String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.loginRegister(number, name);
      if (response != null) {
        await TokenManager().saveToken(response.accessToken);
        _loginResponse = response;
      } else {}
    } catch (e) {
      print("Error in loginRegister: $e");
    } finally {
      _isLoading = false;
    }
  }
}
