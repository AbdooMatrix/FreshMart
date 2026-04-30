import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StockBadge extends StatelessWidget {
  final int stock;
  const StockBadge({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final low = stock <= 5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: low
            ? AppColors.errorContainer
            : AppColors.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        stock == 0 ? 'OUT OF STOCK' : 'In Stock: $stock',
        style: AppTextStyles.labelBold.copyWith(
          color: low ? AppColors.error : AppColors.primaryContainer,
        ),
      ),
    );
  }
}