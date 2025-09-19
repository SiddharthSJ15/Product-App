import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:product_app/provider/api_provider.dart';
import 'package:product_app/constants/colors.dart';

class LatestProduct extends StatefulWidget {
  const LatestProduct({super.key});

  @override
  State<LatestProduct> createState() => _LatestProductState();
}

class _LatestProductState extends State<LatestProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 👇 calculate card width like GridView
    final double screenWidth = MediaQuery.of(context).size.width;
    final double spacing = 16;
    final double cardWidth = (screenWidth - (spacing * 3)) / 2;
    final double cardHeight = cardWidth / 0.7; // same aspect ratio

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Latest Products",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Consumer<ApiProvider>(
          builder: (context, apiProvider, child) {
            if (apiProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            }

            if (apiProvider.products.isEmpty) {
              return const Center(
                child: Text(
                  "No latest products available",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            }

            return SizedBox(
              height: cardHeight, // ✅ same as PopularProducts
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: apiProvider.products.length,
                separatorBuilder: (_, __) => SizedBox(width: spacing),
                itemBuilder: (context, index) {
                  final product = apiProvider.products[index];
                  return SizedBox(
                    width: cardWidth,
                    child: _buildProductCard(product),
                  );
                },
              ),
            );
          },
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
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                    bottom: Radius.circular(12),
                  ),
                  child: Image.network(
                    product.featuredImage,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
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
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleWishlist(product),
                    child: Container(
                      padding: const EdgeInsets.all(4),
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
              padding: const EdgeInsets.all(8),
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
                        const SizedBox(width: 4),
                      ],
                      Text(
                        '₹${product.salePrice.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 2),
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
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
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
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
