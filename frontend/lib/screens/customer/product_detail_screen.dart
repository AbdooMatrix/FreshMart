import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../models/product.dart';
import '../../services/cart_service.dart';
import '../../services/product_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/quantity_stepper.dart';
import '../../widgets/stock_badge.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _future;
  int _quantity = 1;
  bool _adding = false;

  @override
  void initState() {
    super.initState();
    _future = ProductService.getProductById(widget.productId);
  }

  Future<void> _addToCart(Product p) async {
    setState(() => _adding = true);
    try {
      await CartService.addToCart(
        userId: Session.currentUserId,
        productId: p.id, quantity: _quantity,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added $_quantity × ${p.name} to cart'),
            backgroundColor: AppColors.primaryContainer),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: AppColors.error),
      );
    } finally {
      if (mounted) setState(() => _adding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Product Details',
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
      body: FutureBuilder<Product>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final p = snap.data!;
          return Column(
            children: [
              // Image (260px)
              SizedBox(
                height: 260, width: double.infinity,
                child: Container(
                  color: AppColors.surfaceContainerHigh,
                  child: p.imageUrl != null
                      ? CachedNetworkImage(imageUrl: p.imageUrl!, fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.broken_image, size: 64, color: AppColors.outline))
                      : const Icon(Icons.image, size: 64),
                ),
              ),

              // Details Card
              Expanded(
                child: Container(
                  width: double.infinity, color: AppColors.surface,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(p.name.toUpperCase(), style: AppTextStyles.h1)),
                          Text('\$${p.price.toStringAsFixed(2)}',
                              style: AppTextStyles.h1.copyWith(color: AppColors.primaryContainer)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(),
                      const SizedBox(height: AppSpacing.sm),

                      Text(p.description ?? 'No description available.',
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: AppSpacing.md),

                      // 🆕 VENDOR ROW
                      _VendorRow(name: p.vendorName ?? 'Vendor User'),
                      const SizedBox(height: AppSpacing.md),

                      StockBadge(stock: p.stock),

                      const Spacer(),

                      Text('QUANTITY', style: AppTextStyles.labelBold),
                      const SizedBox(height: AppSpacing.sm),
                      QuantityStepper(
                        value: _quantity, max: p.stock, large: true,
                        onChanged: (v) => setState(() => _quantity = v),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      PrimaryButton(
                        label: 'Add to Cart', loading: _adding, height: 56,
                        onPressed: p.stock == 0 ? null : () => _addToCart(p),
                      ),
                    ],
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

/// The new "SOLD BY" row.
class _VendorRow extends StatelessWidget {
  final String name;
  const _VendorRow({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32, height: 32,
          decoration: const BoxDecoration(
            color: AppColors.secondaryFixed,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.storefront,
              color: AppColors.primaryContainer, size: 18),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SOLD BY', style: AppTextStyles.labelBold.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 2),
            Text(name, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}