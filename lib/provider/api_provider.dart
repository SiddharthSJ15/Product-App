import 'package:flutter/widgets.dart';
import 'package:product_app/models/models.dart';
import 'package:product_app/services/api_service.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService _service = ApiService();

  bool _isLoading = false;
  List<BannerModel> _banners = [];
  bool get isLoading => _isLoading;
  bool _isProductsLoading = false;
  bool get isProductsLoading => _isProductsLoading;
  List<BannerModel> get banners => _banners;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductModel? _selectedProduct;

  ProductModel? get selectedProduct => _selectedProduct;

  Future<void> fetchBanners() async {
    _isLoading = true;
    notifyListeners();
    try {
      final fetchedBanners = await _service.fetchBanners();
      _banners = fetchedBanners;
    } catch (e) {
      print("Error fetching banners: $e");
      _banners = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshBanners() async {
    await fetchBanners();
  }

  Future<void> fetchProducts() async {
    _isProductsLoading = true;
    notifyListeners();
    try {
      final fetchedProducts = await _service.fetchProducts();
      _products = fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
      _products = [];
    } finally {
      _isProductsLoading = false;
      notifyListeners();
    }
  }
}
