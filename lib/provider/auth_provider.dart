import 'package:flutter/material.dart';
import 'package:product_app/constants/token_manager.dart';
import 'package:product_app/models/models.dart';
import 'package:product_app/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _service = ApiService();
  bool _isLoading = false;
  VerifyResponseModel? _verifyResponse;
  LoginResponseModel? _loginResponse;
  bool get isLoading => _isLoading;
  VerifyResponseModel? get verifyResponse => _verifyResponse;
  LoginResponseModel? get loginResponse => _loginResponse;
  String? _phoneNumber = '';
  String? get phoneNumber => _phoneNumber;
  bool _newUser = false;
  bool get newUser => _newUser;

  Future<bool> verifyUser(String number) async {
    print(number);
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.verifyService(number);
      print(response?.otp);
      if (response == null) {
        _verifyResponse = null;
        return false;
      }

      // save token if available and user is registered
      if (response.user == true && response.accessToken != null) {
        _verifyResponse = response;
        final token = response.accessToken!;
        await TokenManager().saveToken(token);
        return true;
      }

      if (response.user == false) {
        _verifyResponse = response;
        _newUser = true;
        _phoneNumber = number;
        return false;
      }

      return response.user == true;
    } catch (e) {
      print("Error in verifyUser: $e");
      _verifyResponse = null;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loginRegister(String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.loginService(_phoneNumber!, name);
      print(response?.message);

      final token = response?.accessToken;
      if (token != null) {
        await TokenManager().saveToken(token);
        _loginResponse = response;
        return true;
      } else {
        _loginResponse = response;
        return false;
      }
    } catch (e) {
      print("Error in loginRegister: $e");
      throw Exception('Login/Register failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}
