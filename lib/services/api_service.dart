import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_app/models/models.dart';
import 'package:product_app/constants/token_manager.dart';

class ApiService {
  final String baseUrl = "https://skilltestflutter.zybotechlab.com/api";
  final TokenManager _tokenManager = TokenManager();

  Future<VerifyResponseModel?> verifyService(String number) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify/'),
        body: {'phone_number': number},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final verifyResponse = VerifyResponseModel.fromJson(data);
        return verifyResponse;
      } else {
        print("Failed to verify user: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error verifying user: $e");
      return null;
    }
  }

  Future<LoginResponseModel?> loginService(String number, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login-register/'),
        body: {'phone_number': number, 'first_name': name},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponseModel.fromJson(data);
        return loginResponse;
      } else {
        print("Failed to login/register: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error in login/register: $e");
      return null;
    }
  }

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final token = await _tokenManager.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/banners/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        print("Failed to load banners: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching banners: $e");
      return [];
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final token = await _tokenManager.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/products/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        print("Failed to load products: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
