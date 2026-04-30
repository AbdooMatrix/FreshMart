import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/product_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _future;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _future = ProductService.getAllProducts();
  }

  Future<void> _refresh() async {
    setState(() => _future = ProductService.getAllProducts());
  }

  Future<void> _addToCart(Product p) async {
    try {
      await CartService.addToCart(
          userId: Session.currentUserId, productId: p.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${p.name} added to cart'),
          backgroundColor: AppColors.primaryContainer,
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
      );
    }
  }

  List<Product> _filter(List<Product> all) {
    return all.where((p) {
      final matchesCat = _selectedCategory == 'All' ||
          p.category?.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Fruits', 'Dairy', 'Bakery', 'Meat', 'Grains'];
    return Scaffold(
      appBar: AppTopBar(
        title: 'FreshMart',
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/cart')
              .then((_) => _refresh()),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Search bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.surfaceVariant),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.outline),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (v) => setState(() => _searchQuery = v),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Category chips
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    final selected = cat == _selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primaryContainer
                              : AppColors.secondaryFixed,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: Text(cat.toUpperCase(),
                            style: AppTextStyles.labelBold.copyWith(
                              color: selected
                                  ? AppColors.onPrimary
                                  : AppColors.onSecondaryFixed,
                            )),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Product grid
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: _future,
                  builder: (_, snap) {
                    if (snap.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snap.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48),
                            const SizedBox(height: 12),
                            Text('Failed to load: ${snap.error}'),
                            TextButton(
                                onPressed: _refresh,
                                child: const Text('Retry')),
                          ],
                        ),
                      );
                    }
                    final products = _filter(snap.data ?? []);
                    if (products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSpacing.gutter,
                        mainAxisSpacing: AppSpacing.gutter,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: products.length,
                      itemBuilder: (_, i) => ProductCard(
                        product: products[i],
                        onTap: () => Navigator.pushNamed(
                          context, '/product',
                          arguments: products[i].id,
                        ).then((_) => _refresh()),
                        onAddToCart: () => _addToCart(products[i]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}