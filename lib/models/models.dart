class VerifyResponseModel {
  final String? otp;
  final String? accessToken;
  final bool user;

  VerifyResponseModel({
    required this.otp,
    required this.accessToken,
    required this.user,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return VerifyResponseModel(otp: null, accessToken: null, user: false);
    }

    final token = json['token'] as Map<String, dynamic>?;
    return VerifyResponseModel(
      otp: json['otp']?.toString(),
      accessToken: token != null ? token['access']?.toString() : null,
      user: json['user'] == true,
    );
  }
}

class LoginResponseModel {
  final String? accessToken;
  final String? userId;
  final String? message;

  LoginResponseModel({
    required this.accessToken,
    required this.userId,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LoginResponseModel(accessToken: null, userId: null, message: null);
    }
    final token = json['token'] as Map<String, dynamic>?;
    return LoginResponseModel(
      accessToken: token != null ? token['access']?.toString() : null,
      userId: json['user_id']?.toString(),
      message: json['message']?.toString(),
    );
  }
}

class BannerModel {
  final int id;
  final ProductModel? product;
  final CategoryModel? category;
  final String name;
  final String image;
  final int showingOrder;

  BannerModel({
    required this.id,
    this.product,
    this.category,
    required this.name,
    required this.image,
    required this.showingOrder,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      showingOrder: json['showing_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'category': category?.toJson(),
      'name': name,
      'image': image,
      'showing_order': showingOrder,
    };
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String image;
  final bool isActive;
  final int showingOrder;
  final String slug;
  final List<ProductModel> products;
  final String? hexcode1;
  final String? hexcode2;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
    required this.showingOrder,
    required this.slug,
    required this.products,
    this.hexcode1,
    this.hexcode2,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
      showingOrder: json['showing_order'] ?? 0,
      slug: json['slug'] ?? '',
      products:
          (json['products'] as List<dynamic>?)
              ?.map((product) => ProductModel.fromJson(product))
              .toList() ??
          [],
      hexcode1: json['hexcode_1'],
      hexcode2: json['hexcode_2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'is_active': isActive,
      'showing_order': showingOrder,
      'slug': slug,
      'products': products.map((product) => product.toJson()).toList(),
      'hexcode_1': hexcode1,
      'hexcode_2': hexcode2,
    };
  }
}

class ProductModel {
  final int id;
  final List<dynamic> variations;
  final bool inWishlist;
  final double avgRating;
  final List<String> images;
  final bool variationExists;
  final double salePrice;
  final String name;
  final String description;
  final String caption;
  final String featuredImage;
  final double mrp;
  final int stock;
  final bool isActive;
  final String discount;
  final String createdDate;
  final String productType;
  final int? showingOrder;
  final String variationName;
  final int category;
  final int taxRate;

  ProductModel({
    required this.id,
    required this.variations,
    required this.inWishlist,
    required this.avgRating,
    required this.images,
    required this.variationExists,
    required this.salePrice,
    required this.name,
    required this.description,
    required this.caption,
    required this.featuredImage,
    required this.mrp,
    required this.stock,
    required this.isActive,
    required this.discount,
    required this.createdDate,
    required this.productType,
    this.showingOrder,
    required this.variationName,
    required this.category,
    required this.taxRate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      variations: json['variations'] ?? [],
      inWishlist: json['in_wishlist'] ?? false,
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
      variationExists: json['variation_exists'] ?? false,
      salePrice: (json['sale_price'] ?? 0).toDouble(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      caption: json['caption'] ?? '',
      featuredImage: json['featured_image'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      isActive: json['is_active'] ?? false,
      discount: json['discount'] ?? '0',
      createdDate: json['created_date'] ?? '',
      productType: json['product_type'] ?? '',
      showingOrder: json['showing_order'],
      variationName: json['variation_name'] ?? '',
      category: json['category'] ?? 0,
      taxRate: json['tax_rate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variations': variations,
      'in_wishlist': inWishlist,
      'avg_rating': avgRating,
      'images': images,
      'variation_exists': variationExists,
      'sale_price': salePrice,
      'name': name,
      'description': description,
      'caption': caption,
      'featured_image': featuredImage,
      'mrp': mrp,
      'stock': stock,
      'is_active': isActive,
      'discount': discount,
      'created_date': createdDate,
      'product_type': productType,
      'showing_order': showingOrder,
      'variation_name': variationName,
      'category': category,
      'tax_rate': taxRate,
    };
  }
}
