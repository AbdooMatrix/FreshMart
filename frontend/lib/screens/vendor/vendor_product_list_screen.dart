import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/confirm_dialog.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});
  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = ProductService.getAllProducts();
  }

  Future<void> _refresh() async => setState(_load);

  Future<void> _confirmDelete(Product p) async {
    final ok = await ConfirmDialog.show(
      context,
      title: 'DELETE PRODUCT?',
      message: 'Are you sure you want to delete "${p.name}"? This cannot be undone.',
    );
    if (!ok) return;
    try {
      final success = await ProductService.deleteProduct(p.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? '${p.name} deleted'
              : 'Failed to delete'),
          backgroundColor:
          success ? AppColors.primaryContainer : AppColors.error,
        ),
      );
      if (success) _refresh();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Manage Products',
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.power_settings_new, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Inventory', style: AppTextStyles.h1),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: Text('ADD PRODUCT',
                        style: AppTextStyles.buttonText
                            .copyWith(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.outlineVariant),
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, '/vendor/add-product')
                        .then((_) => _refresh()),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: _future,
                  builder: (_, snap) {
                    if (snap.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snap.hasError) {
                      return Center(child: Text('Error: ${snap.error}'));
                    }
                    final products = snap.data ?? [];
                    if (products.isEmpty) {
                      return const Center(child: Text('No products yet'));
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.surfaceVariant),
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                      child: ListView.separated(
                        itemCount: products.length,
                        separatorBuilder: (_, __) => const Divider(
                            height: 1, color: AppColors.surfaceVariant),
                        itemBuilder: (_, i) => _AdminProductRow(
                          product: products[i],
                          onEdit: () => Navigator.pushNamed(
                            context,
                            '/vendor/edit-product',
                            arguments: products[i],
                          ).then((_) => _refresh()),
                          onDelete: () => _confirmDelete(products[i]),
                        ),
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

class _AdminProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit, onDelete;
  const _AdminProductRow({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: SizedBox(
              width: 64, height: 64,
              child: product.imageUrl != null
                  ? CachedNetworkImage(
                imageUrl: product.imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.surfaceContainer,
                  child: const Icon(Icons.image,
                      color: AppColors.outline),
                ),
              )
                  : Container(
                color: AppColors.surfaceContainer,
                child: const Icon(Icons.image,
                    color: AppColors.outline),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Name + category chip
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(product.name.toUpperCase(),
                    style: AppTextStyles.labelBold,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                if (product.category != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(product.category!.toUpperCase(),
                        style: AppTextStyles.labelBold.copyWith(
                            fontSize: 10, color: Colors.white)),
                  ),
                const SizedBox(height: 4),
                Text('Stock: ${product.stock}',
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 11, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          // Price
          Text('\$${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.h2
                  .copyWith(color: AppColors.primaryContainer)),
          const SizedBox(width: AppSpacing.sm),
          // Actions
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.error),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}