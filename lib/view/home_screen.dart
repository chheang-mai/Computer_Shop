import 'package:computer_shop/view/cart_screen.dart';
import 'package:computer_shop/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:computer_shop/model/product.dart';
import 'package:computer_shop/service/api_service.dart';
import 'package:computer_shop/service/cart_store.dart';
import 'package:computer_shop/model/cartItem.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerCtrl = PageController();
  int _bannerIndex = 0;
  final Future<List<Product>> _productFuture = ApiService().getProduct();

  String _selectedBrand = "All";

  @override
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      final next = (_bannerIndex + 1) % _banners.length;
      _bannerCtrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ stop auto slide
    _bannerCtrl.dispose();
    super.dispose();
  }

  final List<String> _banners = [
    "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=1200&q=80",
    "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1200&q=80",
    "https://images.unsplash.com/photo-1484788984921-03950022c9ef?auto=format&fit=crop&w=1200&q=80",
  ];

  List<String> _buildBrandCategories(List<Product> products) {
    final brands = products
        .map((p) => (p.brand ?? "").trim())
        .where((b) => b.isNotEmpty)
        .toSet()
        .toList();

    brands.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ["All", ...brands];
  }

  bool _matchBrand(Product p) {
    if (_selectedBrand == "All") return true;
    return (p.brand ?? "").trim().toLowerCase() == _selectedBrand.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(" OG Computer "),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },

            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _bannerCtrl,
                      itemCount: _banners.length,
                      onPageChanged: (i) => setState(() => _bannerIndex = i),
                      itemBuilder: (context, i) {
                        return Image.network(
                          _banners[i],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ✅ little gradient for better text/dots visibility
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black.withOpacity(0.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // dots indicator
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_banners.length, (i) {
                        final active = i == _bannerIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 7,
                          width: active ? 18 : 7,
                          decoration: BoxDecoration(
                            color: active
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final allProducts = snapshot.data ?? [];
          if (allProducts.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          // ✅ Build real categories from API (brands)
          final brands = _buildBrandCategories(allProducts);

          // ✅ if selectedBrand not exist anymore, reset
          if (!brands.contains(_selectedBrand)) {
            _selectedBrand = "All";
          }

          final products = allProducts.where(_matchBrand).toList();

          return Column(
            children: [
              // ✅ Category chips (brands)
              SizedBox(
                height: 63,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: brands.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final b = brands[i];
                    final isSelected = b == _selectedBrand;

                    return InkWell(
                      onTap: () => setState(() => _selectedBrand = b),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          b,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Row(
                  children: [
                    Text(
                      "${products.length} items",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _selectedBrand == "All" ? "All Brands" : _selectedBrand,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text("No products matched"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailScreen(product: product),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      color: Colors.black.withOpacity(0.08),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child: Image.network(
                                          product.image ?? "",
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  size: 40,
                                                ),
                                              ),
                                          loadingBuilder:
                                              (context, child, progress) {
                                                if (progress == null)
                                                  return child;
                                                return Container(
                                                  color: Colors.grey.shade200,
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (product.brand ?? ""),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              (product.name ?? ""),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  "\$${(product.price ?? 0).toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          "${product.name ?? "Item"} added to cart ✅",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
