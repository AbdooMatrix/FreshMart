import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../models/cart_item.dart';
import '../../services/cart_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/quantity_stepper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<CartResponse> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = CartService.getCart(Session.currentUserId);
  }

  Future<void> _refresh() async => setState(_load);

  Future<void> _updateQty(CartItem item, int newQty) async {
    if (newQty < 1) return;
    try {
      await CartService.updateQuantity(
          cartItemId: item.id, quantity: newQty);
      _refresh();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: AppColors.error),
      );
    }
  }

  Future<void> _remove(CartItem item) async {
    try {
      await CartService.removeItem(item.id);
      _refresh();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'My Cart'),
      body: FutureBuilder<CartResponse>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final cart = snap.data!;
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: AppColors.outline),
                  const SizedBox(height: 16),
                  Text('Your cart is empty', style: AppTextStyles.h2),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CONTINUE SHOPPING'),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.gutter),
                  itemBuilder: (_, i) {
                    final item = cart.items[i];
                    return _CartItemTile(
                      item: item,
                      onIncrease: () => _updateQty(item, item.quantity + 1),
                      onDecrease: () => _updateQty(item, item.quantity - 1),
                      onDelete: () => _remove(item),
                    );
                  },
                ),
              ),
              _CartSummary(
                total: cart.total,
                onCheckout: () => Navigator.pushNamed(context, '/checkout',
                    arguments: cart.total)
                    .then((_) => _refresh()),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease, onDecrease, onDelete;
  const _CartItemTile({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      padding: const EdgeInsets.all(AppSpacing.gutter),
      child: Row(
          children: [
      // Thumbnail (uses product_image if backend was tweaked, else placeholder)
      ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.small),
      child: SizedBox(
        width: 64, height: 64,
        child: item.productImage != null
            ? CachedNetworkImage(
          imageUrl: item.productImage!,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Container(
            color: AppColors.surfaceVariant,
            child: const Icon(Icons.image,
                color: AppColors.outline),
          ),
        )
            : Container(
          color: AppColors.surfaceVariant,
          child: const Icon(Icons.shopping_basket,
              color: AppColors.outline),
        ),
      ),
    ),
    const SizedBox(width: AppSpacing.gutter),
    // Name + price
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(item.productName.toUpperCase(),
    style: AppTextStyles.labelBold,
    maxLines: 1, overflow: TextOverflow.ellipsis),
    const SizedBox(height: 4),
    Text('\$${item.productPrice.toStringAsFixed(2)}',
    style: AppTextStyles.bodyMd.copyWith(
    color: AppColors.primaryContainer,
    fontWeight: FontWeight.w500)),
    ],
    ),
    ),
    // Stepper
    QuantityStepper(
    value: item.quantity,
    onChanged: (v) {
    if (v > item.quantity) onIncrease();
    if (v < item.quantity) onDecrease();
    },
    ),
    // Delete
    IconButton(
    icon: const Icon(Icons.delete, color: AppColors.error),
    onPressed: onDelete,
    ),
    ],
    ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;
  const _CartSummary({required this.total, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.outlineVariant)),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 24, offset: Offset(0, -4)),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Subtotal',
            style: AppTextStyles.bodyMd
                .copyWith(color: AppColors.onSurfaceVariant)),
        Text('\$${total.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMd
                .copyWith(color: AppColors.onSurfaceVariant)),
    ],
    ),
    const Divider(height: 24),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('Total', style: AppTextStyles.h2),
    Text('\$${total.toStringAsFixed(2)}',
    style: AppTextStyles.h1
        .copyWith(color: AppColors.primaryContainer)),
    ],
    ),
    const SizedBox(height: AppSpacing.md),
    PrimaryButton(label: 'Checkout', onPressed: onCheckout),
    ],
    ),
    );
  }
}