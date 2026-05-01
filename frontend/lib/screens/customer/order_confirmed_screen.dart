import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/primary_button.dart';

class OrderConfirmedScreen extends StatelessWidget {
  final OrderModel order;
  const OrderConfirmedScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Order Confirmed',
        leading: const SizedBox.shrink(), // No back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const Spacer(),
            // Big check
            Container(
              width: 96, height: 96,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 48),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('THANK YOU!', style: AppTextStyles.h1),
            const SizedBox(height: AppSpacing.sm),
            Text('Your order has been placed successfully.',
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),

            // Order details card
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ORDER #${order.id}',
                          style: AppTextStyles.labelBold),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.white, size: 12),
                            const SizedBox(width: 4),
                            Text(order.status.toUpperCase(),
                                style: AppTextStyles.labelBold.copyWith(
                                  fontSize: 10, color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  // Items
                  ...order.items.map((it) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${it.productName} x ${it.quantity}',
                            style: AppTextStyles.bodyMd.copyWith(
                                color: AppColors.onSurfaceVariant),
                          ),
                        ),
                        Text(
                          '\$${(it.priceAtPurchase * it.quantity).toStringAsFixed(2)}',
                          style: AppTextStyles.bodyMd,
                        ),
                      ],
                    ),
                  )),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.h2),
                      Text('\$${order.totalAmount.toStringAsFixed(2)}',
                          style: AppTextStyles.h2
                              .copyWith(color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'Back to Home',
              height: 56,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (_) => false),
            ),
          ],
        ),
      ),
    );
  }
}