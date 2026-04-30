import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Two sizes: compact (cart) and large (product detail).
class QuantityStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final bool large;

  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    if (large) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bigBtn(Icons.remove, value > min ? () => onChanged(value - 1) : null),
          const SizedBox(width: 16),
          SizedBox(
            width: 32,
            child: Text('$value',
                textAlign: TextAlign.center, style: AppTextStyles.h2),
          ),
          const SizedBox(width: 16),
          _bigBtn(Icons.add, value < max ? () => onChanged(value + 1) : null),
        ],
      );
    }
    // compact (cart row)
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _smallBtn(Icons.remove, value > min ? () => onChanged(value - 1) : null),
          SizedBox(
            width: 28,
            child: Text('$value',
                textAlign: TextAlign.center, style: AppTextStyles.labelBold),
          ),
          _smallBtn(Icons.add, value < max ? () => onChanged(value + 1) : null),
        ],
      ),
    );
  }

  Widget _bigBtn(IconData icon, VoidCallback? onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.lg),
    child: Container(
      width: 48, height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryContainer),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Icon(icon, color: AppColors.primaryContainer),
    ),
  );

  Widget _smallBtn(IconData icon, VoidCallback? onTap) => InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 32, height: 32,
      child: Icon(icon, size: 16, color: AppColors.onSurface),
    ),
  );
}