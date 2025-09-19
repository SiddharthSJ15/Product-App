import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/screens/product_screen.dart';
import 'package:product_app/screens/profile_screen.dart';
import 'package:product_app/screens/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Screens for navigation
  final List<Widget> _pages = const [
    ProductScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  // Navigation items data
  final List<NavItem> _navItems = [
    NavItem(svgPath: 'assets/icons/home_icon.svg', label: 'Products'),
    NavItem(svgPath: 'assets/icons/wishlist_icon.svg', label: 'Wishlist'),
    NavItem(svgPath: 'assets/icons/profile.svg', label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          // Use a SizedBox.expand() or another widget to fill the screen
          SizedBox.expand(
            child: _pages[_selectedIndex],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(37),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  right: _selectedIndex != 2 ? 16 : 8,
                  bottom: 8,
                  left: _selectedIndex != 0 || _selectedIndex == 1 ? 16 : 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _navItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    NavItem item = entry.value;
                    bool isSelected = _selectedIndex == index;

                    return isSelected
                        ? Container(
                            width: 119,
                            height: 56,
                            child: GestureDetector(
                              onTap: () => _onItemTapped(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63FF),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      item.svgPath,
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Transform.scale(
                                            scale: _animation.value,
                                            child: Text(
                                              item.label,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _onItemTapped(index),
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: SvgPicture.asset(
                                  item.svgPath,
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey.shade600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final String svgPath;
  final String label;

  NavItem({required this.svgPath, required this.label});
}