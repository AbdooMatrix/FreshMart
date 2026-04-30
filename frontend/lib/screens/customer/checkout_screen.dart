import 'package:flutter/material.dart';
import '../../config/session.dart';
import '../../models/order.dart';
import '../../services/cart_service.dart';
import '../../services/order_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_header.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressCtrl = TextEditingController();
  late Future<CartResponse> _cartFuture;
  bool _placing = false;

  @override
  void initState() {
    super.initState();
    _cartFuture = CartService.getCart(Session.currentUserId);
  }

  Future<void> _placeOrder() async {
    if (_addressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a shipping address'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() => _placing = true);
    try {
      final OrderModel order = await OrderService.checkout(
        userId: Session.currentUserId,
        shippingAddress: _addressCtrl.text.trim(),
        paymentMethod: 'COD',
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/order-confirmed',
          arguments: order);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _placing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Checkout'),
      body: FutureBuilder<CartResponse>(
        future: _cartFuture,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || snap.data == null) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final cart = snap.data!;
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
            Expanded(
            child: ListView(
            children: [
              // Order Summary
              _Card(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader('ORDER SUMMARY'),
                ...cart.items.map((item) => Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                  Expanded(
                  child: Text(
                  '${item.productName} x ${item.quantity}',
                    style: AppTextStyles.bodyMd,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                    Text(
                        '\$${item.subtotal.toStringAsFixed(2)}',
                    style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600)),
              ],
            ),
          )),
          const Divider(),
          Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
          Text('Total', style: AppTextStyles.h2),
          Text(
          '\$${cart.total.toStringAsFixed(2)}',
          style: AppTextStyles.h2.copyWith(
          color: AppColors.primaryContainer)),
          ],
          ),
          ],
          ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Shipping
          _Card(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SectionHeader('SHIPPING'),
          TextField(
          controller: _addressCtrl,
          maxLines: 3,
          decoration: const InputDecoration(
          hintText: 'SHIPPING ADDRESS',
          ),
          ),
          ],
          ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Payment (COD only — fixed by spec)
          _Card(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SectionHeader('PAYMENT'),
          Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
          border: Border.all(
          color: AppColors.primaryContainer),
          borderRadius:
          BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
          children: [
          const Text('💵', style: TextStyle(fontSize: 24)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
          child: Text('Cash on Delivery',
          style: AppTextStyles.bodyMd.copyWith(
          fontWeight: FontWeight.w600)),
          ),
          const Icon(Icons.check_circle,
          color: AppColors.primaryContainer),
          ],
          ),
          ),
          ],
          ),
          ),
          ],
          ),
          ),
          PrimaryButton(
          label: 'Place Order',
          loading: _placing,
          height: 56,
          onPressed: cart.items.isEmpty ? null : _placeOrder,
          ),
          ],
          ),
          );
          },
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.surfaceVariant),
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    child: child,
  );
}