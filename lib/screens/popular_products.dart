import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:product_app/provider/api_provider.dart';
import 'package:product_app/constants/colors.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Product',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Container(
          child: Consumer<ApiProvider>(
            builder: (context, apiProvider, child) {
              if (apiProvider.isProductsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                );
              }

              if (apiProvider.products.isEmpty) {
                return Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: apiProvider.products.length,
                itemBuilder: (context, index) {
                  final product = apiProvider.products[index];
                  return _buildProductCard(product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,

            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                      bottom: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.featuredImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleWishlist(product),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        product.inWishlist
                            ? 'assets/icons/filled_heart.svg'
                            : 'assets/icons/heart.svg',
                        width: 18,
                        height: 18,
                        color: product.inWishlist
                            ? Colors.red
                            : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (double.parse(product.discount) > 0) ...[
                        Text(
                          '₹${product.mrp.toInt()}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                      Text(
                        '₹${product.salePrice.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.orange, size: 14),
                      SizedBox(width: 2),
                      Text(
                        product.avgRating > 0
                            ? product.avgRating.toString()
                            : '4.5',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleWishlist(product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          product.inWishlist
              ? '${product.name} removed from wishlist'
              : '${product.name} added to wishlist',
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
