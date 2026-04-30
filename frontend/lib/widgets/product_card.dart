import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;        // Tap card → product detail
  final VoidCallback onAddToCart;  // Tap "+" → POST /cart/add

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.surfaceVariant),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          // Image area
          Expanded(
          child: Container(
          color: AppColors.surfaceContainerHigh,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: _buildImage(),
          ),
        ),
        // Footer
        Container(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.surfaceVariant)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              product.name.toUpperCase(),
          style: AppTextStyles.labelBold,
          maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        Text('\$${product.price.toStringAsFixed(2)}',
        style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant)),
    InkWell(
    onTap: onAddToCart,
    borderRadius: BorderRadius.circular(AppRadius.full),
    child: Container(
    width: 32, height: 32,
    decoration: const BoxDecoration(
    color: AppColors.primaryContainer,
    shape: BoxShape.circle,
    ),
    child: const Icon(Icons.add,
    color: Colors.white, size: 18),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }

  Widget _buildImage() {
    if (product.imageUrl == null || product.imageUrl!.isEmpty) {
      return const Icon(Icons.image, size: 48, color: AppColors.outline);
    }
    return CachedNetworkImage(
      imageUrl: product.imageUrl!,
      fit: BoxFit.contain,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (_, __, ___) =>
      const Icon(Icons.broken_image, size: 48, color: AppColors.outline),
    );
  }
}