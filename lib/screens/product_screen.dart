import 'package:flutter/material.dart';
import 'package:product_app/screens/banner_screen.dart';
import 'package:product_app/screens/popular_products.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [_search()]),
              const SizedBox(height: 20),
              BannerScreen(),
              const SizedBox(height: 20),
              PopularProducts(),
              const SizedBox(height: 92),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _search() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(65),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(116, 116, 116, 0.1),
              offset: const Offset(0, 4),
              blurRadius: 25,
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            hintText: 'Search products',
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade400,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.search),
                ],
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
